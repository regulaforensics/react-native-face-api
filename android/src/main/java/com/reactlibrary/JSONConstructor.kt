package com.reactlibrary

import android.annotation.SuppressLint
import android.graphics.Bitmap
import android.graphics.Point
import android.graphics.Rect
import android.graphics.Typeface
import android.util.Pair
import android.util.Size
import com.regula.facesdk.configuration.FaceCaptureConfiguration
import com.regula.facesdk.configuration.InitializationConfiguration
import com.regula.facesdk.configuration.LivenessConfiguration
import com.regula.facesdk.configuration.MatchFacesConfiguration
import com.regula.facesdk.detection.request.DetectFacesConfiguration
import com.regula.facesdk.detection.request.DetectFacesRequest
import com.regula.facesdk.detection.request.ImageQualityCharacteristic
import com.regula.facesdk.detection.request.ImageQualityColorCharacteristic
import com.regula.facesdk.detection.request.ImageQualityRange
import com.regula.facesdk.detection.request.OutputImageCrop
import com.regula.facesdk.detection.request.OutputImageParams
import com.regula.facesdk.detection.response.DetectFaceResult
import com.regula.facesdk.detection.response.DetectFacesAttributeResult
import com.regula.facesdk.detection.response.DetectFacesResponse
import com.regula.facesdk.detection.response.ImageQualityResult
import com.regula.facesdk.enums.DetectFacesAttribute
import com.regula.facesdk.enums.DetectFacesBackendErrorCode
import com.regula.facesdk.enums.DetectFacesErrorCode
import com.regula.facesdk.enums.FaceCaptureErrorCode
import com.regula.facesdk.enums.ImageQualityGroupName
import com.regula.facesdk.enums.ImageQualityResultStatus
import com.regula.facesdk.enums.LicensingResultCode
import com.regula.facesdk.enums.LivenessBackendErrorCode
import com.regula.facesdk.enums.LivenessErrorCode
import com.regula.facesdk.enums.LivenessProcessStatus
import com.regula.facesdk.enums.LivenessSkipStep
import com.regula.facesdk.enums.LivenessStatus
import com.regula.facesdk.enums.MatchFacesErrorCode
import com.regula.facesdk.enums.ScreenOrientation
import com.regula.facesdk.exception.DetectFacesBackendException
import com.regula.facesdk.exception.DetectFacesErrorException
import com.regula.facesdk.exception.FaceCaptureException
import com.regula.facesdk.exception.InitException
import com.regula.facesdk.exception.LicenseException
import com.regula.facesdk.exception.LivenessBackendException
import com.regula.facesdk.exception.LivenessErrorException
import com.regula.facesdk.exception.MatchFacesException
import com.regula.facesdk.exception.UnderlineException
import com.regula.facesdk.model.Image
import com.regula.facesdk.model.LivenessNotification
import com.regula.facesdk.model.MatchFacesImage
import com.regula.facesdk.model.results.FaceCaptureResponse
import com.regula.facesdk.model.results.FaceSDKVersion
import com.regula.facesdk.model.results.LivenessResponse
import com.regula.facesdk.model.results.matchfaces.MatchFacesComparedFace
import com.regula.facesdk.model.results.matchfaces.MatchFacesComparedFacesPair
import com.regula.facesdk.model.results.matchfaces.MatchFacesDetection
import com.regula.facesdk.model.results.matchfaces.MatchFacesDetectionFace
import com.regula.facesdk.model.results.matchfaces.MatchFacesResponse
import com.regula.facesdk.model.results.matchfaces.MatchFacesSimilarityThresholdSplit
import com.regula.facesdk.model.results.person.Person
import com.regula.facesdk.model.results.person.PersonGroup
import com.regula.facesdk.model.results.person.PersonImage
import com.regula.facesdk.model.results.person.SearchPerson
import com.regula.facesdk.model.results.person.SearchPerson.Detection
import com.regula.facesdk.model.results.person.SearchPersonImage
import com.regula.facesdk.request.MatchFacesRequest
import com.regula.facesdk.request.person.EditGroupPersonsRequest
import com.regula.facesdk.request.person.ImageUpload
import com.regula.facesdk.request.person.SearchPersonRequest
import com.reactlibrary.Convert.toBase64
import com.reactlibrary.Convert.toBitmap
import com.reactlibrary.Convert.toByteArray
import org.json.JSONArray
import org.json.JSONObject

// Config ------------------------------

fun typefaceFromJSON(it: JSONObject) = Pair(
    Typeface.create(
        it.getString("name"),
        it.optInt("style", Typeface.NORMAL)
    ),
    it.getIntOrNull("size")
)

fun faceCaptureConfigFromJSON(input: JSONObject) = input.let {
    val result = FaceCaptureConfiguration.Builder()
    setFaceCaptureConfig(result, it)
    result.build()
}!!

fun generateFaceCaptureConfig(input: FaceCaptureConfiguration) = getFaceCaptureConfig(input)

fun livenessConfigFromJSON(input: JSONObject) = input.let {
    val result = LivenessConfiguration.Builder()
    setLivenessConfig(result, it)
    result.build()
}!!

fun generateLivenessConfig(input: LivenessConfiguration) = getLivenessConfig(input)

fun matchFacesConfigFromJSON(input: JSONObject) = input.let {
    val result = MatchFacesConfiguration.Builder()
    setMatchFacesConfig(result, it)
    result.build()
}!!

fun generateMatchFacesConfig(input: MatchFacesConfiguration) = getMatchFacesConfig(input)

fun livenessSkipStepArrayFromJSON(input: JSONArray) = input.let {
    val result = arrayOfNulls<LivenessSkipStep>(it.length())
    for (i in 0 until it.length())
        result[i] = LivenessSkipStep.values()[it.getInt(i)]
    result
}

fun generateLivenessSkipStepArray(input: Array<LivenessSkipStep>) = input.let {
    val result = JSONArray()
    for (i in it.indices)
        result.put(it[i].ordinal)
    result
}

fun screenOrientationArrayFromJSON(input: JSONArray) = input.let {
    val result = arrayOfNulls<ScreenOrientation>(it.length())
    for (i in 0 until it.length())
        result[i] = ScreenOrientation.values()[it.getInt(i)]
    result
}

fun generateScreenOrientationArray(input: Array<ScreenOrientation>) = input.let {
    val result = JSONArray()
    for (i in it.indices)
        result.put(it[i].ordinal)
    result
}

// Exception ------------------------------

fun faceCaptureExceptionFromJSON(input: JSONObject?) = input?.let {
    FaceCaptureException(FaceCaptureErrorCode.values()[it.getInt("code")])
}

fun generateFaceCaptureException(input: FaceCaptureException?) = input?.let {
    mapOf(
        "code" to it.errorCode.ordinal,
        "message" to it.message
    ).toJson()
}

fun initExceptionFromJSON(input: JSONObject?) = input?.let {
    InitException(
        it.getInt("code").toInitErrorCode(),
        licenseExceptionFromJSON(it.getJSONObjectOrNull("underlyingError"))
    )
}

fun generateInitException(input: InitException?) = input?.let {
    mapOf(
        "code" to it.errorCode.value,
        "message" to it.message,
        "underlyingError" to generateLicenseException(it.underlyingError)
    ).toJson()
}

fun licenseExceptionFromJSON(input: JSONObject?) = input?.let {
    LicenseException(
        LicensingResultCode.values()[it.getInt("code")],
        it.getStringOrNull("message")
    )
}

fun generateLicenseException(input: LicenseException?) = input?.let {
    mapOf(
        "code" to it.errorCode.ordinal,
        "message" to it.message
    ).toJson()
}

fun livenessExceptionFromJSON(input: JSONObject?) = input?.let {
    LivenessErrorException(
        LivenessErrorCode.values()[it.getInt("code")],
        livenessBackendExceptionFromJSON(it.getJSONObjectOrNull("underlyingError"))
    )
}

fun generateLivenessException(input: LivenessErrorException?) = input?.let {
    mapOf(
        "code" to it.errorCode.ordinal,
        "message" to it.message,
        "underlyingError" to generateLivenessBackendException(it.underlyingException)
    ).toJson()
}

fun livenessBackendExceptionFromJSON(input: JSONObject?) = input?.let {
    LivenessBackendException(LivenessBackendErrorCode.createValue(it.getInt("code")))
}

fun generateLivenessBackendException(input: LivenessBackendException?) = input?.let {
    mapOf(
        "code" to it.errorCode.value,
        "message" to it.message
    ).toJson()
}

fun matchFacesExceptionFromJSON(input: JSONObject?) = input?.let {
    MatchFacesException(
        MatchFacesErrorCode.values()[it.getInt("code")],
        underlineExceptionFromJSON(it.getJSONObjectOrNull("underlyingError"))
    )
}

fun generateMatchFacesException(input: MatchFacesException?) = input?.let {
    mapOf(
        "code" to it.errorCode.ordinal,
        "message" to it.message,
        "underlyingError" to generateUnderlineException(it.underlineException)
    ).toJson()
}

fun underlineExceptionFromJSON(input: JSONObject?) = input?.let {
    UnderlineException(
        it.getInt("code"),
        it.getString("message")
    )
}

fun generateUnderlineException(input: UnderlineException?) = input?.let {
    mapOf(
        "code" to it.errorCode,
        "message" to it.message
    ).toJson()
}

fun detectFacesExceptionFromJSON(input: JSONObject?) = input?.let {
    DetectFacesErrorException(
        DetectFacesErrorCode.values()[it.getInt("code")],
        it.getStringOrNull("message"),
        detectFacesBackendExceptionFromJSON(it.getJSONObjectOrNull("underlyingError"))
    )
}

fun generateDetectFacesException(input: DetectFacesErrorException?) = input?.let {
    mapOf(
        "code" to it.errorCode.ordinal,
        "message" to it.message,
        "underlyingError" to generateDetectFacesBackendException(it.underlyingException)
    ).toJson()
}

fun detectFacesBackendExceptionFromJSON(input: JSONObject?) = input?.let {
    DetectFacesBackendException(
        DetectFacesBackendErrorCode.createValue(it.getInt("code")),
        it.getStringOrNull("message")
    )
}

fun generateDetectFacesBackendException(input: DetectFacesBackendException?) = input?.let {
    mapOf(
        "code" to it.errorCode.value,
        "message" to it.message
    ).toJson()
}

// Init ------------------------------

fun faceSDKVersionFromJSON(input: JSONObject?) = input?.let {
    val result = FaceSDKVersion::class.constructor(String::class, String::class).instantiate(
        it.getStringOrNull("core"),
        it.getStringOrNull("coreMode"),
    )
    result.setPrivateProperty("api", it.getStringOrNull("api"))
    result
}

fun generateFaceSDKVersion(input: FaceSDKVersion?) = input?.let {
    mapOf(
        "api" to it.api,
        "core" to it.core,
        "coreMode" to it.coreMode,
    ).toJson()
}

fun generateInitCompletion(success: Boolean, error: InitException?) = mapOf(
    "success" to success,
    "error" to generateInitException(error)
).toJson()

@SuppressLint("MissingPermission")
fun initConfigFromJSON(input: JSONObject) = input.let {
    val license: ByteArray = it.getString("license").toByteArray()!!
    val builder = InitializationConfiguration.Builder(license)
    if (it.has("licenseUpdate")) builder.setLicenseUpdate(it.getBoolean("licenseUpdate"))
    builder.build()
}!!

fun generateInitConfig(it: InitializationConfiguration) = mapOf(
    "license" to it.license.toBase64(),
    "licenseUpdate" to it.isLicenseUpdate
).toJson()

fun generateVideoEncoderCompletion(transactionId: String, success: Boolean) = mapOf(
    "transactionId" to transactionId,
    "success" to success
).toJson()

// FaceCapture ------------------------------

fun faceCaptureImageFromJSON(input: JSONObject?) = input?.let {
    Image(
        it.getInt("imageType").toImageType(),
        it.getStringOrNull("tag"),
        it.getString("image").toBitmap(),
    )
}

fun generateFaceCaptureImage(input: Image?) = input?.let {
    mapOf(
        "imageType" to it.imageType.value,
        "image" to it.bitmap.toBase64(),
        "tag" to it.tag
    ).toJson()
}

fun faceCaptureResponseFromJSON(input: JSONObject) = input.let {
    val result = FaceCaptureResponse::class.constructor().instantiate()
    result.setPrivateProperty("image", faceCaptureImageFromJSON(it.getJSONObjectOrNull("image")))
    result.setPrivateProperty("exception", faceCaptureExceptionFromJSON(it.getJSONObjectOrNull("error")))
    result
}

fun generateFaceCaptureResponse(it: FaceCaptureResponse) = mapOf(
    "image" to generateFaceCaptureImage(it.image),
    "error" to generateFaceCaptureException(it.exception)
).toJson()

// Liveness ------------------------------

fun livenessResponseFromJSON(input: JSONObject?) = input?.let {
    val result = LivenessResponse()
    it.getStringOrNull("image").toBitmap()?.let { bitmap ->
        result.setPrivateProperty("bitmaps", arrayOf(bitmap))
    }
    result.setPrivateProperty("liveness", LivenessStatus.values()[it.getInt("liveness")])
    result.setPrivateProperty("exception", livenessExceptionFromJSON(it.getJSONObjectOrNull("error")))
    result.setPrivateProperty("tag", it.getStringOrNull("tag"))
    result.setPrivateProperty("transactionId", it.getStringOrNull("transactionId"))
    result.setPrivateProperty("estimatedAge", it.getIntOrNull("estimatedAge"))
    result
}

fun generateLivenessResponse(input: LivenessResponse?) = input?.let {
    mapOf(
        "image" to it.bitmap.toBase64(),
        "liveness" to it.liveness.ordinal,
        "error" to generateLivenessException(it.exception),
        "tag" to it.tag,
        "transactionId" to it.transactionId,
        "estimatedAge" to it.estimatedAge
    ).toJson()
}

fun livenessNotificationFromJSON(it: JSONObject): LivenessNotification = LivenessNotification.Builder().create(
    LivenessProcessStatus.values()[it.getInt("status")],
    livenessResponseFromJSON(it.getJSONObjectOrNull("response"))
).build()

fun generateLivenessNotification(it: LivenessNotification) = mapOf(
    "status" to it.status.ordinal,
    "response" to generateLivenessResponse(it.response)
).toJson()

// MatchFaces ------------------------------

fun matchFacesImageFromJSON(input: JSONObject?) = input?.let {
    val result = MatchFacesImage(
        it.getString("image").toBitmap(),
        it.getInt("imageType").toImageType(),
        it.optBoolean("detectAll", false)
    )
    if (it.has("identifier")) result.setPrivateProperty("identifier", it.getString("identifier"))
    result
}

fun generateMatchFacesImage(input: MatchFacesImage?) = input?.let {
    mapOf(
        "imageType" to it.imageType.value,
        "detectAll" to it.isDetectAll,
        "image" to it.bitmap.toBase64(),
        "identifier" to it.identifier
    ).toJson()
}

fun sizeFromJSON(input: JSONObject?) = input?.let {
    Size(
        it.getInt("width"),
        it.getInt("height")
    )
}

fun generateSize(input: Size?) = input?.let {
    mapOf(
        "width" to it.width,
        "height" to it.height
    ).toJson()
}

fun outputImageCropFromJSON(input: JSONObject?) = input?.let {
    OutputImageCrop(
        it.getInt("type").toOutputImageCropAspectRatio(),
        sizeFromJSON(it.getJSONObjectOrNull("size")),
        it.getLongOrNull("padColor"),
        it.optBoolean("returnOriginalRect", false)
    )
}

fun generateOutputImageCrop(input: OutputImageCrop?) = input?.let {
    mapOf(
        "type" to it.type.value,
        "size" to generateSize(it.size),
        "padColor" to it.padColor,
        "returnOriginalRect" to it.isReturnOriginalRect
    ).toJson()
}

fun outputImageParamsFromJSON(input: JSONObject?) = input?.let {
    OutputImageParams(
        outputImageCropFromJSON(it.getJSONObjectOrNull("crop")),
        it.optLong("backgroundColor", 0)
    )
}

fun generateOutputImageParams(input: OutputImageParams?) = input?.let {
    mapOf(
        "crop" to generateOutputImageCrop(it.imageCropParams),
        "backgroundColor" to it.backgroundColor
    ).toJson()
}

fun matchFacesRequestFromJSON(input: JSONObject) = input.let {
    val result = MatchFacesRequest(it.getJSONArray("images").toList(::matchFacesImageFromJSON)!!)
    result.customMetadata = it.getJSONObjectOrNull("metadata")
    result.tag = it.getStringOrNull("tag")
    result.outputImageParams = outputImageParamsFromJSON(it.getJSONObjectOrNull("outputImageParams"))
    result
}

fun generateMatchFacesRequest(it: MatchFacesRequest) = mapOf(
    "images" to it.images.toJsonNullable(::generateMatchFacesImage),
    "metadata" to it.customMetadata,
    "tag" to it.tag,
    "outputImageParams" to generateOutputImageParams(it.outputImageParams)
).toJson()

fun pointFromJSON(it: JSONObject) = Point(
    it.getInt("x"),
    it.getInt("y")
)

fun generatePoint(it: Point) = mapOf(
    "x" to it.x,
    "y" to it.y
).toJson()

fun rectFromJSON(input: JSONObject?) = input?.let {
    Rect(
        it.getInt("left"),
        it.getInt("top"),
        it.getInt("right"),
        it.getInt("bottom")
    )
}

fun generateRect(input: Rect?) = input?.let {
    mapOf(
        "bottom" to it.bottom,
        "top" to it.top,
        "left" to it.left,
        "right" to it.right
    ).toJson()
}

fun matchFacesDetectionFaceFromJSON(input: JSONObject?) = input?.let {
    val result = MatchFacesDetectionFace::class.constructor(Int::class, java.lang.Double::class, ArrayList::class, Rect::class, Rect::class).instantiate(
        it.getIntOrNull("faceIndex"),
        it.getDoubleOrNull("rotationAngle"),
        it.getJSONArrayOrNull("landmarks").toList(::pointFromJSON).toArrayList(),
        rectFromJSON(it.getJSONObjectOrNull("faceRect")),
        rectFromJSON(it.getJSONObjectOrNull("originalRect"))
    )
    result.setPrivateProperty("crop", it.getStringOrNull("crop").toBitmap())
    result
}

fun generateMatchFacesDetectionFace(input: MatchFacesDetectionFace?) = input?.let {
    mapOf(
        "faceIndex" to it.faceIndex,
        "rotationAngle" to it.rotationAngle,
        "landmarks" to it.landmarks.toJson(::generatePoint),
        "faceRect" to generateRect(it.faceRect),
        "originalRect" to generateRect(it.originalRect),
        "crop" to it.crop.toBase64()
    ).toJson()
}

fun matchFacesDetectionFromJSON(input: JSONObject): MatchFacesDetection = input.let {
    val result = MatchFacesDetection::class.constructor(Int::class, MatchFacesImage::class).instantiate(
        it.getIntOrNull("imageIndex"),
        matchFacesImageFromJSON(it.getJSONObjectOrNull("image"))
    )
    result.setPrivateProperty("faces", it.getJSONArrayOrNull("faces").toList(::matchFacesDetectionFaceFromJSON))
    result.setPrivateProperty("exception", matchFacesExceptionFromJSON(it.getJSONObjectOrNull("error")))
    result
}

fun generateMatchFacesDetection(it: MatchFacesDetection) = mapOf(
    "image" to generateMatchFacesImage(it.image),
    "imageIndex" to it.imageIndex,
    "faces" to it.faces.toJsonNullable(::generateMatchFacesDetectionFace),
    "error" to generateMatchFacesException(it.exception)
).toJson()

fun comparedFaceFromJSON(input: JSONObject): MatchFacesComparedFace = input.let {
    MatchFacesComparedFace::class.constructor(Int::class, MatchFacesImage::class, Integer::class, MatchFacesDetectionFace::class).instantiate(
        it.getInt("imageIndex"),
        matchFacesImageFromJSON(it.getJSONObject("image")),
        it.getIntOrNull("faceIndex"),
        matchFacesDetectionFaceFromJSON(it.getJSONObjectOrNull("face")),
    )
}

fun generateComparedFace(it: MatchFacesComparedFace) = mapOf(
    "imageIndex" to it.imageIndex,
    "image" to generateMatchFacesImage(it.matchesFaceImage),
    "faceIndex" to it.faceIndex,
    "face" to generateMatchFacesDetectionFace(it.detectionFace)
).toJson()

fun comparedFacesPairFromJSON(input: JSONObject): MatchFacesComparedFacesPair = input.let {
    MatchFacesComparedFacesPair::class.constructor(MatchFacesComparedFace::class, MatchFacesComparedFace::class, MatchFacesException::class, java.lang.Float::class, java.lang.Float::class).instantiate(
        comparedFaceFromJSON(it.getJSONObject("first")),
        comparedFaceFromJSON(it.getJSONObject("second")),
        matchFacesExceptionFromJSON(it.getJSONObjectOrNull("error")),
        it.getDouble("similarity").toFloat(),
        it.getDouble("score").toFloat()
    )
}

fun generateComparedFacesPair(it: MatchFacesComparedFacesPair) = mapOf(
    "first" to generateComparedFace(it.first),
    "second" to generateComparedFace(it.second),
    "similarity" to it.similarity,
    "score" to it.score,
    "error" to generateMatchFacesException(it.exception)
).toJson()

fun matchFacesResponseFromJSON(input: JSONObject) = input.let {
    MatchFacesResponse::class.constructor(ArrayList::class, ArrayList::class, String::class, MatchFacesException::class).instantiate(
        it.getJSONArrayOrNull("detections").toList(::matchFacesDetectionFromJSON).toArrayList(),
        it.getJSONArrayOrNull("results").toList(::comparedFacesPairFromJSON).toArrayList(),
        it.getStringOrNull("tag"),
        matchFacesExceptionFromJSON(it.getJSONObjectOrNull("error")),
    )
}

fun generateMatchFacesResponse(it: MatchFacesResponse) = mapOf(
    "detections" to it.detections.toJson(::generateMatchFacesDetection),
    "results" to it.results.toJson(::generateComparedFacesPair),
    "tag" to it.tag,
    "error" to generateMatchFacesException(it.exception)
).toJson()

fun generateComparedFacesSplit(it: MatchFacesSimilarityThresholdSplit) = mapOf(
    "matchedFaces" to it.matchedFaces.toJson(::generateComparedFacesPair),
    "unmatchedFaces" to it.unmatchedFaces.toJson(::generateComparedFacesPair)
).toJson()

// DetectFaces ------------------------------

fun imageQualityRangeFromJSON(input: JSONObject?) = input?.let {
    ImageQualityRange(
        *arrayOf(
            it.getDouble("min"),
            it.getDouble("max")
        ).toDoubleArray()
    )
}

fun generateImageQualityRange(input: ImageQualityRange?) = input?.let {
    mapOf(
        "min" to it.min,
        "max" to it.max
    ).toJson()
}

fun imageQualityCharacteristicFromJSON(it: JSONObject) = getImageQualityCharacteristic(
    it.getString("characteristicName"),
    imageQualityRangeFromJSON(it.getJSONObjectOrNull("recommendedRange")),
    imageQualityRangeFromJSON(it.getJSONObjectOrNull("customRange")),
    it.getLongOrNull("color")
)

fun generateImageQualityCharacteristic(it: ImageQualityCharacteristic) = mapOf(
    "characteristicName" to it.characteristicName.value,
    "recommendedRange" to generateImageQualityRange(it.recommendedRange),
    "customRange" to generateImageQualityRange(it.customRange),
    "color" to if (it is ImageQualityColorCharacteristic) it.color else null
).toJson()

fun detectFacesConfigFromJSON(input: JSONObject?): DetectFacesConfiguration? = input?.let {
    object : DetectFacesConfiguration() {init {
        customQuality = it.getJSONArrayOrNull("customQuality").toList(::imageQualityCharacteristicFromJSON)
        outputImageParams = outputImageParamsFromJSON(it.getJSONObjectOrNull("outputImageParams"))
        onlyCentralFace = it.getBooleanOrNull("onlyCentralFace")
        attributes = it.getJSONArrayOrNull("attributes")?.let { attrs ->
            val result = mutableListOf<DetectFacesAttribute>()
            attrs.forEach { attr -> result.add(DetectFacesAttribute.get(attr as String)) }
            result
        }
    }
    }
}

fun generateDetectFacesConfig(input: DetectFacesConfiguration?) = input?.let {
    mapOf(
        "attributes" to it.attributes.toJson { attr: DetectFacesAttribute -> attr.value },
        "customQuality" to it.customQuality.toJson(::generateImageQualityCharacteristic),
        "outputImageParams" to generateOutputImageParams(it.outputImageParams),
        "onlyCentralFace" to it.onlyCentralFace
    ).toJson()
}

fun detectFacesRequestFromJSON(input: JSONObject) = input.let {
    val image = it.getString("image").toBitmap()!!
    it.getStringOrNull("scenario")?.let { scenario ->
        DetectFacesRequest::class.constructor(Bitmap::class, String::class).instantiate(image, scenario)
    } ?: DetectFacesRequest(
        image,
        detectFacesConfigFromJSON(it.getJSONObjectOrNull("configuration")),
        it.getStringOrNull("tag")
    )
}

fun generateDetectFacesRequest(it: DetectFacesRequest) = mapOf(
    "image" to it.image.toBase64(),
    "scenario" to it.scenario,
    "configuration" to generateDetectFacesConfig(it.configuration),
    "tag" to it.tag
).toJson()

fun imageQualityResultFromJSON(it: JSONObject) = ImageQualityResult(
    ImageQualityGroupName.get(it.getInt("group")),
    it.getString("name"),
    ImageQualityResultStatus.get(it.getInt("status")),
    imageQualityRangeFromJSON(it.getJSONObject("range"))!!,
    it.getDouble("value")
)

fun generateImageQualityResult(it: ImageQualityResult) = mapOf(
    "group" to it.group.value,
    "name" to it.name.value,
    "status" to it.status.value,
    "range" to generateImageQualityRange(it.range),
    "value" to it.value
).toJson()

fun detectFacesAttributeResultFromJSON(it: JSONObject) = DetectFacesAttributeResult(
    DetectFacesAttribute.get(it.getStringOrNull("attribute")),
    it.getStringOrNull("value"),
    it.getDoubleOrNull("confidence"),
    imageQualityRangeFromJSON(it.getJSONObjectOrNull("range")),
)

fun generateDetectFacesAttributeResult(it: DetectFacesAttributeResult) = mapOf(
    "attribute" to it.attribute.value,
    "value" to it.value,
    "confidence" to it.confidence,
    "range" to generateImageQualityRange(it.range)
).toJson()

fun detectFaceResultFromJSON(input: JSONObject?) = input?.let {
    DetectFaceResult(
        it.getJSONArrayOrNull("quality").toList(::imageQualityResultFromJSON),
        it.getJSONArrayOrNull("attributes").toList(::detectFacesAttributeResultFromJSON),
        it.getJSONArrayOrNull("landmarks").toList(::pointFromJSON),
        it.getStringOrNull("crop"),
        rectFromJSON(it.getJSONObjectOrNull("faceRect")),
        rectFromJSON(it.getJSONObjectOrNull("originalRect"))
    )
}

fun generateDetectFaceResult(input: DetectFaceResult?) = input?.let {
    mapOf(
        "quality" to it.quality.toJson(::generateImageQualityResult),
        "attributes" to it.attributes.toJson(::generateDetectFacesAttributeResult),
        "landmarks" to it.landMarks.toJson(::generatePoint),
        "crop" to it.cropImage,
        "faceRect" to generateRect(it.faceRect),
        "originalRect" to generateRect(it.originalRect),
        "isQualityCompliant" to it.isQualityCompliant
    ).toJson()
}

fun detectFacesResponseFromJSON(input: JSONObject): DetectFacesResponse = input.let {
    DetectFacesResponse::class.constructor(String::class, List::class, DetectFacesErrorException::class).instantiate(
        it.getStringOrNull("scenario"),
        it.getJSONArrayOrNull("allDetections").toList(::detectFaceResultFromJSON),
        detectFacesExceptionFromJSON(it.getJSONObjectOrNull("error")),
    )
}

fun generateDetectFacesResponse(it: DetectFacesResponse) = mapOf(
    "detection" to generateDetectFaceResult(it.detection),
    "scenario" to it.scenario,
    "error" to generateDetectFacesException(it.error),
    "allDetections" to it.allDetections.toJsonNullable(::generateDetectFaceResult)
).toJson()

// PersonDatabase ------------------------------

fun generatePersonDBResponse(data: Any?, error: String?) = listOf(
    "data" to data,
    "error" to error
).toJson()

fun personFromJSON(input: JSONObject?) = input?.let {
    val result = Person::class.constructor().instantiate()
    result.name = it.getString("name")
    result.setPrivateProperty("f", it.getJSONArray("groups").toArray<String>())
    result.setPrivateProperty("e", it.getString("updatedAt").toDate())
    result.setPrivateProperty("a", it.getString("id"))
    result.setPrivateProperty("b", it.getJSONObjectOrNull("metadata") ?: JSONObject())
    result.setPrivateProperty("c", it.getString("createdAt").toDate())
    result
}

fun generatePerson(input: Person?) = input?.let {
    mapOf(
        "name" to it.name,
        "groups" to it.groups.toJson(),
        "updatedAt" to it.updatedAt.toStr(),
        "id" to it.id,
        "metadata" to it.metadata,
        "createdAt" to it.createdAt.toStr()
    ).toJson()
}

fun idFromJSON(input: JSONObject): String = input.getString("id")

fun updatePersonFromJSON(result: Person, input: JSONObject) = input.let {
    it.getStringOrNull("name")?.let { name -> result.name = name }
    it.getJSONObjectOrNull("metadata")?.let { metadata -> result.setMetaData(metadata) }
    result
}

fun personImageFromJSON(input: JSONObject?) = input?.let {
    val result = PersonImage::class.constructor().instantiate()
    result.path = it.getString("path")
    result.url = it.getString("url")
    result.contentType = it.getString("contentType")
    result.setPrivateProperty("a", it.getString("id"))
    result.setPrivateProperty("b", it.getJSONObjectOrNull("metadata") ?: JSONObject())
    result.setPrivateProperty("c", it.getString("createdAt").toDate())
    result
}

fun generatePersonImage(input: PersonImage?) = input?.let {
    mapOf(
        "path" to it.path,
        "url" to it.url,
        "contentType" to it.contentType,
        "id" to it.id,
        "metadata" to it.metadata,
        "createdAt" to it.createdAt.toStr()
    ).toJson()
}

fun imageUploadFromJSON(input: JSONObject?) = input?.let {
    object : ImageUpload() { init {
        imageData = it.getStringOrNull("imageData").toByteArray()
        imageUrl = it.getStringOrNull("imageUrl")
    }
    }
}!!

fun generateImageUpload(input: ImageUpload?) = input?.let {
    mapOf(
        "imageData" to it.imageData.toBase64(),
        "imageUrl" to it.imageUrl
    ).toJson()
}

fun personGroupFromJSON(input: JSONObject?) = input?.let {
    val result = PersonGroup::class.constructor().instantiate()
    result.name = it.getString("name")
    result.setPrivateProperty("a", it.getString("id"))
    result.setPrivateProperty("b", it.getJSONObjectOrNull("metadata") ?: JSONObject())
    result.setPrivateProperty("c", it.getString("createdAt").toDate())
    result
}

fun generatePersonGroup(input: PersonGroup?) = input?.let {
    mapOf(
        "name" to it.name,
        "id" to it.id,
        "metadata" to it.metadata,
        "createdAt" to it.createdAt.toStr()
    ).toJson()
}

fun updatePersonGroupFromJSON(result: PersonGroup, input: JSONObject) = input.let {
    it.getStringOrNull("name")?.let { name -> result.name = name }
    it.getJSONObjectOrNull("metadata")?.let { metadata -> result.setMetaData(metadata) }
    result
}

fun editGroupPersonsRequestFromJSON(it: JSONObject) = object : EditGroupPersonsRequest() { init {
    personIdsToAdd = it.getJSONArrayOrNull("personIdsToAdd").toArray()
    personIdsToRemove = it.getJSONArrayOrNull("personIdsToRemove").toArray()
}
}

fun generateEditGroupPersonsRequest(it: EditGroupPersonsRequest) = mapOf(
    "personIdsToAdd" to it.personIdsToAdd.toJson(),
    "personIdsToRemove" to it.personIdsToRemove.toJson()
).toJson()

fun searchPersonRequestFromJSON(it: JSONObject) = object : SearchPersonRequest() { init {
    groupIdsForSearch = it.getJSONArrayOrNull("groupIdsForSearch").toArray()
    threshold = it.getDoubleOrNull("threshold")?.toFloat()
    limit = it.getIntOrNull("limit")
    imageUpload = imageUploadFromJSON(it.getJSONObjectOrNull("imageUpload"))
    isDetectAll = it.optBoolean("detectAll", false)
    outputImageParams = outputImageParamsFromJSON(it.getJSONObjectOrNull("outputImageParams"))
}
}

fun generateSearchPersonRequest(it: SearchPersonRequest) = mapOf(
    "groupIdsForSearch" to it.groupIdsForSearch.toJson(),
    "threshold" to it.threshold,
    "limit" to it.limit,
    "imageUpload" to generateImageUpload(it.imageUpload),
    "detectAll" to it.isDetectAll,
    "outputImageParams" to generateOutputImageParams(it.outputImageParams)
).toJson()

fun searchPersonDetectionFromJSON(input: JSONObject?) = input?.let {
    val result = Detection::class.constructor().instantiate()
    result.setPrivateProperty("landmarks", it.getJSONArrayOrNull("landmarks").toList(::pointFromJSON))
    result.setPrivateProperty("rect", rectFromJSON(it.getJSONObject("rect")))
    result.setPrivateProperty("cropImage", it.getStringOrNull("crop"))
    result.setPrivateProperty("rotationAngle", it.getDouble("rotationAngle"))
    result
}

fun generateSearchPersonDetection(input: Detection?) = input?.let {
    mapOf(
        "landmarks" to it.landmarks.toJson(::generatePoint),
        "rect" to generateRect(it.rect),
        "crop" to it.cropImage,
        // In 6.1 getting NaN from getRotationAngle() on valid request
        // Putting NaN in JSONObject throws an error
        "rotationAngle" to if (!it.rotationAngle.isNaN()) it.rotationAngle else null,
    ).toJson()
}

fun searchPersonImageFromJSON(input: JSONObject): SearchPersonImage = input.let {
    val result = SearchPersonImage::class.constructor(PersonImage::class).instantiate(personImageFromJSON(it))
    result.similarity = it.getDouble("similarity")
    result.distance = it.getDouble("distance")
    result
}

fun generateSearchPersonImage(it: SearchPersonImage) = mapOf(
    "similarity" to it.similarity,
    "distance" to it.distance,
    "path" to it.path,
    "url" to it.url,
    "contentType" to it.contentType,
    "id" to it.id,
    "metadata" to it.metadata,
    "createdAt" to it.createdAt.toStr()
).toJson()

fun searchPersonFromJSON(input: JSONObject?) = input?.let {
    val result = SearchPerson::class.constructor(Person::class).instantiate(personFromJSON(it))
    result.images = it.getJSONArray("images").toList(::searchPersonImageFromJSON)
    result.setPrivateProperty("detection", searchPersonDetectionFromJSON(it.getJSONObjectOrNull("detection")))
    result.setPrivateProperty("f", it.getJSONArray("groups").toArray<String>())
    result
}

fun generateSearchPerson(input: SearchPerson?) = input?.let {
    mapOf(
        "detection" to generateSearchPersonDetection(it.detection),
        "images" to it.images.toJson(::generateSearchPersonImage),
        "name" to it.name,
        "groups" to it.groups.toJson(),
        "updatedAt" to it.updatedAt.toStr(),
        "id" to it.id,
        "metadata" to it.metadata,
        "createdAt" to it.createdAt.toStr()
    ).toJson()
}