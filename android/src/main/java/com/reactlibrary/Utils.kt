@file:Suppress("UNCHECKED_CAST", "FunctionName")

package com.reactlibrary

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.drawable.BitmapDrawable
import android.util.Base64
import com.regula.facesdk.callback.PersonDBCallback
import com.regula.facesdk.model.results.personDb.DbBaseItem
import com.regula.facesdk.model.results.personDb.PageableItemList
import org.json.JSONArray
import org.json.JSONObject
import java.io.ByteArrayOutputStream
import kotlin.math.sqrt

interface Callback {
    fun success(o: Any? = null)
    fun error(s: String?)
}

private var hashMap = java.util.HashMap::class.java
private var arrayList = java.util.ArrayList::class.java
private fun arrayListToJSONArray(input: java.util.ArrayList<*>?): JSONArray? {
    input ?: return null
    val result = JSONArray()
    for (i in input.indices) when (input[i].javaClass) {
        hashMap -> result.put(hashMapToJSONObject(input[i] as java.util.HashMap<String, *>))
        arrayList -> result.put(arrayListToJSONArray(input[i] as java.util.ArrayList<*>))
        else -> result.put(input[i])
    }
    return result
}

private fun hashMapToJSONObject(input: java.util.HashMap<String, *>?): JSONObject? {
    input ?: return null
    val result = JSONObject()
    for ((key, value) in input) when (value.javaClass) {
        hashMap -> result.put(key, hashMapToJSONObject(value as java.util.HashMap<String, *>?))
        arrayList -> result.put(key, arrayListToJSONArray(value as java.util.ArrayList<*>))
        else -> result.put(key, value)
    }
    return result
}

fun makeArgs(args: Any): java.util.ArrayList<Any> = args as java.util.ArrayList<Any>

fun <T> args(args: ArrayList<Any?>, index: Int): T? = when (args[index]!!.javaClass) {
    hashMap -> hashMapToJSONObject(args[index] as java.util.HashMap<String, *>?) as T?
    arrayList -> arrayListToJSONArray(args[index] as java.util.ArrayList<*>?) as T?
    else -> args[index] as T?
}

interface JSONObjectGenerator<T> {
    fun generateJSONObject(param: T?): JSONObject?
}

interface FromJSONGenerator<T> {
    fun fromJSON(input: JSONObject?): T?
}

fun <T> listFromJSON(input: JSONArray?, generator: FromJSONGenerator<T>): List<T?>? {
    input ?: return null
    val result = mutableListOf<T?>()
    for (i in 0 until input.length())
        result.add(generator.fromJSON(input.getJSONObject(i)))
    return result
}

fun <T> generateList(input: List<T>?, generator: JSONObjectGenerator<T>): JSONArray? {
    input ?: return null
    val result = JSONArray()
    for (t in input) if (t != null) result.put(generator.generateJSONObject(t))
    return result
}

fun <T> generateArray(input: Array<T>?): JSONArray? {
    input ?: return null
    val result = JSONArray()
    for (i in input.indices) result.put(i, input[i])
    return result
}

fun JSONObject.forEach(action: (String, Any?) -> Unit) {
    val keys: Iterator<String> = keys()
    while (keys.hasNext()) {
        val key = keys.next()
        action(key, get(key))
    }
}

fun <T> JSONArray.forEach(action: (Int, T) -> Unit) {
    for (i in 0..length())
        action(i, get(i) as T)
}

fun <T> createPersonDBCallback(
    callback: Callback,
    generator: JSONObjectGenerator<T>?
): PersonDBCallback<T> {
    return object : PersonDBCallback<T> {
        override fun onSuccess(t: T?) {
            callback.success(generator?.generateJSONObject(t)?.toString())
        }

        override fun onFailure(s: String) {
            callback.error(s)
        }
    }
}

fun <T> createPersonDBListCallback(
    callback: Callback,
    generator: JSONObjectGenerator<T>?
): PersonDBCallback<List<T>?> {
    return object : PersonDBCallback<List<T>?> {
        override fun onSuccess(list: List<T>?) {
            callback.success(generator?.let { generateList(list, it)?.toString() })
        }

        override fun onFailure(s: String) {
            callback.error(s)
        }
    }
}

fun <T : DbBaseItem?> createPersonDBPageableListCallback(
    callback: Callback,
    generator: JSONObjectGenerator<T>?
): PersonDBCallback<PageableItemList<List<T>?, T>> {
    return object : PersonDBCallback<PageableItemList<List<T>?, T>> {
        override fun onSuccess(list: PageableItemList<List<T>?, T>?) {
            callback.success(generator?.let { generateList(list?.itemsList, it)?.toString() })
        }

        override fun onFailure(s: String) {
            callback.error(s)
        }
    }
}

fun generateByteArray(input: ByteArray?): String? =
    input?.let { Base64.encodeToString(it, Base64.NO_WRAP) }

fun ByteArrayFromJSON(input: String?): ByteArray? = input?.let {
    Base64.decode(
        if (it.startsWith("data:")) it.substringAfter(',') else it,
        Base64.NO_WRAP
    )
}

fun arrayFromJSON(input: JSONArray?): Array<String>? = input?.let {
    val result = mutableListOf<String>()
    input.forEach<String> { i, value ->
        result.add(i, value)
    }
    return result.toTypedArray()
}

fun generateBitmap(input: Bitmap?): String? {
    input ?: return null
    val byteArrayOutputStream = ByteArrayOutputStream()
    input.compress(Bitmap.CompressFormat.JPEG, 100, byteArrayOutputStream)
    val byteArray = byteArrayOutputStream.toByteArray()
    return generateByteArray(byteArray)
}

fun BitmapFromJSON(input: String?): Bitmap? {
    input ?: return null
    val decodedString = ByteArrayFromJSON(input)!!
    val options = BitmapFactory.Options()
    options.inPreferredConfig = Bitmap.Config.RGB_565
    var result = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.size, options)
    val sizeMultiplier = result.byteCount / 5000000
    if (result.byteCount > 5000000) result = Bitmap.createScaledBitmap(
        result,
        result.width / sqrt(sizeMultiplier.toDouble()).toInt(),
        result.height / sqrt(sizeMultiplier.toDouble()).toInt(),
        false
    )
    return result
}

fun drawableFromJSON(input: String?, context: Context): BitmapDrawable? {
    input ?: return null
    val decodedString = ByteArrayFromJSON(input)!!
    val bitmap = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.size)
    val density = context.resources.displayMetrics.density
    val width = (bitmap.width * density).toInt()
    val height = (bitmap.height * density).toInt()
    return BitmapDrawable(
        context.resources,
        Bitmap.createScaledBitmap(bitmap, width, height, false)
    )
}