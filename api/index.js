import { NativeModules } from 'react-native'
const { RNFaceApi } = NativeModules

// Classes

class FaceCaptureError {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new FaceCaptureError()

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result;
    }
}

class FaceProcessorError {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new FaceProcessorError()

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result;
    }
}

class LivenessError {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new LivenessError()

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result;
    }
}

class MatchFacesError {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new MatchFacesError()

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result;
    }
}

class LivenessParams {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new LivenessParams()

        result.attemptsCount = jsonObject["attemptsCount"]

        return result;
    }
}

class AgeRange {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new AgeRange()

        result.high = jsonObject["high"]
        result.low = jsonObject["low"]

        return result;
    }
}

class BoundingBox {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new BoundingBox()

        result.left = jsonObject["left"]
        result.top = jsonObject["top"]
        result.height = jsonObject["height"]
        result.width = jsonObject["width"]

        return result;
    }
}

class ComparedFace {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new ComparedFace()

        result.tag = jsonObject["tag"]
        result.imageType = jsonObject["imageType"]
        result.position = jsonObject["position"]

        return result;
    }
}

class ComparedFacesPair {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new ComparedFacesPair()

        result.first = ComparedFace.fromJson(jsonObject["first"])
        result.second = ComparedFace.fromJson(jsonObject["second"])
        result.similarity = jsonObject["similarity"]

        return result;
    }
}

class Ethnicity {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new Ethnicity()

        result.confidence = jsonObject["confidence"]
        result.value = jsonObject["value"]

        return result;
    }
}

class FaceCaptureResponse {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new FaceCaptureResponse()

        result.error = FaceCaptureError.fromJson(jsonObject["error"])
        result.capturedImage = Image.fromJson(jsonObject["capturedImage"])

        return result;
    }
}

class FaceDetail {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new FaceDetail()

        result.ageRange = AgeRange.fromJson(jsonObject["ageRange"])
        result.boundingBox = BoundingBox.fromJson(jsonObject["boundingBox"])
        result.gender = Gender.fromJson(jsonObject["gender"])
        result.landmarks = []
        if (jsonObject["landmarks"] != null)
            for (const i in jsonObject["landmarks"])
                result.landmarks.push(Landmark.fromJson(jsonObject["landmarks"][i]))
        result.ethnicity = []
        if (jsonObject["ethnicity"] != null)
            for (const i in jsonObject["ethnicity"])
                result.ethnicity.push(Ethnicity.fromJson(jsonObject["ethnicity"][i]))

        return result;
    }
}

class Gender {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new Gender()

        result.confidence = jsonObject["confidence"]
        result.value = jsonObject["value"]

        return result;
    }
}

class Landmark {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new Landmark()

        result.type = jsonObject["type"]
        result.x = jsonObject["x"]
        result.y = jsonObject["y"]

        return result;
    }
}

class LivenessResponse {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new LivenessResponse()

        result.bitmaps = []
        if (jsonObject["bitmaps"] != null)
            for (const i in jsonObject["bitmaps"])
                result.bitmaps.push(jsonObject["bitmaps"][i])
        result.faceIndex = jsonObject["faceIndex"]
        result.liveness = jsonObject["liveness"]
        result.error = LivenessError.fromJson(jsonObject["error"])

        return result;
    }
}

class MatchFacesResponse {
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

        return result;
    }
}

class Image {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new Image()

        result.imageType = jsonObject["imageType"]
        result.tag = jsonObject["tag"]
        result.bitmap = jsonObject["bitmap"]

        return result;
    }
}

class LivenessRequest {
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

        return result;
    }
}

class MatchFacesRequest {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new MatchFacesRequest()

        result.similarityThreshold = jsonObject["similarityThreshold"]
        result.images = []
        if (jsonObject["images"] != null)
            for (const i in jsonObject["images"])
                result.images.push(Image.fromJson(jsonObject["images"][i]))
        result.customMetadata = jsonObject["customMetadata"]

        return result;
    }
}

// Enum

const eFaceRProcessorErrorCodes = {
    FR_IMAGE_EMPTY: 1,
    FR_FACE_NOT_DETECTED: 2,
    FR_LANDMARKS_NOT_DETECTED: 3,
    FR_FACE_ALIGHNER_FAILED: 4,
    FR_DESCRIPTOR_EXTRACTOR_ERROR: 5,
    SERVER_RESPONSE_IS_EMPTY: 1001,
    RGLFaceProcessorResultCodeNoLicense: 200,
    RGLFaceProcessorResultCodeIsNotInitialized: 201,
    RGLFaceProcessorResultCodeCommandIsNotSupported: 202,
    RGLFaceProcessorResultCodeCommandParamsReadError: 203,
}

const eInputFaceType = {
    ift_DocumentPrinted: 1,
    ift_DocumentRFID: 2,
    ift_Live: 3,
    ift_LiveWithDoc: 4,
}

const FaceCaptureResultCodes = {
    CANCEL: 1,
    CAMERA_NOT_AVAILABLE: 2,
    CAMERA_NO_PERMISSION: 3,
    IN_PROGRESS_ALREADY: 4,
}

const LivenessErrorCode = {
    INTERNAL_ERROR: 1000,
    SERVER_ERROR: 1001,
    ZOOM_NOT_SUPPORTED: 1002,
    CANCELLED: 600,
    PROCESSING_TIMEOUT: 601,
    SERVER_RESPONSE_IS_EMPTY: 602,
    PROCESSING_FAILED: 603,
    PROCESSING_ATTEMPT_ENDED: 604,
}

const LivenessStatus = {
    PASSED: 0,
    UNKNOWN: 1,
}

const Enum = {
   eFaceRProcessorErrorCodes,
   eInputFaceType,
   FaceCaptureResultCodes,
   LivenessErrorCode,
   LivenessStatus,
}

const FaceApi = {}

FaceApi.getServiceUrl = (successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "getServiceUrl", [], successCallback, errorCallback)
FaceApi.startLivenessMatching = (successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "startLivenessMatching", [], successCallback, errorCallback)
FaceApi.getFaceSdkVersion = (successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "getFaceSdkVersion", [], successCallback, errorCallback)
FaceApi.livenessParams = (successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "livenessParams", [], successCallback, errorCallback)
FaceApi.presentFaceCaptureActivity = (successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "presentFaceCaptureActivity", [], successCallback, errorCallback)
FaceApi.stopFaceCaptureActivity = (successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "stopFaceCaptureActivity", [], successCallback, errorCallback)
FaceApi.stopLivenessProcessing = (successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "stopLivenessProcessing", [], successCallback, errorCallback)
FaceApi.presentFaceCaptureActivityByCameraId = (cameraId, successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "presentFaceCaptureActivityByCameraId", [cameraId], successCallback, errorCallback)
FaceApi.startLivenessMatchingByCameraId = (cameraId, successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "startLivenessMatchingByCameraId", [cameraId], successCallback, errorCallback)
FaceApi.setServiceUrl = (url, successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "setServiceUrl", [url], successCallback, errorCallback)
FaceApi.matchFaces = (request, successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "matchFaces", [request], successCallback, errorCallback)

FaceApi.Enum = Enum
FaceApi.FaceCaptureResponse = FaceCaptureResponse
FaceApi.LivenessResponse = LivenessResponse
FaceApi.MatchFacesResponse = MatchFacesResponse
FaceApi.MatchFacesRequest = MatchFacesRequest
FaceApi.Image = Image

export default { FaceApi, RNFaceApi }