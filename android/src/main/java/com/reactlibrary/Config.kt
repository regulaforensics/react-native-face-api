package com.reactlibrary

import android.content.Context
import com.regula.facesdk.configuration.FaceCaptureConfiguration
import com.regula.facesdk.configuration.LivenessConfiguration
import com.regula.facesdk.configuration.UiConfiguration
import com.regula.facesdk.enums.CustomizationColor
import com.regula.facesdk.enums.CustomizationFont
import com.regula.facesdk.enums.CustomizationImage
import org.json.JSONArray
import org.json.JSONObject

fun faceCaptureConfigFromJSON(config: JSONObject): FaceCaptureConfiguration {
    val builder = FaceCaptureConfiguration.Builder()
    config.forEach { key, value ->
        when (key) {
            "copyright" -> builder.setCopyright(value as Boolean)
            "cameraSwitchEnabled" -> builder.setCameraSwitchEnabled(value as Boolean)
            "closeButtonEnabled" -> builder.setCloseButtonEnabled(value as Boolean)
            "torchButtonEnabled" -> builder.setTorchButtonEnabled(value as Boolean)
            // it is Int, but in react it is initially received as Double
            "cameraId" -> builder.setCameraId(if (value is Double) value.toInt() else (value as Int))
            "timeout" -> builder.setTimeout(if (value is Double) value.toFloat() else (value as Float))
            "holdStillDuration" -> builder.setHoldStillDuration(if (value is Double) value.toFloat() else (value as Float))
        }
    }
    return builder.build()
}

fun livenessConfigFromJSON(config: JSONObject): LivenessConfiguration {
    val builder = LivenessConfiguration.Builder()
    config.forEach { key, value ->
        when (key) {
            "copyright" -> builder.setCopyright(value as Boolean)
            "locationTrackingEnabled" -> builder.setLocationTrackingEnabled(value as Boolean)
            "closeButtonEnabled" -> builder.setCloseButtonEnabled(value as Boolean)
            "recordingProcess" -> builder.setRecordingProcess(value as Boolean)
            // it is Int, but in react it is initially received as Double
            "attemptsCount" -> builder.setAttemptsCount(if (value is Double) value.toInt() else (value as Int))
            "tag" -> builder.setTag(value as String)
            "skipStep" -> builder.setSkipStep(*JSONConstructor.LivenessSkipStepArrayFromJSON(value as JSONArray))
        }
    }
    return builder.build()
}

fun uiConfigFromJSON(config: JSONObject, context: Context): UiConfiguration {
    val builder = UiConfiguration.Builder()
    config.forEach { key, value ->
        when (key.substringBefore('.')) {
            "CustomizationColor" -> builder.setColor(
                CustomizationColor.valueOf(key.substringAfter('.')),
                // it is Long, but in react it is initially received as Double
                (if (value is Double) value.toLong() else (value as Long)).toInt()
            )

            "CustomizationImage" -> builder.setImage(
                CustomizationImage.valueOf(key.substringAfter('.')),
                drawableFromJSON(value as String, context)
            )

            "CustomizationFont" -> builder.setFont(
                CustomizationFont.valueOf(key.substringAfter('.')),
                JSONConstructor.typeFaceFromJSON(value as JSONObject)
            )
        }
    }
    return builder.build()
}