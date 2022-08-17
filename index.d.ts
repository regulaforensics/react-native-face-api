import { NativeModules } from 'react-native'
export const { RNFaceApi } = NativeModules

export class FaceCaptureException {
    errorCode?: number
    message?: string

    static fromJson(jsonObject?: any): FaceCaptureException | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new FaceCaptureException

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result
    }
}

export class LivenessErrorException {
    errorCode?: number
    message?: string

    static fromJson(jsonObject?: any): LivenessErrorException | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new LivenessErrorException

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result
    }
}

export class MatchFacesException {
    errorCode?: number
    message?: string

    static fromJson(jsonObject?: any): MatchFacesException | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new MatchFacesException

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result
    }
}

export class FaceCaptureResponse {
    exception?: FaceCaptureException
    image?: Image

    static fromJson(jsonObject?: any): FaceCaptureResponse | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
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

    static fromJson(jsonObject?: any): LivenessResponse | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
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
    detections?: MatchFacesDetection[]
    results?: MatchFacesComparedFacesPair[]

    static fromJson(jsonObject?: any): MatchFacesResponse | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new MatchFacesResponse

        result.exception = MatchFacesException.fromJson(jsonObject["exception"])
        result.detections = []
        if (jsonObject["detections"] != null) {
            for (const i in jsonObject["detections"]) {
                const item = MatchFacesDetection.fromJson(jsonObject["detections"][i])
                if (item != undefined)
                    result.detections.push(item)
            }
        }
        result.results = []
        if (jsonObject["results"] != null) {
            for (const i in jsonObject["results"]) {
                const item = MatchFacesComparedFacesPair.fromJson(jsonObject["results"][i])
                if (item != undefined)
                    result.results.push(item)
            }
        }

        return result
    }
}

export class Image {
    imageType?: number
    bitmap?: string

    static fromJson(jsonObject?: any): Image | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new Image

        result.imageType = jsonObject["imageType"]
        result.bitmap = jsonObject["bitmap"]

        return result
    }
}

export class MatchFacesRequest {
    images?: MatchFacesImage[]
    customMetadata?: any
    thumbnails?: boolean

    static fromJson(jsonObject?: any): MatchFacesRequest | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new MatchFacesRequest

        result.images = []
        if (jsonObject["images"] != null) {
            for (const i in jsonObject["images"]) {
                const item = MatchFacesImage.fromJson(jsonObject["images"][i])
                if (item != undefined)
                    result.images.push(item)
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
    identifier?: string

    static fromJson(jsonObject?: any): MatchFacesImage | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new MatchFacesImage

        result.imageType = jsonObject["imageType"]
        result.detectAll = jsonObject["detectAll"]
        result.bitmap = jsonObject["bitmap"]
        result.identifier = jsonObject["identifier"]

        return result
    }
}

export class MatchFacesComparedFacesPair {
    first?: MatchFacesComparedFace
    second?: MatchFacesComparedFace
    similarity?: number
    score?: number
    exception?: MatchFacesException

    static fromJson(jsonObject?: any): MatchFacesComparedFacesPair | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
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

    static fromJson(jsonObject?: any): MatchFacesComparedFace | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
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

    static fromJson(jsonObject?: any): MatchFacesDetectionFace | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new MatchFacesDetectionFace

        result.faceIndex = jsonObject["faceIndex"]
        result.landmarks = []
        if (jsonObject["landmarks"] != null) {
            for (const i in jsonObject["landmarks"]) {
                const item = Point.fromJson(jsonObject["landmarks"][i])
                if (item != undefined)
                    result.landmarks.push(item)
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

    static fromJson(jsonObject?: any): MatchFacesDetection | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new MatchFacesDetection

        result.image = MatchFacesImage.fromJson(jsonObject["image"])
        result.imageIndex = jsonObject["imageIndex"]
        result.faces = []
        if (jsonObject["faces"] != null) {
            for (const i in jsonObject["faces"]) {
                const item = MatchFacesDetectionFace.fromJson(jsonObject["faces"][i])
                if (item != undefined)
                    result.faces.push(item)
            }
        }
        result.exception = MatchFacesException.fromJson(jsonObject["exception"])

        return result
    }
}

export class Point {
    x?: number
    y?: number

    static fromJson(jsonObject?: any): Point | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
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

    static fromJson(jsonObject?: any): Rect | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new Rect

        result.bottom = jsonObject["bottom"]
        result.top = jsonObject["top"]
        result.left = jsonObject["left"]
        result.right = jsonObject["right"]

        return result
    }
}

export class MatchFacesSimilarityThresholdSplit {
    matchedFaces?: MatchFacesComparedFacesPair[]
    unmatchedFaces?: MatchFacesComparedFacesPair[]

    static fromJson(jsonObject?: any): MatchFacesSimilarityThresholdSplit | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new MatchFacesSimilarityThresholdSplit

        result.matchedFaces = []
        if (jsonObject["matchedFaces"] != null) {
            for (const i in jsonObject["matchedFaces"]) {
                const item = MatchFacesComparedFacesPair.fromJson(jsonObject["matchedFaces"][i])
                if (item != undefined)
                    result.matchedFaces.push(item)
            }
        }
        result.unmatchedFaces = []
        if (jsonObject["unmatchedFaces"] != null) {
            for (const i in jsonObject["unmatchedFaces"]) {
                const item = MatchFacesComparedFacesPair.fromJson(jsonObject["unmatchedFaces"][i])
                if (item != undefined)
                    result.unmatchedFaces.push(item)
            }
        }

        return result
    }
}

export const CameraPosition = {
    Back: 0,
    Front: 1,
}

export const LivenessStatus = {
    PASSED: 0,
    UNKNOWN: 1,
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
}

export const ImageType = {
    PRINTED: 1,
    RFID: 2,
    LIVE: 3,
    DOCUMENT_WITH_LIVE: 4,
    EXTERNAL: 5,
}

export const FaceCaptureErrorCode = {
    CANCEL: 1,
    CAMERA_NOT_AVAILABLE: 2,
    CAMERA_NO_PERMISSION: 3,
    IN_PROGRESS_ALREADY: 4,
    CONTEXT_IS_NULL: 5,
}

export const MatchFacesErrorCodes = {
    IMAGE_EMPTY: 1,
    FACE_NOT_DETECTED: 2,
    LANDMARKS_NOT_DETECTED: 3,
    FACE_ALIGNER_FAILED: 4,
    DESCRIPTOR_EXTRACTOR_ERROR: 5,
    NO_LICENSE: 6,
    IMAGES_COUNT_LIMIT_EXCEEDED: 7,
    API_CALL_FAILED: 8,
    PROCESSING_FAILED: 9,
}

export const Enum = {
   CameraPosition,
   LivenessStatus,
   LivenessErrorCode,
   ImageType,
   FaceCaptureErrorCode,
   MatchFacesErrorCodes,
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
    static matchFacesWithConfig(request: MatchFacesRequest, config: object, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static setLanguage(language: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static matchFacesSimilarityThresholdSplit(faces: string, similarity: number, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
}