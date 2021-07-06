import { NativeModules } from 'react-native'
export const { RNFaceApi } = NativeModules

// Classes

export class FaceCaptureError {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new FaceCaptureError()

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result
    }
}

export class FaceProcessorError {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new FaceProcessorError()

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result
    }
}

export class LivenessError {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new LivenessError()

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result
    }
}

export class MatchFacesError {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new MatchFacesError()

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result
    }
}

export class AgeRange {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new AgeRange()

        result.high = jsonObject["high"]
        result.low = jsonObject["low"]

        return result
    }
}

export class ComparedFace {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new ComparedFace()

        result.tag = jsonObject["tag"]
        result.imageType = jsonObject["imageType"]
        result.position = jsonObject["position"]

        return result
    }
}

export class ComparedFacesPair {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new ComparedFacesPair()

        result.first = ComparedFace.fromJson(jsonObject["first"])
        result.second = ComparedFace.fromJson(jsonObject["second"])
        result.similarity = jsonObject["similarity"]
        result.error = MatchFacesError.fromJson(jsonObject["error"])

        return result
    }
}

export class Ethnicity {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new Ethnicity()

        result.confidence = jsonObject["confidence"]
        result.value = jsonObject["value"]

        return result
    }
}

export class FaceCaptureResponse {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new FaceCaptureResponse()

        result.error = FaceCaptureError.fromJson(jsonObject["error"])
        result.image = Image.fromJson(jsonObject["image"])

        return result
    }
}

export class Gender {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new Gender()

        result.confidence = jsonObject["confidence"]
        result.value = jsonObject["value"]

        return result
    }
}

export class Landmark {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new Landmark()

        result.type = jsonObject["type"]
        result.x = jsonObject["x"]
        result.y = jsonObject["y"]

        return result
    }
}

export class LivenessResponse {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new LivenessResponse()

        result.bitmap = jsonObject["bitmap"]
        result.liveness = jsonObject["liveness"]
        result.error = LivenessError.fromJson(jsonObject["error"])

        return result
    }
}

export class MatchFacesResponse {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new MatchFacesResponse()

        result.error = FaceProcessorError.fromJson(jsonObject["error"])
        result.matchedFaces = []
        if (jsonObject["matchedFaces"] != null)
            for (const i in jsonObject["matchedFaces"])
                result.matchedFaces.push(ComparedFacesPair.fromJson(jsonObject["matchedFaces"][i]))
        result.unmatchedFaces = []
        if (jsonObject["unmatchedFaces"] != null)
            for (const i in jsonObject["unmatchedFaces"])
                result.unmatchedFaces.push(ComparedFacesPair.fromJson(jsonObject["unmatchedFaces"][i]))

        return result
    }
}

export class Image {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new Image()

        result.imageType = jsonObject["imageType"]
        result.tag = jsonObject["tag"]
        result.bitmap = jsonObject["bitmap"]

        return result
    }
}

export class LivenessRequest {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new LivenessRequest()

        result.normalImageData = []
        if (jsonObject["normalImageData"] != null)
            for (const i in jsonObject["normalImageData"])
                result.normalImageData.push(jsonObject["normalImageData"][i])
        result.scaledImageData = []
        if (jsonObject["scaledImageData"] != null)
            for (const i in jsonObject["scaledImageData"])
                result.scaledImageData.push(jsonObject["scaledImageData"][i])
        result.requestBody = []
        if (jsonObject["requestBody"] != null)
            for (const i in jsonObject["requestBody"])
                result.requestBody.push(jsonObject["requestBody"][i])
        result.guid = jsonObject["guid"]

        return result
    }
}

export class MatchFacesRequest {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new MatchFacesRequest()

        result.similarityThreshold = jsonObject["similarityThreshold"]
        result.images = []
        if (jsonObject["images"] != null)
            for (const i in jsonObject["images"])
                result.images.push(Image.fromJson(jsonObject["images"][i]))
        result.customMetadata = jsonObject["customMetadata"]

        return result
    }
}

// Enum

export const eFaceRProcessorErrorCodes = {
    FR_IMAGE_EMPTY: 1,
    FR_FACE_NOT_DETECTED: 2,
    FR_LANDMARKS_NOT_DETECTED: 3,
    FR_FACE_ALIGHNER_FAILED: 4,
    FR_DESCRIPTOR_EXTRACTOR_ERROR: 5,
    SERVER_RESPONSE_IS_EMPTY: 1001,
    NO_LICENSE: 200,
    NOT_INITIALIZED: 201,
    COMMAND_IS_NOT_SUPPORTED: 202,
    COMMAND_PARAMS_READ_ERROR: 203,
}

export const eInputFaceType = {
    ift_DocumentPrinted: 1,
    ift_DocumentRFID: 2,
    ift_Live: 3,
    ift_LiveWithDoc: 4,
}

export const FaceCaptureResultCodes = {
    CANCEL: 1,
    CAMERA_NOT_AVAILABLE: 2,
    CAMERA_NO_PERMISSION: 3,
    IN_PROGRESS_ALREADY: 4,
}

export const LivenessErrorCode = {
    INTERNAL_ERROR: 1000,
    SERVER_ERROR: 1001,
    ZOOM_NOT_SUPPORTED: 1002,
    NO_LICENSE: 200,
    CANCELLED: 600,
    PROCESSING_TIMEOUT: 601,
    SERVER_RESPONSE_IS_EMPTY: 602,
    PROCESSING_FAILED: 603,
    PROCESSING_ATTEMPT_ENDED: 604,
}

export const LivenessStatus = {
    PASSED: 0,
    UNKNOWN: 1,
}

export const Enum = {
   eFaceRProcessorErrorCodes,
   eInputFaceType,
   FaceCaptureResultCodes,
   LivenessErrorCode,
   LivenessStatus,
}

const FaceSDK = {}

FaceSDK.getServiceUrl = (successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "getServiceUrl", [], successCallback, errorCallback)
FaceSDK.startLiveness = (successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "startLiveness", [], successCallback, errorCallback)
FaceSDK.getFaceSdkVersion = (successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "getFaceSdkVersion", [], successCallback, errorCallback)
FaceSDK.presentFaceCaptureActivity = (successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "presentFaceCaptureActivity", [], successCallback, errorCallback)
FaceSDK.stopFaceCaptureActivity = (successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "stopFaceCaptureActivity", [], successCallback, errorCallback)
FaceSDK.stopLivenessProcessing = (successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "stopLivenessProcessing", [], successCallback, errorCallback)
FaceSDK.presentFaceCaptureActivityByCameraId = (cameraId, successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "presentFaceCaptureActivityByCameraId", [cameraId], successCallback, errorCallback)
FaceSDK.startLivenessByCameraId = (cameraId, successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "startLivenessByCameraId", [cameraId], successCallback, errorCallback)
FaceSDK.setServiceUrl = (url, successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "setServiceUrl", [url], successCallback, errorCallback)
FaceSDK.matchFaces = (request, successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "matchFaces", [request], successCallback, errorCallback)

export default FaceSDK