import { NativeModules } from 'react-native'
export const { RNFaceApi } = NativeModules

// Classes

export class FaceCaptureException {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new FaceCaptureException()

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result
    }
}

export class LivenessErrorException {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new LivenessErrorException()

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result
    }
}

export class MatchFacesException {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new MatchFacesException()

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result
    }
}

export class FaceCaptureResponse {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new FaceCaptureResponse()

        result.exception = FaceCaptureException.fromJson(jsonObject["exception"])
        result.image = Image.fromJson(jsonObject["image"])

        return result
    }
}

export class LivenessResponse {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new LivenessResponse()

        result.bitmap = jsonObject["bitmap"]
        result.liveness = jsonObject["liveness"]
        result.guid = jsonObject["guid"]
        result.exception = LivenessErrorException.fromJson(jsonObject["exception"])

        return result
    }
}

export class MatchFacesResponse {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new MatchFacesResponse()

        result.exception = MatchFacesException.fromJson(jsonObject["exception"])
        result.matchedFaces = []
        if (jsonObject["matchedFaces"] != null)
            for (const i in jsonObject["matchedFaces"])
                result.matchedFaces.push(MatchFacesComparedFacesPair.fromJson(jsonObject["matchedFaces"][i]))
        result.unmatchedFaces = []
        if (jsonObject["unmatchedFaces"] != null)
            for (const i in jsonObject["unmatchedFaces"])
                result.unmatchedFaces.push(MatchFacesComparedFacesPair.fromJson(jsonObject["unmatchedFaces"][i]))
        result.facesResponse = []
        if (jsonObject["facesResponse"] != null)
            for (const i in jsonObject["facesResponse"])
                result.facesResponse.push(MatchFacesDetection.fromJson(jsonObject["facesResponse"][i]))
        result.results = []
        if (jsonObject["results"] != null)
            for (const i in jsonObject["results"])
                result.results.push(MatchFacesComparedFacesPair.fromJson(jsonObject["results"][i]))

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

export class MatchFacesRequest {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new MatchFacesRequest()

        result.matchFacesImages = []
        if (jsonObject["matchFacesImages"] != null)
            for (const i in jsonObject["matchFacesImages"])
                result.matchFacesImages.push(MatchFacesImage.fromJson(jsonObject["matchFacesImages"][i]))
        result.customMetadata = jsonObject["customMetadata"]
        result.thumbnails = jsonObject["thumbnails"]

        return result
    }
}

export class MatchFacesImage {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new MatchFacesImage()

        result.imageType = jsonObject["imageType"]
        result.detectAll = jsonObject["detectAll"]
        result.bitmap = jsonObject["bitmap"]

        return result
    }
}

export class MatchFacesComparedFacesPair {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new MatchFacesComparedFacesPair()

        result.first = MatchFacesComparedFace.fromJson(jsonObject["first"])
        result.second = MatchFacesComparedFace.fromJson(jsonObject["second"])
        result.similarity = jsonObject["similarity"]
        result.score = jsonObject["score"]
        result.exception = MatchFacesException.fromJson(jsonObject["exception"])

        return result
    }
}

export class MatchFacesComparedFace {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new MatchFacesComparedFace()

        result.detectionFace = MatchFacesDetectionFace.fromJson(jsonObject["detectionFace"])
        result.matchesFaceImage = MatchFacesImage.fromJson(jsonObject["matchesFaceImage"])
        result.faceIndex = jsonObject["faceIndex"]
        result.imageIndex = jsonObject["imageIndex"]

        return result
    }
}

export class MatchFacesDetectionFace {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new MatchFacesDetectionFace()

        result.faceIndex = jsonObject["faceIndex"]
        result.landmarks = []
        if (jsonObject["landmarks"] != null)
            for (const i in jsonObject["landmarks"])
                result.landmarks.push(Point.fromJson(jsonObject["landmarks"][i]))
        result.faceRect = Rect.fromJson(jsonObject["faceRect"])
        result.rotationAngle = jsonObject["rotationAngle"]
        result.thumbnail = jsonObject["thumbnail"]

        return result
    }
}

export class MatchFacesDetection {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new MatchFacesDetection()

        result.image = MatchFacesImage.fromJson(jsonObject["image"])
        result.imageIndex = jsonObject["imageIndex"]
        result.faces = []
        if (jsonObject["faces"] != null)
            for (const i in jsonObject["faces"])
                result.faces.push(MatchFacesDetectionFace.fromJson(jsonObject["faces"][i]))
        result.exception = MatchFacesException.fromJson(jsonObject["exception"])

        return result
    }
}

export class Point {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new Point()

        result.x = jsonObject["x"]
        result.y = jsonObject["y"]

        return result
    }
}

export class Rect {
    static fromJson(jsonObject) {
        if (jsonObject == null) return null
        const result = new Rect()

        result.bottom = jsonObject["bottom"]
        result.top = jsonObject["top"]
        result.left = jsonObject["left"]
        result.right = jsonObject["right"]

        return result
    }
}

// Enum

export const ComparedFacesPairErrorCodes = {
    IMAGE_EMPTY: 1,
    FACE_NOT_DETECTED: 2,
    LANDMARKS_NOT_DETECTED: 3,
    FACE_ALIGNER_FAILED: 4,
    DESCRIPTOR_EXTRACTOR_ERROR: 5,
    API_CALL_FAILED: 6,
}

export const FaceCaptureResultCodes = {
    CANCEL: 1,
    CAMERA_NOT_AVAILABLE: 2,
    CAMERA_NO_PERMISSION: 3,
    IN_PROGRESS_ALREADY: 4,
    CONTEXT_IS_NULL: 5,
}

export const ImageType = {
    IMAGE_TYPE_PRINTED: 1,
    IMAGE_TYPE_RFID: 2,
    IMAGE_TYPE_LIVE: 3,
    IMAGE_TYPE_LIVE_WITH_DOC: 4,
}

export const LivenessErrorCode = {
    CONTEXT_IS_NULL: 1,
    IN_PROGRESS_ALREADY: 2,
    ZOOM_NOT_SUPPORTED: 3,
    NO_LICENSE: 4,
    CANCELLED: 5,
    PROCESSING_TIMEOUT: 6,
    API_CALL_FAILED: 7,
    PROCESSING_FAILED: 8,
    PROCESSING_ATTEMPTS_ENDED: 9,
}

export const LivenessStatus = {
    PASSED: 0,
    UNKNOWN: 1,
}

export const MatchFacesErrorCodes = {
    IMAGE_EMPTY: 1,
    FACE_NOT_DETECTED: 2,
    LANDMARKS_NOT_DETECTED: 3,
    FACE_ALIGNER_FAILED: 4,
    DESCRIPTOR_EXTRACTOR_ERROR: 5,
    NO_LICENSE: 6,
    NOT_INITIALIZED: 7,
    COMMAND_IS_NOT_SUPPORTED: 8,
    COMMAND_PARAMS_READ_ERROR: 9,
    API_CALL_FAILED: 10,
    PROCESSING_FAILED: 11,
}

export const RFSCameraPosition = {
    RFSCameraPositionBack: 0,
    RFSCameraPositionFront: 1,
}

export const Enum = {
   ComparedFacesPairErrorCodes,
   FaceCaptureResultCodes,
   ImageType,
   LivenessErrorCode,
   LivenessStatus,
   MatchFacesErrorCodes,
   RFSCameraPosition,
}

const FaceSDK = {}

FaceSDK.getServiceUrl = (successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "getServiceUrl", [], successCallback, errorCallback)
FaceSDK.startLiveness = (successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "startLiveness", [], successCallback, errorCallback)
FaceSDK.getFaceSdkVersion = (successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "getFaceSdkVersion", [], successCallback, errorCallback)
FaceSDK.presentFaceCaptureActivity = (successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "presentFaceCaptureActivity", [], successCallback, errorCallback)
FaceSDK.stopFaceCaptureActivity = (successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "stopFaceCaptureActivity", [], successCallback, errorCallback)
FaceSDK.stopLivenessProcessing = (successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "stopLivenessProcessing", [], successCallback, errorCallback)
FaceSDK.presentFaceCaptureActivityWithConfig = (config, successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "presentFaceCaptureActivityWithConfig", [config], successCallback, errorCallback)
FaceSDK.startLivenessWithConfig = (config, successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "startLivenessWithConfig", [config], successCallback, errorCallback)
FaceSDK.setServiceUrl = (url, successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "setServiceUrl", [url], successCallback, errorCallback)
FaceSDK.matchFaces = (request, successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "matchFaces", [request], successCallback, errorCallback)
FaceSDK.setLanguage = (language, successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "setLanguage", [language], successCallback, errorCallback)
FaceSDK.setConfig = (config, successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "setConfig", [config], successCallback, errorCallback)
FaceSDK.matchFacesWithConfig = (request, config, successCallback, errorCallback) => RNFaceApi.exec("FaceApi", "matchFacesWithConfig", [request, config], successCallback, errorCallback)

export default FaceSDK