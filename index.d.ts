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

export class ComparedFacesPairException {
    errorCode?: number
    message?: string

    static fromJson(jsonObject?: any): ComparedFacesPairException {
        if (jsonObject == null) return null
        const result = new ComparedFacesPairException

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result
    }
}

export class ComparedFace {
    tag?: string
    imageType?: number
    position?: number

    static fromJson(jsonObject?: any): ComparedFace {
        if (jsonObject == null) return null
        const result = new ComparedFace

        result.tag = jsonObject["tag"]
        result.imageType = jsonObject["imageType"]
        result.position = jsonObject["position"]

        return result
    }
}

export class ComparedFacesPair {
    first?: ComparedFace
    second?: ComparedFace
    similarity?: number
    exception?: ComparedFacesPairException

    static fromJson(jsonObject?: any): ComparedFacesPair {
        if (jsonObject == null) return null
        const result = new ComparedFacesPair

        result.first = ComparedFace.fromJson(jsonObject["first"])
        result.second = ComparedFace.fromJson(jsonObject["second"])
        result.similarity = jsonObject["similarity"]
        result.exception = ComparedFacesPairException.fromJson(jsonObject["exception"])

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
    exception?: LivenessErrorException

    static fromJson(jsonObject?: any): LivenessResponse {
        if (jsonObject == null) return null
        const result = new LivenessResponse

        result.bitmap = jsonObject["bitmap"]
        result.liveness = jsonObject["liveness"]
        result.exception = LivenessErrorException.fromJson(jsonObject["exception"])

        return result
    }
}

export class MatchFacesResponse {
    exception?: MatchFacesException
    matchedFaces?: ComparedFacesPair[]
    unmatchedFaces?: ComparedFacesPair[]

    static fromJson(jsonObject?: any): MatchFacesResponse {
        if (jsonObject == null) return null
        const result = new MatchFacesResponse

        result.exception = MatchFacesException.fromJson(jsonObject["exception"])
        result.matchedFaces = []
        if (jsonObject["matchedFaces"] != null) {
            for (const i in jsonObject["matchedFaces"]) {
                result.matchedFaces.push(ComparedFacesPair.fromJson(jsonObject["matchedFaces"][i]))
            }
        }
        result.unmatchedFaces = []
        if (jsonObject["unmatchedFaces"] != null) {
            for (const i in jsonObject["unmatchedFaces"]) {
                result.unmatchedFaces.push(ComparedFacesPair.fromJson(jsonObject["unmatchedFaces"][i]))
            }
        }

        return result
    }
}

export class Image {
    imageType?: number
    tag?: string
    bitmap?: string

    static fromJson(jsonObject?: any): Image {
        if (jsonObject == null) return null
        const result = new Image

        result.imageType = jsonObject["imageType"]
        result.tag = jsonObject["tag"]
        result.bitmap = jsonObject["bitmap"]

        return result
    }
}

export class MatchFacesRequest {
    similarityThreshold?: number
    images?: Image[]
    customMetadata?: any

    static fromJson(jsonObject?: any): MatchFacesRequest {
        if (jsonObject == null) return null
        const result = new MatchFacesRequest

        result.similarityThreshold = jsonObject["similarityThreshold"]
        result.images = []
        if (jsonObject["images"] != null) {
            for (const i in jsonObject["images"]) {
                result.images.push(Image.fromJson(jsonObject["images"][i]))
            }
        }
        result.customMetadata = jsonObject["customMetadata"]

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
    static matchFacesWithConfig(request: MatchFacesRequest, config: object, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
}