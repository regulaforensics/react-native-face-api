import { NativeModules } from 'react-native'
export const { RNFaceApi } = NativeModules

export class FaceCaptureException {
    errorCode?: number
    message?: string

    static fromJson(jsonObject?: any): FaceCaptureException {
        if (jsonObject == null) return null
        const result = new FaceCaptureException

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result
    }
}

export class LivenessErrorException {
    errorCode?: number
    message?: string

    static fromJson(jsonObject?: any): LivenessErrorException {
        if (jsonObject == null) return null
        const result = new LivenessErrorException

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result
    }
}

export class MatchFacesException {
    errorCode?: number
    message?: string

    static fromJson(jsonObject?: any): MatchFacesException {
        if (jsonObject == null) return null
        const result = new MatchFacesException

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result
    }
}

export class FaceCaptureResponse {
    exception?: FaceCaptureException
    image?: Image

    static fromJson(jsonObject?: any): FaceCaptureResponse {
        if (jsonObject == null) return null
        const result = new FaceCaptureResponse

        result.exception = FaceCaptureException.fromJson(jsonObject["exception"])
        result.image = Image.fromJson(jsonObject["image"])

        return result
    }
}

export class LivenessResponse {
    bitmap?: string
    liveness?: number
    guid?: string
    exception?: LivenessErrorException

    static fromJson(jsonObject?: any): LivenessResponse {
        if (jsonObject == null) return null
        const result = new LivenessResponse

        result.bitmap = jsonObject["bitmap"]
        result.liveness = jsonObject["liveness"]
        result.guid = jsonObject["guid"]
        result.exception = LivenessErrorException.fromJson(jsonObject["exception"])

        return result
    }
}

export class MatchFacesResponse {
    exception?: MatchFacesException
    facesResponse?: MatchFacesDetection[]
    results?: MatchFacesComparedFacesPair[]

    static fromJson(jsonObject?: any): MatchFacesResponse {
        if (jsonObject == null) return null
        const result = new MatchFacesResponse

        result.exception = MatchFacesException.fromJson(jsonObject["exception"])
        result.facesResponse = []
        if (jsonObject["facesResponse"] != null) {
            for (const i in jsonObject["facesResponse"]) {
                result.facesResponse.push(MatchFacesDetection.fromJson(jsonObject["facesResponse"][i]))
            }
        }
        result.results = []
        if (jsonObject["results"] != null) {
            for (const i in jsonObject["results"]) {
                result.results.push(MatchFacesComparedFacesPair.fromJson(jsonObject["results"][i]))
            }
        }

        return result
    }
}

export class Image {
    imageType?: number
    bitmap?: string

    static fromJson(jsonObject?: any): Image {
        if (jsonObject == null) return null
        const result = new Image

        result.imageType = jsonObject["imageType"]
        result.bitmap = jsonObject["bitmap"]

        return result
    }
}

export class MatchFacesRequest {
    matchFacesImages?: MatchFacesImage[]
    customMetadata?: any
    thumbnails?: boolean

    static fromJson(jsonObject?: any): MatchFacesRequest {
        if (jsonObject == null) return null
        const result = new MatchFacesRequest

        result.matchFacesImages = []
        if (jsonObject["matchFacesImages"] != null) {
            for (const i in jsonObject["matchFacesImages"]) {
                result.matchFacesImages.push(MatchFacesImage.fromJson(jsonObject["matchFacesImages"][i]))
            }
        }
        result.customMetadata = jsonObject["customMetadata"]
        result.thumbnails = jsonObject["thumbnails"]

        return result
    }
}

export class MatchFacesImage {
    imageType?: number
    detectAll?: boolean
    bitmap?: string

    static fromJson(jsonObject?: any): MatchFacesImage {
        if (jsonObject == null) return null
        const result = new MatchFacesImage

        result.imageType = jsonObject["imageType"]
        result.detectAll = jsonObject["detectAll"]
        result.bitmap = jsonObject["bitmap"]

        return result
    }
}

export class MatchFacesComparedFacesPair {
    first?: MatchFacesComparedFace
    second?: MatchFacesComparedFace
    similarity?: number
    score?: number
    exception?: MatchFacesException

    static fromJson(jsonObject?: any): MatchFacesComparedFacesPair {
        if (jsonObject == null) return null
        const result = new MatchFacesComparedFacesPair

        result.first = MatchFacesComparedFace.fromJson(jsonObject["first"])
        result.second = MatchFacesComparedFace.fromJson(jsonObject["second"])
        result.similarity = jsonObject["similarity"]
        result.score = jsonObject["score"]
        result.exception = MatchFacesException.fromJson(jsonObject["exception"])

        return result
    }
}

export class MatchFacesComparedFace {
    face?: MatchFacesDetectionFace
    image?: MatchFacesImage
    faceIndex?: number
    imageIndex?: number

    static fromJson(jsonObject?: any): MatchFacesComparedFace {
        if (jsonObject == null) return null
        const result = new MatchFacesComparedFace

        result.face = MatchFacesDetectionFace.fromJson(jsonObject["face"])
        result.image = MatchFacesImage.fromJson(jsonObject["image"])
        result.faceIndex = jsonObject["faceIndex"]
        result.imageIndex = jsonObject["imageIndex"]

        return result
    }
}

export class MatchFacesDetectionFace {
    faceIndex?: number
    landmarks?: Point[]
    faceRect?: Rect
    rotationAngle?: number
    thumbnail?: string

    static fromJson(jsonObject?: any): MatchFacesDetectionFace {
        if (jsonObject == null) return null
        const result = new MatchFacesDetectionFace

        result.faceIndex = jsonObject["faceIndex"]
        result.landmarks = []
        if (jsonObject["landmarks"] != null) {
            for (const i in jsonObject["landmarks"]) {
                result.landmarks.push(Point.fromJson(jsonObject["landmarks"][i]))
            }
        }
        result.faceRect = Rect.fromJson(jsonObject["faceRect"])
        result.rotationAngle = jsonObject["rotationAngle"]
        result.thumbnail = jsonObject["thumbnail"]

        return result
    }
}

export class MatchFacesDetection {
    image?: MatchFacesImage
    imageIndex?: number
    faces?: MatchFacesDetectionFace[]
    exception?: MatchFacesException

    static fromJson(jsonObject?: any): MatchFacesDetection {
        if (jsonObject == null) return null
        const result = new MatchFacesDetection

        result.image = MatchFacesImage.fromJson(jsonObject["image"])
        result.imageIndex = jsonObject["imageIndex"]
        result.faces = []
        if (jsonObject["faces"] != null) {
            for (const i in jsonObject["faces"]) {
                result.faces.push(MatchFacesDetectionFace.fromJson(jsonObject["faces"][i]))
            }
        }
        result.exception = MatchFacesException.fromJson(jsonObject["exception"])

        return result
    }
}

export class Point {
    x?: number
    y?: number

    static fromJson(jsonObject?: any): Point {
        if (jsonObject == null) return null
        const result = new Point

        result.x = jsonObject["x"]
        result.y = jsonObject["y"]

        return result
    }
}

export class Rect {
    bottom?: number
    top?: number
    left?: number
    right?: number

    static fromJson(jsonObject?: any): Rect {
        if (jsonObject == null) return null
        const result = new Rect

        result.bottom = jsonObject["bottom"]
        result.top = jsonObject["top"]
        result.left = jsonObject["left"]
        result.right = jsonObject["right"]

        return result
    }
}

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

export default class FaceSDK {
    static getServiceUrl(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static startLiveness(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getFaceSdkVersion(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static presentFaceCaptureActivity(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static stopFaceCaptureActivity(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static stopLivenessProcessing(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static presentFaceCaptureActivityWithConfig(config: object, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static startLivenessWithConfig(config: object, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static setServiceUrl(url: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static matchFaces(request: MatchFacesRequest, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static setLanguage(language: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static setConfig(config: object, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static matchFacesWithConfig(request: MatchFacesRequest, config: object, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
}