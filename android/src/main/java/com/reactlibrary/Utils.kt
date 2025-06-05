@file:Suppress("UNCHECKED_CAST", "EnumValuesSoftDeprecate", "UseKtx")

package com.reactlibrary

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Typeface
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.util.Base64
import android.util.Log
import com.regula.common.ble.BLEWrapper
import com.regula.facesdk.configuration.Customization
import com.regula.facesdk.enums.CustomizationColor
import com.regula.facesdk.enums.CustomizationFont
import com.regula.facesdk.enums.CustomizationImage
import com.regula.facesdk.enums.ImageType
import com.regula.facesdk.enums.InitErrorCode
import com.regula.facesdk.enums.OutputImageCropAspectRatio
import com.reactlibrary.Convert.toDrawable
import org.json.JSONArray
import org.json.JSONObject
import java.io.ByteArrayOutputStream
import java.lang.reflect.Constructor
import java.text.SimpleDateFormat
import java.util.Date
import kotlin.math.sqrt
import kotlin.reflect.KClass

fun List<*>.toJson(): JSONArray {
    val result = JSONArray()
    for (i in indices)
        when (val v = this[i]) {
            null -> result.put(null)
            is Map<*, *> -> result.put(v.toJson())
            is List<*> -> result.put(v.toJson())
            else -> result.put(v)
        }
    return result
}

fun Map<*, *>.toJson(): JSONObject {
    val result = JSONObject()
    for ((k, v) in this) {
        when (v) {
            null -> result.put(k as String, null)
            is Map<*, *> -> result.put(k as String, v.toJson())
            is List<*> -> result.put(k as String, v.toJson())
            else -> result.put(k as String, v)
        }
    }
    return result
}

fun Any?.toSendable(): Any? = this?.let {
    if (it is JSONObject || it is JSONArray) it.toString()
    else it
}

fun <T> List<T>?.toJsonNullable(toJson: (T?) -> Any?) = this?.let {
    val result = JSONArray()
    for (item in it) result.put(toJson(item))
    result
}

fun <T> List<T>?.toJson(toJson: (T) -> Any) = this?.let {
    val result = JSONArray()
    for (item in it) result.put(toJson(item))
    result
}

fun <T> JSONArray?.toList(fromJson: (JSONObject) -> T) = this?.let {
    val result: MutableList<T> = ArrayList()
    for (i in 0 until it.length()) result.add(fromJson(it.getJSONObject(i)))
    result
}

inline fun <reified T> JSONArray?.toArray() = this?.let {
    val result = arrayOfNulls<T>(length())
    for (i in 0 until length()) result[i] = get(i) as T
    result
}

fun <T> Array<T>?.toJson() = this?.let {
    val result = JSONArray()
    for (i in it.indices) result.put(i, it[i])
    result
}

fun <T> List<T>?.toArrayList(): ArrayList<T>? = this?.let { ArrayList(this) }

fun JSONObject.forEach(action: (String, Any) -> Unit) {
    val keys: Iterator<String> = keys()
    while (keys.hasNext()) {
        val key = keys.next()
        action(key, get(key))
    }
}

fun JSONArray.forEach(action: (Any?) -> Unit) {
    for (i in 0 until length())
        action(get(i))
}

fun Any.toInt() = when (this) {
    is Double -> toInt()
    is Long -> toInt()
    is String -> Integer.parseInt(this)
    else -> this as Int
}

fun Any.toLong() = when (this) {
    is Double -> toLong()
    is Int -> toLong()
    else -> this as Long
}

fun Any.toFloat() = when (this) {
    is Int -> toFloat()
    is Double -> toFloat()
    else -> this as Float
}

@SuppressLint("SimpleDateFormat")
fun String.toDate() = SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS").parse(this)!!

@SuppressLint("SimpleDateFormat")
fun Date.toStr(): String = SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(this)

fun Any.setColor(customization: Customization, value: Any) {
    val uiConfig = customization.uiConfigurationLive.value!!
    val private = uiConfig.javaClass.getDeclaredField("a")
    private.isAccessible = true
    val colors = private.get(uiConfig) as HashMap<CustomizationColor, Long>

    val field = CustomizationColor.values().find { it.value == this.toInt() }!!
    colors[field] = value.toLong()
}

fun Any.setFont(customization: Customization, value: Any) {
    val uiConfig = customization.uiConfigurationLive.value!!
    val privateFonts = uiConfig.javaClass.getDeclaredField("f")
    privateFonts.isAccessible = true
    val fonts = privateFonts.get(uiConfig) as HashMap<CustomizationFont, Typeface>
    val privateSizes = uiConfig.javaClass.getDeclaredField("g")
    privateSizes.isAccessible = true
    val fontsSizes = privateSizes.get(uiConfig) as HashMap<CustomizationFont, Int>

    val field = CustomizationFont.values().find { it.value == this.toInt() }!!
    val font = typefaceFromJSON(value as JSONObject)
    fonts[field] = font.first
    font.second?.let { fontsSizes[field] = it }
}

fun Any.setImage(customization: Customization, value: Any) {
    val uiConfig = customization.uiConfigurationLive.value!!
    val private = uiConfig.javaClass.getDeclaredField("d")
    private.isAccessible = true
    val images = private.get(uiConfig) as HashMap<CustomizationImage, Drawable>

    val field = CustomizationImage.values().find { it.value == this.toInt() }!!
    images[field] = (value as String?).toDrawable(context)!!
}

fun Int.toOutputImageCropAspectRatio(): OutputImageCropAspectRatio {
    for (iterator in OutputImageCropAspectRatio.values())
        if (iterator.value == this) return iterator
    throw Exception("getting enum OutputImageCropAspectRatio by undefined value: $this")
}

fun Int.toInitErrorCode(): InitErrorCode {
    for (iterator in InitErrorCode.values())
        if (iterator.value == this) return iterator
    throw Exception("getting enum InitErrorCode by undefined value: $this")
}

fun Int.toImageType(): ImageType {
    for (iterator in ImageType.values())
        if (iterator.value == this) return iterator
    throw Exception("getting enum ImageType by undefined value: $this")
}

fun JSONObject.getJSONObjectOrNull(name: String): JSONObject? {
    if (has(name) && get(name).toString() != "null") return getJSONObject(name)
    return null
}

fun JSONObject.getJSONArrayOrNull(name: String): JSONArray? {
    if (has(name) && get(name).toString() != "null") return getJSONArray(name)
    return null
}

fun JSONObject.getIntOrNull(name: String): Int? {
    if (has(name) && get(name).toString() != "null") return getInt(name)
    return null
}

fun JSONObject.getLongOrNull(name: String): Long? {
    if (has(name) && get(name).toString() != "null") return getLong(name)
    return null
}

fun JSONObject.getDoubleOrNull(name: String): Double? {
    if (has(name) && get(name).toString() != "null") return getDouble(name)
    return null
}

fun JSONObject.getBooleanOrNull(name: String): Boolean? {
    if (has(name) && get(name).toString() != "null") return getBoolean(name)
    return null
}

fun JSONObject.getStringOrNull(name: String): String? {
    if (has(name) && get(name).toString() != "null") return getString(name)
    return null
}

fun <T : Any> KClass<T>.constructor(vararg argTypes: KClass<*>): Constructor<T> {
    val types = mutableListOf<Class<*>>()
    for (argType in argTypes) types.add(argType.java)
    return java.getDeclaredConstructor(*types.toTypedArray())
}

fun <T : Any> Constructor<T>.instantiate(vararg args: Any?): T {
    isAccessible = true
    return newInstance(*args)
}

fun <T : Any> T.setPrivateProperty(varName: String, data: Any?) {
    try {
        setPrivateProperty(javaClass, varName, data)
    } catch (_: java.lang.Exception) {
        try {
            setPrivateProperty(javaClass.superclass!!, varName, data)
        } catch (_: java.lang.Exception) {
        }
    }
}

fun <T : Any> T.setPrivateProperty(clazz: Class<T>, varName: String, data: Any?) = clazz.getDeclaredField(varName).let {
    it.isAccessible = true
    it.set(this, data)
}

//fun <T : Any> T.setSuperPrivateProperty(variableName: String, data: Any?) = javaClass.superclass.getDeclaredField(variableName).let {
//    it.isAccessible = true
//    it.set(this, data)
//}

internal object Convert {
    fun String?.toByteArray(): ByteArray? {
        var str = this ?: return null
        if (str.startsWith("data")) str = str.substring(str.indexOf(",") + 1)
        return Base64.decode(str, Base64.NO_WRAP)
    }

    fun ByteArray?.toBase64() = this?.let { Base64.encodeToString(it, Base64.NO_WRAP) }

    fun String?.toBitmap() = this?.let {
        val decodedString = it.toByteArray()!!
        var result = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.size)
        val sizeMultiplier = result.byteCount / 5000000
        if (result.byteCount > 5000000)
            result = Bitmap.createScaledBitmap(
                result,
                result.width / sqrt(sizeMultiplier.toDouble()).toInt(),
                result.height / sqrt(sizeMultiplier.toDouble()).toInt(),
                false
            )
        result
    }

    fun Bitmap?.toBase64() = this?.let {
        val byteArrayOutputStream = ByteArrayOutputStream()
        it.compress(Bitmap.CompressFormat.JPEG, 100, byteArrayOutputStream)
        byteArrayOutputStream.toByteArray().toBase64()
    }

    fun String?.toDrawable(context: Context) = this?.let {
        val decodedByte = it.toByteArray()!!
        val bitmap = BitmapFactory.decodeByteArray(decodedByte, 0, decodedByte.size)
        val density = context.resources.displayMetrics.density
        val width = (bitmap.width * density).toInt()
        val height = (bitmap.height * density).toInt()
        BitmapDrawable(context.resources, Bitmap.createScaledBitmap(bitmap, width, height, false))
    }
}

fun getBleWrapper(): BLEWrapper? {
    listOf(
        "io.flutter.plugins.regula.documentreader.flutter_document_reader_api",
        "cordova.plugin.documentreader",
        "com.regula.documentreader"
    ).forEach { packageName ->
        getVarFromClass<BLEWrapper>(
            packageName,
            "BluetoothUtilKt",
            "bluetooth"
        )?.let { return it }
    }
    Log.e("REGULA", "Failed to get BLEWrapper from DocumentReader plugin")
    return null
}

fun <T> getVarFromClass(packageName: String, className: String, varName: String): T? {
    try {
        val targetClass = Class.forName("$packageName.$className")
        val field = targetClass.getDeclaredField(varName)
        field.isAccessible = true
        val result = field.get(null) as BLEWrapper?
        return result as T?
    } catch (_: Exception) {
        return null
    }
}
