import { NativeModules } from 'react-native'
export const { RNFaceApi } = NativeModules

export class FaceCaptureError {
    errorCode?: number
    message?: string

    static fromJson(jsonObject?: any): FaceCaptureError {
        if (jsonObject == null) return null
        const result = new FaceCaptureError

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result
    }
}

export class FaceProcessorError {
    errorCode?: number
    message?: string

    static fromJson(jsonObject?: any): FaceProcessorError {
        if (jsonObject == null) return null
        const result = new FaceProcessorError

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result
    }
}

export class LivenessError {
    errorCode?: number
    message?: string

    static fromJson(jsonObject?: any): LivenessError {
        if (jsonObject == null) return null
        const result = new LivenessError

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result
    }
}

export class MatchFacesError {
    errorCode?: number
    message?: string

    static fromJson(jsonObject?: any): MatchFacesError {
        if (jsonObject == null) return null
        const result = new MatchFacesError

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result
    }
}

export class AgeRange {
    high?: number
    low?: number

    static fromJson(jsonObject?: any): AgeRange {
        if (jsonObject == null) return null
        const result = new AgeRange

        result.high = jsonObject["high"]
        result.low = jsonObject["low"]

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
    error?: MatchFacesError

    static fromJson(jsonObject?: any): ComparedFacesPair {
        if (jsonObject == null) return null
        const result = new ComparedFacesPair

        result.first = ComparedFace.fromJson(jsonObject["first"])
        result.second = ComparedFace.fromJson(jsonObject["second"])
        result.similarity = jsonObject["similarity"]
        result.error = MatchFacesError.fromJson(jsonObject["error"])

        return result
    }
}

export class Ethnicity {
    confidence?: number
    value?: number

    static fromJson(jsonObject?: any): Ethnicity {
        if (jsonObject == null) return null
        const result = new Ethnicity

        result.confidence = jsonObject["confidence"]
        result.value = jsonObject["value"]

        return result
    }
}

export class FaceCaptureResponse {
    error?: FaceCaptureError
    image?: Image

    static fromJson(jsonObject?: any): FaceCaptureResponse {
        if (jsonObject == null) return null
        const result = new FaceCaptureResponse

        result.error = FaceCaptureError.fromJson(jsonObject["error"])
        result.image = Image.fromJson(jsonObject["image"])

        return result
    }
}

export class Gender {
    confidence?: number
    value?: number

    static fromJson(jsonObject?: any): Gender {
        if (jsonObject == null) return null
        const result = new Gender

        result.confidence = jsonObject["confidence"]
        result.value = jsonObject["value"]

        return result
    }
}

export class Landmark {
    type?: number
    x?: number
    y?: number

    static fromJson(jsonObject?: any): Landmark {
        if (jsonObject == null) return null
        const result = new Landmark

        result.type = jsonObject["type"]
        result.x = jsonObject["x"]
        result.y = jsonObject["y"]

        return result
    }
}

export class LivenessResponse {
    bitmap?: string
    liveness?: number
    error?: LivenessError

    static fromJson(jsonObject?: any): LivenessResponse {
        if (jsonObject == null) return null
        const result = new LivenessResponse

        result.bitmap = jsonObject["bitmap"]
        result.liveness = jsonObject["liveness"]
        result.error = LivenessError.fromJson(jsonObject["error"])

        return result
    }
}

export class MatchFacesResponse {
    error?: FaceProcessorError
    matchedFaces?: ComparedFacesPair[]
    unmatchedFaces?: ComparedFacesPair[]

    static fromJson(jsonObject?: any): MatchFacesResponse {
        if (jsonObject == null) return null
        const result = new MatchFacesResponse

        result.error = FaceProcessorError.fromJson(jsonObject["error"])
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

export class LivenessRequest {
    normalImageData?: any[]
    scaledImageData?: any[]
    requestBody?: any[]
    guid?: string

    static fromJson(jsonObject?: any): LivenessRequest {
        if (jsonObject == null) return null
        const result = new LivenessRequest

        result.normalImageData = []
        if (jsonObject["normalImageData"] != null) {
            for (const i in jsonObject["normalImageData"]) {
                result.normalImageData.push(jsonObject["normalImageData"][i])
            }
        }
        result.scaledImageData = []
        if (jsonObject["scaledImageData"] != null) {
            for (const i in jsonObject["scaledImageData"]) {
                result.scaledImageData.push(jsonObject["scaledImageData"][i])
            }
        }
        result.requestBody = []
        if (jsonObject["requestBody"] != null) {
            for (const i in jsonObject["requestBody"]) {
                result.requestBody.push(jsonObject["requestBody"][i])
            }
        }
        result.guid = jsonObject["guid"]

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

export default class Face {
    static getServiceUrl(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static startLiveness(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getFaceSdkVersion(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static presentFaceCaptureActivity(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static stopFaceCaptureActivity(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static stopLivenessProcessing(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static presentFaceCaptureActivityByCameraId(cameraId: number, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static startLivenessByCameraId(cameraId: number, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static setServiceUrl(url: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static matchFaces(request: MatchFacesRequest, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
}