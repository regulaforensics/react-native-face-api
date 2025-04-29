package com.reactlibrary

import com.regula.facesdk.configuration.Customization
import com.regula.facesdk.configuration.FaceCaptureConfiguration
import com.regula.facesdk.configuration.LivenessConfiguration
import com.regula.facesdk.configuration.MatchFacesConfiguration
import com.regula.facesdk.detection.request.ImageQualityCharacteristic
import com.regula.facesdk.detection.request.ImageQualityGroup
import com.regula.facesdk.detection.request.ImageQualityRange
import com.regula.facesdk.enums.LivenessType
import com.regula.facesdk.enums.ProcessingMode
import com.regula.facesdk.enums.RecordingProcess
import org.json.JSONArray
import org.json.JSONObject

fun setFaceCaptureConfig(builder: FaceCaptureConfiguration.Builder, config: JSONObject) = config.forEach { k, v ->
    when (k) {
        "copyright" -> builder.setCopyright(v as Boolean)
        "cameraSwitchEnabled" -> builder.setCameraSwitchEnabled(v as Boolean)
        "closeButtonEnabled" -> builder.setCloseButtonEnabled(v as Boolean)
        "torchButtonEnabled" -> builder.setTorchButtonEnabled(v as Boolean)
        "vibrateOnSteps" -> builder.setVibrateOnStep(v as Boolean)
        "detectOcclusion" -> builder.setDetectOcclusion(v as Boolean)
        "showFaceAnimation" -> builder.setShowFaceAnimation(v as Boolean)
        "cameraPositionAndroid" -> builder.setCameraId(v.toInt())
        "screenOrientation" -> builder.setScreenOrientation(*screenOrientationArrayFromJSON(v as JSONArray))
        "timeout" -> builder.setTimeout(v.toFloat())
        "holdStillDuration" -> builder.setHoldStillDuration(v.toFloat())
    }
}

fun getFaceCaptureConfig(input: FaceCaptureConfiguration) = mapOf(
    "copyright" to input.hasCopyright(),
    "cameraSwitchEnabled" to input.isCameraSwitchEnabled,
    "closeButtonEnabled" to input.isCloseButtonEnabled,
    "torchButtonEnabled" to input.isTorchButtonEnabled,
    "vibrateOnSteps" to input.isVibrateOnSteps,
    "detectOcclusion" to input.isDetectOcclusion,
    "showFaceAnimation" to input.isShowFaceAnimation,
    "cameraPositionAndroid" to input.cameraId,
    "screenOrientation" to generateScreenOrientationArray(input.screenOrientation),
    "timeout" to input.timeout,
    "holdStillDuration" to input.holdStillDuration,
).toJson()

fun setLivenessConfig(builder: LivenessConfiguration.Builder, config: JSONObject) = config.forEach { k, v ->
    when (k) {
        "copyright" -> builder.setCopyright(v as Boolean)
        "cameraSwitchEnabled" -> builder.setCameraSwitchEnabled(v as Boolean)
        "closeButtonEnabled" -> builder.setCloseButtonEnabled(v as Boolean)
        "torchButtonEnabled" -> builder.setTorchButtonEnabled(v as Boolean)
        "vibrateOnSteps" -> builder.setVibrateOnStep(v as Boolean)
        "cameraPositionAndroid" -> builder.setCameraId(v.toInt())
        "screenOrientation" -> builder.setScreenOrientation(*screenOrientationArrayFromJSON(v as JSONArray))
        "locationTrackingEnabled" -> builder.setLocationTrackingEnabled(v as Boolean)
        "attemptsCount" -> builder.setAttemptsCount(v.toInt())
        "recordingProcess" -> builder.setRecordingProcess(RecordingProcess.values()[v.toInt()])
        "livenessType" -> builder.setType(LivenessType.values()[v.toInt()])
        "tag" -> builder.setTag(v as String)
        "skipStep" -> builder.setSkipStep(*livenessSkipStepArrayFromJSON(v as JSONArray))
        "metadata" -> builder.setMetadata(v as JSONObject)
    }
}

fun getLivenessConfig(input: LivenessConfiguration) = mapOf(
    "copyright" to input.hasCopyright(),
    "cameraSwitchEnabled" to input.isCameraSwitchEnabled,
    "closeButtonEnabled" to input.isCloseButtonEnabled,
    "torchButtonEnabled" to input.isTorchButtonEnabled,
    "vibrateOnSteps" to input.isVibrateOnSteps,
    "cameraPositionAndroid" to input.cameraId,
    "screenOrientation" to generateScreenOrientationArray(input.screenOrientation),
    "locationTrackingEnabled" to input.isLocationTrackingEnabled,
    "attemptsCount" to input.attemptsCount,
    "recordingProcess" to input.recordingProcess.ordinal,
    "livenessType" to input.type.ordinal,
    "tag" to input.tag,
    "skipStep" to generateLivenessSkipStepArray(input.skipStep),
    "metadata" to input.metadata,
).toJson()

fun setMatchFacesConfig(builder: MatchFacesConfiguration.Builder, config: JSONObject) = config.forEach { k, v ->
    when (k) {
        "processingMode" -> builder.setProcessingMode(ProcessingMode.values()[v.toInt()])
        "locationTrackingEnabled" -> builder.setLocationTrackingEnabled(v as Boolean)
    }
}

fun getMatchFacesConfig(input: MatchFacesConfiguration) = mapOf(
    "processingMode" to input.processingMode.ordinal,
    "locationTrackingEnabled" to input.isLocationTrackingEnabled
).toJson()

fun setCustomization(input: Customization, config: JSONObject) = config.forEach { key, value ->
    when (key) {
        "colors" -> (value as JSONObject).forEach { k, v -> k.setColor(input, v) }
        "fonts" -> (value as JSONObject).forEach { k, v -> k.setFont(input, v) }
        "images" -> (value as JSONObject).forEach { k, v -> k.setImage(input, v) }
        "uiCustomizationLayer" -> input.setUiCustomizationLayer(value as JSONObject)
    }
}

fun getImageQualityCharacteristic(
    name: String,
    recommendedRange: ImageQualityRange?,
    customRange: ImageQualityRange?,
    color: Long?
): ImageQualityCharacteristic {
    val min = recommendedRange?.min ?: 0.0
    val max = recommendedRange?.max ?: 0.0
    val result = when (name) {
        "ImageWidth" -> ImageQualityGroup.ImageCharacteristic.imageWidthWithRange(min, max)
        "ImageHeight" -> ImageQualityGroup.ImageCharacteristic.imageHeightWithRange(min, max)
        "ImageWidthToHeight" -> ImageQualityGroup.ImageCharacteristic.imageWidthToHeightWithRange(min, max)
        "ImageChannelsNumber" -> ImageQualityGroup.ImageCharacteristic.imageChannelsNumberWithValue(min)
        "PaddingRatio" -> ImageQualityGroup.ImageCharacteristic.paddingRatio(min, max)
        "ArtFace" -> ImageQualityGroup.ImageCharacteristic.artFace()

        "FaceMidPointHorizontalPosition" -> ImageQualityGroup.HeadSizeAndPosition.faceMidPointHorizontalPosition()
        "FaceMidPointVerticalPosition" -> ImageQualityGroup.HeadSizeAndPosition.faceMidPointVerticalPosition()
        "HeadWidthRatio" -> ImageQualityGroup.HeadSizeAndPosition.headWidthRatio()
        "HeadHeightRatio" -> ImageQualityGroup.HeadSizeAndPosition.headHeightRatio()
        "EyesDistance" -> ImageQualityGroup.HeadSizeAndPosition.eyesDistance()
        "Yaw" -> ImageQualityGroup.HeadSizeAndPosition.yaw()
        "Pitch" -> ImageQualityGroup.HeadSizeAndPosition.pitch()
        "Roll" -> ImageQualityGroup.HeadSizeAndPosition.roll()

        "BlurLevel" -> ImageQualityGroup.FaceImageQuality.blurLevel()
        "NoiseLevel" -> ImageQualityGroup.FaceImageQuality.noiseLevel()
        "UnnaturalSkinTone" -> ImageQualityGroup.FaceImageQuality.unnaturalSkinTone()
        "FaceDynamicRange" -> ImageQualityGroup.FaceImageQuality.faceDynamicRange()

        "EyeRightClosed" -> ImageQualityGroup.EyesCharacteristics.eyeRightClosed()
        "EyeLeftClosed" -> ImageQualityGroup.EyesCharacteristics.eyeLeftClosed()
        "EyeRightOccluded" -> ImageQualityGroup.EyesCharacteristics.eyeRightOccluded()
        "EyeLeftOccluded" -> ImageQualityGroup.EyesCharacteristics.eyeLeftOccluded()
        "EyesRed" -> ImageQualityGroup.EyesCharacteristics.eyesRed()
        "EyeRightCoveredWithHair" -> ImageQualityGroup.EyesCharacteristics.eyeRightCoveredWithHair()
        "EyeLeftCoveredWithHair" -> ImageQualityGroup.EyesCharacteristics.eyeLeftCoveredWithHair()
        "OffGaze" -> ImageQualityGroup.EyesCharacteristics.offGaze()

        "TooDark" -> ImageQualityGroup.ShadowsAndLightning.tooDark()
        "TooLight" -> ImageQualityGroup.ShadowsAndLightning.tooLight()
        "FaceGlare" -> ImageQualityGroup.ShadowsAndLightning.faceGlare()
        "ShadowsOnFace" -> ImageQualityGroup.ShadowsAndLightning.shadowsOnFace()

        "ShouldersPose" -> ImageQualityGroup.PoseAndExpression.shouldersPose()
        "ExpressionLevel" -> ImageQualityGroup.PoseAndExpression.expressionLevel()
        "MouthOpen" -> ImageQualityGroup.PoseAndExpression.mouthOpen()
        "Smile" -> ImageQualityGroup.PoseAndExpression.smile()

        "DarkGlasses" -> ImageQualityGroup.HeadOcclusion.darkGlasses()
        "ReflectionOnGlasses" -> ImageQualityGroup.HeadOcclusion.reflectionOnGlasses()
        "FramesTooHeavy" -> ImageQualityGroup.HeadOcclusion.framesTooHeavy()
        "FaceOccluded" -> ImageQualityGroup.HeadOcclusion.faceOccluded()
        "HeadCovering" -> ImageQualityGroup.HeadOcclusion.headCovering()
        "ForeheadCovering" -> ImageQualityGroup.HeadOcclusion.foreheadCovering()
        "StrongMakeup" -> ImageQualityGroup.HeadOcclusion.strongMakeup()
        "Headphones" -> ImageQualityGroup.HeadOcclusion.headphones()
        "MedicalMask" -> ImageQualityGroup.HeadOcclusion.medicalMask()

        "BackgroundUniformity" -> ImageQualityGroup.QualityBackground.backgroundUniformity()
        "ShadowsOnBackground" -> ImageQualityGroup.QualityBackground.shadowsOnBackground()
        "OtherFaces" -> ImageQualityGroup.QualityBackground.otherFaces()
        "BackgroundColorMatch" -> color?.let { ImageQualityGroup.QualityBackground.backgroundColorMatchWithColor(it) }
            ?: ImageQualityGroup.QualityBackground.backgroundColorMatch()

        else -> throw Exception("ImageQualityCharacteristicName not found")
    }
    return customRange?.let { result.withCustomRange(it.min, it.max) } ?: result
}