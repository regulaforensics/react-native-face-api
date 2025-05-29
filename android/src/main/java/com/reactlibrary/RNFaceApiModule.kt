package com.reactlibrary

import android.annotation.SuppressLint
import android.app.Activity
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.ReadableArray
import com.facebook.react.modules.core.DeviceEventManagerModule
import com.reactlibrary.Convert.toBase64
import com.regula.common.LocalizationCallbacks
import com.regula.facesdk.FaceSDK.Instance
import com.regula.facesdk.callback.DetectFacesCompletion
import com.regula.facesdk.callback.FaceCaptureCallback
import com.regula.facesdk.callback.FaceCaptureNotificationCallback
import com.regula.facesdk.callback.FaceInitializationCompletion
import com.regula.facesdk.callback.LivenessCallback
import com.regula.facesdk.callback.LivenessNotificationCallback
import com.regula.facesdk.callback.MatchFaceCallback
import com.regula.facesdk.callback.PersonDBCallback
import com.regula.facesdk.configuration.InitializationBleDeviceConfiguration
import com.regula.facesdk.enums.InitErrorCode
import com.regula.facesdk.exception.InitException
import com.regula.facesdk.listener.NetworkInterceptorListener
import com.regula.facesdk.model.LivenessNotification
import com.regula.facesdk.model.results.matchfaces.MatchFacesSimilarityThresholdSplit
import com.regula.facesdk.model.results.person.DbBaseItem
import com.regula.facesdk.model.results.person.PageableItemList
import com.regula.facesdk.model.results.person.Person
import com.regula.facesdk.model.results.person.PersonGroup
import com.regula.facesdk.model.results.person.SearchPerson
import org.json.JSONArray
import org.json.JSONObject

@Suppress("unused", "UNUSED_PARAMETER")
class RNFaceApiModule(rc: ReactApplicationContext) : ReactContextBaseJavaModule(rc) {
    init {
        reactContext = rc
    }

    @ReactMethod
    fun addListener(eventName: String?) = Unit

    @ReactMethod
    fun removeListeners(count: Int?) = Unit

    @ReactMethod
    fun exec(moduleName: String?, action: String?, args: ReadableArray, successCallback: com.facebook.react.bridge.Callback, errorCallback: com.facebook.react.bridge.Callback) = exec(action, args, successCallback)
    override fun getName() = "RNFaceApi"
}

fun sendEvent(event: String, data: Any? = "") {
    val result = if (data is JSONObject || data is JSONArray) data.toString() else data.toString() + ""
    reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter::class.java).emit(event, result)
}

@Suppress("UNCHECKED_CAST")
fun <T> argsNullable(index: Int): T? {
    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // Rewrite it according to react native documentation!!!
    // the is no int or double in js so all ints are sent as double by default
    val value = args[index]
    if (value is Double) if (value % 1 == 0.0) {
        val intValue = value.toInt()
        return intValue as T
    }
    if (args[index].toString() == "null") return null
    return args[index] as T
}

lateinit var args: JSONArray
lateinit var reactContext: ReactContext

fun exec(method: String?, arguments: ReadableArray, successCallback: com.facebook.react.bridge.Callback) {
    args = JSONArray(arguments.toArrayList())
    reactContext.currentActivity?.let { activity = it }
    val callback = { data: Any? -> successCallback.invoke(data.toSendable()) }
    when (method) {
        "getVersion" -> getVersion(callback)
        "getServiceUrl" -> getServiceUrl(callback)
        "setServiceUrl" -> setServiceUrl(argsNullable(0))
        "setLocalizationDictionary" -> setLocalizationDictionary(args(0))
        "setRequestHeaders" -> setRequestHeaders(args(0))
        "setCustomization" -> setCustomization(args(0))
        "isInitialized" -> isInitialized(callback)
        "initialize" -> initialize(callback, argsNullable(0))
        "deinitialize" -> deinitialize()
        "startFaceCapture" -> startFaceCapture(callback, argsNullable(0))
        "stopFaceCapture" -> stopFaceCapture()
        "startLiveness" -> startLiveness(callback, argsNullable(0))
        "stopLiveness" -> stopLiveness()
        "matchFaces" -> matchFaces(callback, args(0), argsNullable(1))
        "splitComparedFaces" -> splitComparedFaces(callback, args(0), args(1))
        "detectFaces" -> detectFaces(callback, args(0))
        "createPerson" -> createPerson(callback, args(0), argsNullable(1), argsNullable(2))
        "updatePerson" -> updatePerson(callback, args(0))
        "deletePerson" -> deletePerson(callback, args(0))
        "getPerson" -> getPerson(callback, args(0))
        "addPersonImage" -> addPersonImage(callback, args(0), args(1))
        "deletePersonImage" -> deletePersonImage(callback, args(0), args(1))
        "getPersonImage" -> getPersonImage(callback, args(0), args(1))
        "getPersonImages" -> getPersonImages(callback, args(0))
        "getPersonImagesForPage" -> getPersonImagesForPage(callback, args(0), args(1), args(2))
        "createGroup" -> createGroup(callback, args(0), argsNullable(1))
        "updateGroup" -> updateGroup(callback, args(0))
        "editPersonsInGroup" -> editPersonsInGroup(callback, args(0), args(1))
        "deleteGroup" -> deleteGroup(callback, args(0))
        "getGroup" -> getGroup(callback, args(0))
        "getGroups" -> getGroups(callback)
        "getGroupsForPage" -> getGroupsForPage(callback, args(0), args(1))
        "getPersonGroups" -> getPersonGroups(callback, args(0))
        "getPersonGroupsForPage" -> getPersonGroupsForPage(callback, args(0), args(1), args(2))
        "getPersonsInGroup" -> getPersonsInGroup(callback, args(0))
        "getPersonsInGroupForPage" -> getPersonsInGroupForPage(callback, args(0), args(1), args(2))
        "searchPerson" -> searchPerson(callback, args(0))
    }
}

inline fun <reified T> args(index: Int) = argsNullable<T>(index)!!
typealias Callback = (Any?) -> Unit

@SuppressLint("StaticFieldLeak")
lateinit var activity: Activity
val context
    get() = activity

const val cameraSwitchEvent = "cameraSwitchEvent"
const val livenessNotificationEvent = "livenessNotificationEvent"
const val videoEncoderCompletionEvent = "video_encoder_completion"
const val onCustomButtonTappedEvent = "onCustomButtonTappedEvent"

fun getVersion(callback: Callback) = callback(generateFaceSDKVersion(Instance().version))

fun getServiceUrl(callback: Callback) = callback(Instance().serviceUrl)

fun setServiceUrl(url: String?) = url.let { Instance().serviceUrl = it }

fun setLocalizationDictionary(dictionary: JSONObject) {
    localizationCallbacks = LocalizationCallbacks { if (dictionary.has(it)) dictionary.getString(it) else null }
    Instance().setLocalizationCallback(localizationCallbacks!!)
}

fun setRequestHeaders(headers: JSONObject) {
    networkInterceptorListener = NetworkInterceptorListener { headers.forEach { k, v -> it.header(k, v as String) } }
    Instance().setNetworkInterceptorListener(networkInterceptorListener)
}

fun setCustomization(config: JSONObject) = setCustomization(Instance().customization, config)

fun isInitialized(callback: Callback) = callback(Instance().isInitialized)

@SuppressLint("MissingPermission")
fun initialize(callback: Callback, config: JSONObject?) =
    if (config == null)
        Instance().initialize(context, initCompletion(callback))
    else if (config.getBooleanOrNull("useBleDevice") != true)
        Instance().initialize(context, initConfigFromJSON(config), initCompletion(callback))
    else
        getBleWrapper()?.let {
            Instance().initialize(context, InitializationBleDeviceConfiguration(it), initCompletion(callback))
        } ?: callback(generateInitCompletion(false, InitException(InitErrorCode.LICENSE_IS_NULL)))

fun deinitialize() = Instance().deinitialize()

fun startFaceCapture(callback: Callback, config: JSONObject?) = config?.let {
    Instance().presentFaceCaptureActivity(
        context,
        faceCaptureConfigFromJSON(it),
        faceCaptureCompletion(callback),
        faceCaptureNotificationCompletion()
    )
} ?: Instance().presentFaceCaptureActivity(
    context,
    faceCaptureCompletion(callback),
    faceCaptureNotificationCompletion()
)

fun stopFaceCapture() = Instance().stopFaceCaptureActivity(context)

fun startLiveness(callback: Callback, config: JSONObject?) = config?.let {
    Instance().startLiveness(
        context,
        livenessConfigFromJSON(it),
        livenessCompletion(callback),
        livenessNotificationCompletion()
    )
} ?: Instance().startLiveness(
    context,
    livenessCompletion(callback),
    livenessNotificationCompletion()
)

fun stopLiveness() = Instance().stopLivenessProcessing(context)

fun matchFaces(callback: Callback, request: JSONObject, config: JSONObject?) = config?.let {
    Instance().matchFaces(
        context,
        matchFacesRequestFromJSON(request),
        matchFacesConfigFromJSON(it),
        matchFacesCompletion(callback)
    )
} ?: Instance().matchFaces(
    context,
    matchFacesRequestFromJSON(request),
    matchFacesCompletion(callback)
)

fun splitComparedFaces(callback: Callback, faces: JSONArray, similarity: Double) {
    val list = faces.toList(::comparedFacesPairFromJSON)
    val split = MatchFacesSimilarityThresholdSplit(list, similarity)
    callback(generateComparedFacesSplit(split))
}

fun detectFaces(callback: Callback, request: JSONObject) = Instance().detectFaces(
    context,
    detectFacesRequestFromJSON(request),
    detectFacesCompletion(callback)
)

val db get() = Instance().personDatabase(context)

fun createPerson(
    callback: Callback,
    name: String,
    groupIds: JSONArray?,
    metadata: JSONObject?
) = db.createPerson(
    name,
    metadata,
    groupIds.toArray(),
    databaseItemCompletion(callback, ::generatePerson)
)

fun updatePerson(callback: Callback, personJson: JSONObject) =
    db.getPerson(idFromJSON(personJson), object : PersonDBCallback<Person?> {
        override fun onSuccess(person: Person?) = db.updatePerson(
            updatePersonFromJSON(person!!, personJson),
            databaseItemCompletion(callback, null)
        )

        override fun onFailure(error: String) = callback(generatePersonDBResponse(null, error))
    })

fun deletePerson(callback: Callback, personId: String) = db.deletePerson(
    personId,
    databaseItemCompletion(callback, null)
)

fun getPerson(callback: Callback, personId: String) = db.getPerson(
    personId,
    databaseItemCompletion(callback, ::generatePerson)
)

fun addPersonImage(callback: Callback, personId: String, image: JSONObject) = db.addPersonImage(
    personId,
    imageUploadFromJSON(image),
    databaseItemCompletion(callback, ::generatePersonImage)
)

fun deletePersonImage(callback: Callback, personId: String, imageId: String) = db.deletePersonImage(
    personId,
    imageId,
    databaseItemCompletion(callback, null)
)

fun getPersonImage(callback: Callback, personId: String, imageId: String) = db.getPersonImageById(
    personId,
    imageId,
    object : PersonDBCallback<ByteArray> {
        override fun onSuccess(data: ByteArray?) = callback(generatePersonDBResponse(data.toBase64()!!, null))
        override fun onFailure(error: String) = callback(generatePersonDBResponse(null, error))
    }
)

fun getPersonImages(callback: Callback, personId: String) = db.getPersonImages(
    personId,
    databasePageCompletion(callback, ::generatePersonImage)
)

fun getPersonImagesForPage(
    callback: Callback,
    personId: String,
    page: Int,
    size: Int
) = db.getPersonImagesForPage(
    personId,
    page,
    size,
    databasePageCompletion(callback, ::generatePersonImage)
)

fun createGroup(callback: Callback, name: String, metadata: JSONObject?) = db.createGroup(
    name,
    metadata,
    databaseItemCompletion(callback, ::generatePersonGroup)
)

fun updateGroup(callback: Callback, groupJson: JSONObject) =
    db.getGroup(idFromJSON(groupJson), object : PersonDBCallback<PersonGroup?> {
        override fun onSuccess(group: PersonGroup?) = db.updateGroup(
            updatePersonGroupFromJSON(group!!, groupJson),
            databaseItemCompletion(callback, null)
        )

        override fun onFailure(error: String) = callback(generatePersonDBResponse(null, error))
    })

fun editPersonsInGroup(callback: Callback, groupId: String, editGroupPersonsRequest: JSONObject) =
    db.editPersonsInGroup(
        groupId,
        editGroupPersonsRequestFromJSON(editGroupPersonsRequest),
        databaseItemCompletion(callback, null)
    )

fun deleteGroup(callback: Callback, groupId: String) = db.deleteGroup(
    groupId,
    databaseItemCompletion(callback, null)
)

fun getGroup(callback: Callback, groupId: String) = db.getGroup(
    groupId,
    databaseItemCompletion(callback, ::generatePersonGroup)
)

fun getGroups(callback: Callback) = db.getGroups(databasePageCompletion(callback, ::generatePersonGroup))

fun getGroupsForPage(callback: Callback, page: Int, size: Int) = db.getGroupsForPage(
    page,
    size,
    databasePageCompletion(callback, ::generatePersonGroup)
)

fun getPersonGroups(callback: Callback, personId: String) = db.getPersonGroups(
    personId,
    databasePageCompletion(callback, ::generatePersonGroup)
)

fun getPersonGroupsForPage(
    callback: Callback,
    personId: String,
    page: Int,
    size: Int
) = db.getPersonGroupsForPage(
    personId,
    page,
    size,
    databasePageCompletion(callback, ::generatePersonGroup)
)

fun getPersonsInGroup(callback: Callback, groupId: String) = db.getPersonsInGroup(
    groupId,
    databasePageCompletion(callback, ::generatePerson)
)

fun getPersonsInGroupForPage(
    callback: Callback,
    groupId: String,
    page: Int,
    size: Int
) = db.getPersonsInGroupForPage(
    groupId,
    page,
    size,
    databasePageCompletion(callback, ::generatePerson)
)

fun searchPerson(callback: Callback, searchPersonRequest: JSONObject) = db.searchPerson(
    searchPersonRequestFromJSON(searchPersonRequest),
    object : PersonDBCallback<List<SearchPerson>> {
        override fun onSuccess(data: List<SearchPerson>?) = callback(generatePersonDBResponse(data.toJsonNullable(::generateSearchPerson)!!, null))
        override fun onFailure(error: String) = callback(generatePersonDBResponse(null, error))
    }
)

fun initCompletion(callback: Callback) = FaceInitializationCompletion { success, error ->
    if (success) {
        // initializes MutableLiveData
        Instance().customization.uiConfigurationLive
        Instance().setVideoEncoderCompletion { id, s -> sendEvent(videoEncoderCompletionEvent, generateVideoEncoderCompletion(id, s)) }
        Instance().setOnClickListener { sendEvent(onCustomButtonTappedEvent, it.tag.toInt()) }
    }
    callback(generateInitCompletion(success, error))
}

fun faceCaptureCompletion(callback: Callback) = FaceCaptureCallback {
    callback(generateFaceCaptureResponse(it))
}

fun faceCaptureNotificationCompletion() = object : FaceCaptureNotificationCallback() {
    override fun onCameraSwitched(cameraId: Int) = sendEvent(cameraSwitchEvent, cameraId)
}

fun livenessCompletion(callback: Callback) = LivenessCallback {
    callback(generateLivenessResponse(it))
}

fun livenessNotificationCompletion() = object : LivenessNotificationCallback() {
    override fun onCameraSwitched(cameraId: Int) = sendEvent(cameraSwitchEvent, cameraId)
    override fun onLivenessNotification(ln: LivenessNotification) = sendEvent(livenessNotificationEvent, generateLivenessNotification(ln))
}

fun matchFacesCompletion(callback: Callback) = MatchFaceCallback {
    callback(generateMatchFacesResponse(it))
}

fun detectFacesCompletion(callback: Callback) = DetectFacesCompletion {
    callback(generateDetectFacesResponse(it))
}

fun <T> databaseItemCompletion(callback: Callback, toJson: ((T?) -> JSONObject?)?) = object : PersonDBCallback<T> {
    override fun onSuccess(data: T?) = callback(generatePersonDBResponse(toJson?.let { it(data) } ?: true, null))
    override fun onFailure(error: String) = callback(generatePersonDBResponse(null, error))
}

fun <T : DbBaseItem?> databasePageCompletion(callback: Callback, toJson: (T?) -> JSONObject?) = object : PersonDBCallback<PageableItemList<List<T>?, T>> {
    override fun onSuccess(data: PageableItemList<List<T>?, T>?) = callback(
        generatePersonDBResponse(
            mapOf(
                "items" to data!!.itemsList.toJsonNullable(toJson),
                "page" to data.page,
                "totalPages" to data.totalPages,
            ).toJson(),
            null
        )
    )

    override fun onFailure(error: String) = callback(generatePersonDBResponse(null, error))
}

// Weak references
var localizationCallbacks: LocalizationCallbacks? = null
var networkInterceptorListener: NetworkInterceptorListener? = null
