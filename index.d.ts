import { NativeModules } from 'react-native'
export const { RNFaceApi } = NativeModules

export class FaceCaptureException {
    errorCode?: string
    message?: string

    static fromJson(jsonObject?: any): FaceCaptureException | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new FaceCaptureException

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result
    }
}

export class InitException {
    errorCode?: string
    underlyingException?: LicenseException
    message?: string

    static fromJson(jsonObject?: any): InitException | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new InitException

        result.errorCode = jsonObject["errorCode"]
        result.underlyingException = LicenseException.fromJson(jsonObject["underlyingException"])
        result.message = jsonObject["message"]

        return result
    }
}

export class LicenseException {
    errorCode?: number
    message?: string

    static fromJson(jsonObject?: any): LicenseException | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new LicenseException

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result
    }
}

export class LivenessErrorException {
    errorCode?: string
    underlyingException?: LivenessBackendException
    message?: string

    static fromJson(jsonObject?: any): LivenessErrorException | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new LivenessErrorException

        result.errorCode = jsonObject["errorCode"]
        result.underlyingException = LivenessBackendException.fromJson(jsonObject["underlyingException"])
        result.message = jsonObject["message"]

        return result
    }
}

export class LivenessBackendException {
    errorCode?: number
    message?: string

    static fromJson(jsonObject?: any): LivenessBackendException | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new LivenessBackendException

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result
    }
}

export class MatchFacesException {
    errorCode?: string
    message?: string
    detailedErrorMessage?: string

    static fromJson(jsonObject?: any): MatchFacesException | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new MatchFacesException

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]
        result.detailedErrorMessage = jsonObject["detailedErrorMessage"]

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
    liveness?: string
    tag?: string
    transactionId?: string
    estimatedAge?: number
    exception?: LivenessErrorException

    static fromJson(jsonObject?: any): LivenessResponse | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new LivenessResponse

        result.bitmap = jsonObject["bitmap"]
        result.liveness = jsonObject["liveness"]
        result.tag = jsonObject["tag"]
        result.transactionId = jsonObject["transactionId"]
        result.estimatedAge = jsonObject["estimatedAge"]
        result.exception = LivenessErrorException.fromJson(jsonObject["exception"])

        return result
    }
}

export class MatchFacesResponse {
    tag?: string
    exception?: MatchFacesException
    detections?: MatchFacesDetection[]
    results?: MatchFacesComparedFacesPair[]

    static fromJson(jsonObject?: any): MatchFacesResponse | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new MatchFacesResponse

        result.tag = jsonObject["tag"]
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
    tag?: string
    imageData?: string

    static fromJson(jsonObject?: any): Image | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new Image

        result.imageType = jsonObject["imageType"]
        result.bitmap = jsonObject["bitmap"]
        result.tag = jsonObject["tag"]
        result.imageData = jsonObject["imageData"]

        return result
    }
}

export class MatchFacesRequest {
    images?: MatchFacesImage[]
    customMetadata?: any
    tag?: string
    outputImageParams?: OutputImageParams

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
        result.tag = jsonObject["tag"]
        result.outputImageParams = OutputImageParams.fromJson(jsonObject["outputImageParams"])

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
    rotationAngle?: number
    landmarks?: Point[]
    faceRect?: Rect
    originalRect?: Rect
    crop?: string

    static fromJson(jsonObject?: any): MatchFacesDetectionFace | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new MatchFacesDetectionFace

        result.faceIndex = jsonObject["faceIndex"]
        result.rotationAngle = jsonObject["rotationAngle"]
        result.landmarks = []
        if (jsonObject["landmarks"] != null) {
            for (const i in jsonObject["landmarks"]) {
                const item = Point.fromJson(jsonObject["landmarks"][i])
                if (item != undefined)
                    result.landmarks.push(item)
            }
        }
        result.faceRect = Rect.fromJson(jsonObject["faceRect"])
        result.originalRect = Rect.fromJson(jsonObject["originalRect"])
        result.crop = jsonObject["crop"]

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

export class DetectFacesRequest {
    tag?: string
    scenario?: string
    image?: string
    configuration?: DetectFacesConfiguration

    static fromJson(jsonObject?: any): DetectFacesRequest | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new DetectFacesRequest

        result.tag = jsonObject["tag"]
        result.scenario = jsonObject["scenario"]
        result.image = jsonObject["image"]
        result.configuration = DetectFacesConfiguration.fromJson(jsonObject["configuration"])

        return result
    }
}

export class DetectFacesConfiguration {
    attributes?: string[]
    customQuality?: ImageQualityCharacteristic[]
    outputImageParams?: OutputImageParams
    onlyCentralFace?: boolean

    static fromJson(jsonObject?: any): DetectFacesConfiguration | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new DetectFacesConfiguration

        result.attributes = []
        if (jsonObject["attributes"] != null) {
            for (const i in jsonObject["attributes"]) {
                result.attributes.push(jsonObject["attributes"][i])
            }
        }
        result.customQuality = []
        if (jsonObject["customQuality"] != null) {
            for (const i in jsonObject["customQuality"]) {
                const item = ImageQualityCharacteristic.fromJson(jsonObject["customQuality"][i])
                if (item != undefined)
                    result.customQuality.push(item)
            }
        }
        result.outputImageParams = OutputImageParams.fromJson(jsonObject["outputImageParams"])
        result.onlyCentralFace = jsonObject["onlyCentralFace"]

        return result
    }
}

export class OutputImageParams {
    backgroundColor?: string
    crop?: OutputImageCrop

    static fromJson(jsonObject?: any): OutputImageParams | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new OutputImageParams

        result.backgroundColor = jsonObject["backgroundColor"]
        result.crop = OutputImageCrop.fromJson(jsonObject["crop"])

        return result
    }
}

export class OutputImageCrop {
    type?: number
    size?: Size
    padColor?: string
    returnOriginalRect?: boolean

    static fromJson(jsonObject?: any): OutputImageCrop | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new OutputImageCrop

        result.type = jsonObject["type"]
        result.size = Size.fromJson(jsonObject["size"])
        result.padColor = jsonObject["padColor"]
        result.returnOriginalRect = jsonObject["returnOriginalRect"]

        return result
    }
}

export class ImageQualityCharacteristic {
    characteristicName?: string
    imageQualityGroup?: number
    recommendedRange?: ImageQualityRange
    customRange?: ImageQualityRange

    static fromJson(jsonObject?: any): ImageQualityCharacteristic | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new ImageQualityCharacteristic

        result.characteristicName = jsonObject["characteristicName"]
        result.imageQualityGroup = jsonObject["imageQualityGroup"]
        result.recommendedRange = ImageQualityRange.fromJson(jsonObject["recommendedRange"])
        result.customRange = ImageQualityRange.fromJson(jsonObject["customRange"])

        return result
    }
}

export class ImageQualityRange {
    min?: number
    max?: number

    static fromJson(jsonObject?: any): ImageQualityRange | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new ImageQualityRange

        result.min = jsonObject["min"]
        result.max = jsonObject["max"]

        return result
    }
}

export class Size {
    width?: number
    height?: number

    static fromJson(jsonObject?: any): Size | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new Size

        result.width = jsonObject["width"]
        result.height = jsonObject["height"]

        return result
    }
}

export class DetectFacesResponse {
    detection?: DetectFaceResult
    scenario?: string
    error?: DetectFacesErrorException
    allDetections?: DetectFaceResult[]

    static fromJson(jsonObject?: any): DetectFacesResponse | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new DetectFacesResponse

        result.detection = DetectFaceResult.fromJson(jsonObject["detection"])
        result.scenario = jsonObject["scenario"]
        result.error = DetectFacesErrorException.fromJson(jsonObject["error"])
        result.allDetections = []
        if (jsonObject["allDetections"] != null) {
            for (const i in jsonObject["allDetections"]) {
                const item = DetectFaceResult.fromJson(jsonObject["allDetections"][i])
                if (item != undefined)
                    result.allDetections.push(item)
            }
        }

        return result
    }
}

export class DetectFacesErrorException {
    errorCode?: string
    underlyingException?: DetectFacesBackendException
    message?: string

    static fromJson(jsonObject?: any): DetectFacesErrorException | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new DetectFacesErrorException

        result.errorCode = jsonObject["errorCode"]
        result.underlyingException = DetectFacesBackendException.fromJson(jsonObject["underlyingException"])
        result.message = jsonObject["message"]

        return result
    }
}

export class DetectFacesBackendException {
    errorCode?: number
    message?: string

    static fromJson(jsonObject?: any): DetectFacesBackendException | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new DetectFacesBackendException

        result.errorCode = jsonObject["errorCode"]
        result.message = jsonObject["message"]

        return result
    }
}

export class DetectFaceResult {
    quality?: ImageQualityResult[]
    attributes?: DetectFacesAttributeResult[]
    landmarks?: Point[]
    crop?: string
    faceRect?: Rect
    originalRect?: Rect
    isQualityCompliant?: boolean

    static fromJson(jsonObject?: any): DetectFaceResult | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new DetectFaceResult

        result.quality = []
        if (jsonObject["quality"] != null) {
            for (const i in jsonObject["quality"]) {
                const item = ImageQualityResult.fromJson(jsonObject["quality"][i])
                if (item != undefined)
                    result.quality.push(item)
            }
        }
        result.attributes = []
        if (jsonObject["attributes"] != null) {
            for (const i in jsonObject["attributes"]) {
                const item = DetectFacesAttributeResult.fromJson(jsonObject["attributes"][i])
                if (item != undefined)
                    result.attributes.push(item)
            }
        }
        result.landmarks = []
        if (jsonObject["landmarks"] != null) {
            for (const i in jsonObject["landmarks"]) {
                const item = Point.fromJson(jsonObject["landmarks"][i])
                if (item != undefined)
                    result.landmarks.push(item)
            }
        }
        result.crop = jsonObject["crop"]
        result.faceRect = Rect.fromJson(jsonObject["faceRect"])
        result.originalRect = Rect.fromJson(jsonObject["originalRect"])
        result.isQualityCompliant = jsonObject["isQualityCompliant"]

        return result
    }
}

export class ImageQualityResult {
    name?: string
    group?: number
    status?: number
    range?: ImageQualityRange
    value?: number

    static fromJson(jsonObject?: any): ImageQualityResult | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new ImageQualityResult

        result.name = jsonObject["name"]
        result.group = jsonObject["group"]
        result.status = jsonObject["status"]
        result.range = ImageQualityRange.fromJson(jsonObject["range"])
        result.value = jsonObject["value"]

        return result
    }
}

export class DetectFacesAttributeResult {
    attribute?: string
    value?: string
    range?: ImageQualityRange
    confidence?: number

    static fromJson(jsonObject?: any): DetectFacesAttributeResult | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new DetectFacesAttributeResult

        result.attribute = jsonObject["attribute"]
        result.value = jsonObject["value"]
        result.range = ImageQualityRange.fromJson(jsonObject["range"])
        result.confidence = jsonObject["confidence"]

        return result
    }
}

export class Font {
    name?: string
    style?: number
    size?: number

    static fromJson(jsonObject?: any): Font | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new Font

        result.name = jsonObject["name"]
        result.style = jsonObject["style"]
        result.size = jsonObject["size"]

        return result
    }
}

export class Person {
    name?: string
    groups?: string[]
    updatedAt?: string
    id?: string
    metadata?: any
    createdAt?: string

    static fromJson(jsonObject?: any): Person | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new Person

        result.name = jsonObject["name"]
        result.groups = []
        if (jsonObject["groups"] != null) {
            for (const i in jsonObject["groups"]) {
                result.groups.push(jsonObject["groups"][i])
            }
        }
        result.updatedAt = jsonObject["updatedAt"]
        result.id = jsonObject["id"]
        result.metadata = jsonObject["metadata"]
        result.createdAt = jsonObject["createdAt"]

        return result
    }
}

export class PersonGroup {
    name?: string
    id?: string
    metadata?: any
    createdAt?: string

    static fromJson(jsonObject?: any): PersonGroup | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new PersonGroup

        result.name = jsonObject["name"]
        result.id = jsonObject["id"]
        result.metadata = jsonObject["metadata"]
        result.createdAt = jsonObject["createdAt"]

        return result
    }
}

export class PersonImage {
    path?: string
    url?: string
    contentType?: string
    id?: string
    metadata?: any
    createdAt?: string

    static fromJson(jsonObject?: any): PersonImage | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new PersonImage

        result.path = jsonObject["path"]
        result.url = jsonObject["url"]
        result.contentType = jsonObject["contentType"]
        result.id = jsonObject["id"]
        result.metadata = jsonObject["metadata"]
        result.createdAt = jsonObject["createdAt"]

        return result
    }
}

export class ImageUpload {
    imageData?: string
    imageUrl?: string

    static fromJson(jsonObject?: any): ImageUpload | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new ImageUpload

        result.imageData = jsonObject["imageData"]
        result.imageUrl = jsonObject["imageUrl"]

        return result
    }
}

export class EditGroupPersonsRequest {
    personIdsToAdd?: string[]
    personIdsToRemove?: string[]

    static fromJson(jsonObject?: any): EditGroupPersonsRequest | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new EditGroupPersonsRequest

        result.personIdsToAdd = []
        if (jsonObject["personIdsToAdd"] != null) {
            for (const i in jsonObject["personIdsToAdd"]) {
                result.personIdsToAdd.push(jsonObject["personIdsToAdd"][i])
            }
        }
        result.personIdsToRemove = []
        if (jsonObject["personIdsToRemove"] != null) {
            for (const i in jsonObject["personIdsToRemove"]) {
                result.personIdsToRemove.push(jsonObject["personIdsToRemove"][i])
            }
        }

        return result
    }
}

export class SearchPersonRequest {
    outputImageParams?: OutputImageParams
    groupIdsForSearch?: string[]
    threshold?: number
    limit?: number
    imageUpload?: ImageUpload
    detectAll?: boolean

    static fromJson(jsonObject?: any): SearchPersonRequest | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new SearchPersonRequest

        result.outputImageParams = OutputImageParams.fromJson(jsonObject["outputImageParams"])
        result.groupIdsForSearch = []
        if (jsonObject["groupIdsForSearch"] != null) {
            for (const i in jsonObject["groupIdsForSearch"]) {
                result.groupIdsForSearch.push(jsonObject["groupIdsForSearch"][i])
            }
        }
        result.threshold = jsonObject["threshold"]
        result.limit = jsonObject["limit"]
        result.imageUpload = ImageUpload.fromJson(jsonObject["imageUpload"])
        result.detectAll = jsonObject["detectAll"]

        return result
    }
}

export class SearchPerson {
    detection?: SearchPersonDetection
    images?: SearchPersonImage[]
    name?: string
    groups?: string[]
    updatedAt?: string
    id?: string
    metadata?: any
    createdAt?: string

    static fromJson(jsonObject?: any): SearchPerson | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new SearchPerson

        result.detection = SearchPersonDetection.fromJson(jsonObject["detection"])
        result.images = []
        if (jsonObject["images"] != null) {
            for (const i in jsonObject["images"]) {
                const item = SearchPersonImage.fromJson(jsonObject["images"][i])
                if (item != undefined)
                    result.images.push(item)
            }
        }
        result.name = jsonObject["name"]
        result.groups = []
        if (jsonObject["groups"] != null) {
            for (const i in jsonObject["groups"]) {
                result.groups.push(jsonObject["groups"][i])
            }
        }
        result.updatedAt = jsonObject["updatedAt"]
        result.id = jsonObject["id"]
        result.metadata = jsonObject["metadata"]
        result.createdAt = jsonObject["createdAt"]

        return result
    }
}

export class SearchPersonImage {
    similarity?: number
    distance?: number
    path?: string
    url?: string
    contentType?: string
    id?: string
    metadata?: any
    createdAt?: string

    static fromJson(jsonObject?: any): SearchPersonImage | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new SearchPersonImage

        result.similarity = jsonObject["similarity"]
        result.distance = jsonObject["distance"]
        result.path = jsonObject["path"]
        result.url = jsonObject["url"]
        result.contentType = jsonObject["contentType"]
        result.id = jsonObject["id"]
        result.metadata = jsonObject["metadata"]
        result.createdAt = jsonObject["createdAt"]

        return result
    }
}

export class SearchPersonDetection {
    landmarks?: Point[]
    rect?: Rect
    cropImage?: string
    rotationAngle?: number

    static fromJson(jsonObject?: any): SearchPersonDetection | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new SearchPersonDetection

        result.landmarks = []
        if (jsonObject["landmarks"] != null) {
            for (const i in jsonObject["landmarks"]) {
                const item = Point.fromJson(jsonObject["landmarks"][i])
                if (item != undefined)
                    result.landmarks.push(item)
            }
        }
        result.rect = Rect.fromJson(jsonObject["rect"])
        result.cropImage = jsonObject["cropImage"]
        result.rotationAngle = jsonObject["rotationAngle"]

        return result
    }
}

export class LivenessNotification {
    status?: string
    response?: LivenessResponse

    static fromJson(jsonObject?: any): LivenessNotification | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new LivenessNotification

        result.status = jsonObject["status"]
        result.response = LivenessResponse.fromJson(jsonObject["response"])

        return result
    }
}

export class VideoEncoderCompletion {
    success?: boolean
    transactionId?: string

    static fromJson(jsonObject?: any): VideoEncoderCompletion | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new VideoEncoderCompletion

        result.success = jsonObject["success"]
        result.transactionId = jsonObject["transactionId"]

        return result
    }
}

export class InitializationConfiguration {
    license?: string
    licenseUpdate?: boolean

    static fromJson(jsonObject?: any): InitializationConfiguration | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new InitializationConfiguration

        result.license = jsonObject["license"]
        result.licenseUpdate = jsonObject["licenseUpdate"]

        return result
    }
}

export class InitResponse {
    success?: boolean
    error?: InitException

    static fromJson(jsonObject?: any): InitResponse | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new InitResponse

        result.success = jsonObject["success"]
        result.error = InitException.fromJson(jsonObject["error"])

        return result
    }
}

export const FontStyle = {
    NORMAL: 0,
    BOLD: 1,
    ITALIC: 2,
    BOLD_ITALIC: 3,
}

export const CustomizationColor = {
    ONBOARDING_SCREEN_START_BUTTON_BACKGROUND: "CustomizationColor.ONBOARDING_SCREEN_START_BUTTON_BACKGROUND",
    ONBOARDING_SCREEN_START_BUTTON_TITLE: "CustomizationColor.ONBOARDING_SCREEN_START_BUTTON_TITLE",
    ONBOARDING_SCREEN_BACKGROUND: "CustomizationColor.ONBOARDING_SCREEN_BACKGROUND",
    ONBOARDING_SCREEN_TITLE_LABEL_TEXT: "CustomizationColor.ONBOARDING_SCREEN_TITLE_LABEL_TEXT",
    ONBOARDING_SCREEN_SUBTITLE_LABEL_TEXT: "CustomizationColor.ONBOARDING_SCREEN_SUBTITLE_LABEL_TEXT",
    ONBOARDING_SCREEN_MESSAGE_LABELS_TEXT: "CustomizationColor.ONBOARDING_SCREEN_MESSAGE_LABELS_TEXT",
    CAMERA_SCREEN_STROKE_NORMAL: "CustomizationColor.CAMERA_SCREEN_STROKE_NORMAL",
    CAMERA_SCREEN_STROKE_ACTIVE: "CustomizationColor.CAMERA_SCREEN_STROKE_ACTIVE",
    CAMERA_SCREEN_SECTOR_TARGET: "CustomizationColor.CAMERA_SCREEN_SECTOR_TARGET",
    CAMERA_SCREEN_SECTOR_ACTIVE: "CustomizationColor.CAMERA_SCREEN_SECTOR_ACTIVE",
    CAMERA_SCREEN_FRONT_HINT_LABEL_BACKGROUND: "CustomizationColor.CAMERA_SCREEN_FRONT_HINT_LABEL_BACKGROUND",
    CAMERA_SCREEN_FRONT_HINT_LABEL_TEXT: "CustomizationColor.CAMERA_SCREEN_FRONT_HINT_LABEL_TEXT",
    CAMERA_SCREEN_BACK_HINT_LABEL_BACKGROUND: "CustomizationColor.CAMERA_SCREEN_BACK_HINT_LABEL_BACKGROUND",
    CAMERA_SCREEN_BACK_HINT_LABEL_TEXT: "CustomizationColor.CAMERA_SCREEN_BACK_HINT_LABEL_TEXT",
    CAMERA_SCREEN_LIGHT_TOOLBAR_TINT: "CustomizationColor.CAMERA_SCREEN_LIGHT_TOOLBAR_TINT",
    CAMERA_SCREEN_DARK_TOOLBAR_TINT: "CustomizationColor.CAMERA_SCREEN_DARK_TOOLBAR_TINT",
    RETRY_SCREEN_BACKGROUND: "CustomizationColor.RETRY_SCREEN_BACKGROUND",
    RETRY_SCREEN_RETRY_BUTTON_BACKGROUND: "CustomizationColor.RETRY_SCREEN_RETRY_BUTTON_BACKGROUND",
    RETRY_SCREEN_RETRY_BUTTON_TITLE: "CustomizationColor.RETRY_SCREEN_RETRY_BUTTON_TITLE",
    RETRY_SCREEN_TITLE_LABEL_TEXT: "CustomizationColor.RETRY_SCREEN_TITLE_LABEL_TEXT",
    RETRY_SCREEN_SUBTITLE_LABEL_TEXT: "CustomizationColor.RETRY_SCREEN_SUBTITLE_LABEL_TEXT",
    RETRY_SCREEN_HINT_LABELS_TEXT: "CustomizationColor.RETRY_SCREEN_HINT_LABELS_TEXT",
    PROCESSING_SCREEN_BACKGROUND: "CustomizationColor.PROCESSING_SCREEN_BACKGROUND",
    PROCESSING_SCREEN_PROGRESS: "CustomizationColor.PROCESSING_SCREEN_PROGRESS",
    PROCESSING_SCREEN_TITLE: "CustomizationColor.PROCESSING_SCREEN_TITLE",
    SUCCESS_SCREEN_BACKGROUND: "CustomizationColor.SUCCESS_SCREEN_BACKGROUND",
}

export const ImageQualityGroupName = {
    IMAGE_CHARACTERISTICS: 1,
    HEAD_SIZE_AND_POSITION: 2,
    FACE_QUALITY: 3,
    EYES_CHARACTERISTICS: 4,
    SHADOWS_AND_LIGHTNING: 5,
    POSE_AND_EXPRESSION: 6,
    HEAD_OCCLUSION: 7,
    BACKGROUND: 8,
    UNKNOWN: 9,
}

export const LicensingResultCode = {
    OK: "OK",
    LICENSE_CORRUPTED: "LICENSE_CORRUPTED",
    INVALID_DATE: "INVALID_DATE",
    INVALID_VERSION: "INVALID_VERSION",
    INVALID_DEVICE_ID: "INVALID_DEVICE_ID",
    INVALID_SYSTEM_OR_APP_ID: "INVALID_SYSTEM_OR_APP_ID",
    NO_CAPABILITIES: "NO_CAPABILITIES",
    NO_AUTHENTICITY: "NO_AUTHENTICITY",
    LICENSE_ABSENT: "LICENSE_ABSENT",
    NO_INTERNET: "NO_INTERNET",
    NO_DATABASE: "NO_DATABASE",
    DATABASE_INCORRECT: "DATABASE_INCORRECT",
}

export const DetectFacesErrorCode = {
    IMAGE_EMPTY: "IMAGE_EMPTY",
    FR_FACE_NOT_DETECTED: "FR_FACE_NOT_DETECTED",
    FACER_NO_LICENSE: "FACER_NO_LICENSE",
    FACER_IS_NOT_INITIALIZED: "FACER_IS_NOT_INITIALIZED",
    FACER_COMMAND_IS_NOT_SUPPORTED: "FACER_COMMAND_IS_NOT_SUPPORTED",
    FACER_COMMAND_PARAMS_READ_ERROR: "FACER_COMMAND_PARAMS_READ_ERROR",
    PROCESSING_FAILED: "PROCESSING_FAILED",
    REQUEST_FAILED: "REQUEST_FAILED",
    API_CALL_FAILED: "API_CALL_FAILED",
}

export const InitErrorCode = {
    IN_PROGRESS_ALREADY: 0,
    MISSING_CORE: 1,
    INTERNAL_CORE_ERROR: 2,
    BAD_LICENSE: 3,
    UNAVAILABLE: 4,
    CONTEXT_IS_NULL: 100,
    RESOURCE_DAT_ABSENT: 101,
    LICENSE_IS_NULL: 102,
}

export const LivenessStatus = {
    PASSED: "PASSED",
    UNKNOWN: "UNKNOWN",
}

export const CameraErrorCode = {
    CAMERA_NOT_AVAILABLE: "CAMERA_NOT_AVAILABLE",
    CAMERA_NO_PERMISSION: "CAMERA_NO_PERMISSION",
}

export const LivenessErrorCode = {
    NOT_INITIALIZED: "NOT_INITIALIZED",
    NO_LICENSE: "NO_LICENSE",
    API_CALL_FAILED: "API_CALL_FAILED",
    SESSION_START_FAILED: "SESSION_START_FAILED",
    CANCELLED: "CANCELLED",
    PROCESSING_TIMEOUT: "PROCESSING_TIMEOUT",
    PROCESSING_FAILED: "PROCESSING_FAILED",
    PROCESSING_FRAME_FAILED: "PROCESSING_FRAME_FAILED",
    APPLICATION_INACTIVE: "APPLICATION_INACTIVE",
    CONTEXT_IS_NULL: "CONTEXT_IS_NULL",
    IN_PROGRESS_ALREADY: "IN_PROGRESS_ALREADY",
    ZOOM_NOT_SUPPORTED: "ZOOM_NOT_SUPPORTED",
    CAMERA_NO_PERMISSION: "CAMERA_NO_PERMISSION",
    CAMERA_NOT_AVAILABLE: "CAMERA_NOT_AVAILABLE",
}

export const RecordingProcess = {
    ASYNCHRONOUS_UPLOAD: "ASYNCHRONOUS_UPLOAD",
    SYNCHRONOUS_UPLOAD: "SYNCHRONOUS_UPLOAD",
    NOT_UPLOAD: "NOT_UPLOAD",
}

export const DetectFacesBackendErrorCode = {
    FR_FACE_NOT_DETECTED: 2,
    FACER_NO_LICENSE: 200,
    FACER_IS_NOT_INITIALIZED: 201,
    FACER_COMMAND_IS_NOT_SUPPORTED: 202,
    FACER_COMMAND_PARAMS_READ_ERROR: 203,
    UNDEFINED: -1,
}

export const MatchFacesErrorCode = {
    IMAGE_EMPTY: "IMAGE_EMPTY",
    FACE_NOT_DETECTED: "FACE_NOT_DETECTED",
    LANDMARKS_NOT_DETECTED: "LANDMARKS_NOT_DETECTED",
    FACE_ALIGNER_FAILED: "FACE_ALIGNER_FAILED",
    DESCRIPTOR_EXTRACTOR_ERROR: "DESCRIPTOR_EXTRACTOR_ERROR",
    IMAGES_COUNT_LIMIT_EXCEEDED: "IMAGES_COUNT_LIMIT_EXCEEDED",
    API_CALL_FAILED: "API_CALL_FAILED",
    PROCESSING_FAILED: "PROCESSING_FAILED",
    NO_LICENSE: "NO_LICENSE",
}

export const ImageQualityCharacteristicName = {
    IMAGE_WIDTH: "ImageWidth",
    IMAGE_HEIGHT: "ImageHeight",
    IMAGE_WIDTH_TO_HEIGHT: "ImageWidthToHeight",
    IMAGE_CHANNELS_NUMBER: "ImageChannelsNumber",
    ART_FACE: "ArtFace",
    PADDING_RATIO: "PaddingRatio",
    FACE_MID_POINT_HORIZONTAL_POSITION: "FaceMidPointHorizontalPosition",
    FACE_MID_POINT_VERTICAL_POSITION: "FaceMidPointVerticalPosition",
    HEAD_WIDTH_RATIO: "HeadWidthRatio",
    HEAD_HEIGHT_RATIO: "HeadHeightRatio",
    EYES_DISTANCE: "EyesDistance",
    YAW: "Yaw",
    PITCH: "Pitch",
    ROLL: "Roll",
    BLUR_LEVEL: "BlurLevel",
    NOISE_LEVEL: "NoiseLevel",
    UNNATURAL_SKIN_TONE: "UnnaturalSkinTone",
    FACE_DYNAMIC_RANGE: "FaceDynamicRange",
    EYE_RIGHT_CLOSED: "EyeRightClosed",
    EYE_LEFT_CLOSED: "EyeLeftClosed",
    EYE_RIGHT_OCCLUDED: "EyeRightOccluded",
    EYE_LEFT_OCCLUDED: "EyeLeftOccluded",
    EYES_RED: "EyesRed",
    EYE_RIGHT_COVERED_WITH_HAIR: "EyeRightCoveredWithHair",
    EYE_LEFT_COVERED_WITH_HAIR: "EyeLeftCoveredWithHair",
    OFF_GAZE: "OffGaze",
    TOO_DARK: "TooDark",
    TOO_LIGHT: "TooLight",
    FACE_GLARE: "FaceGlare",
    SHADOWS_ON_FACE: "ShadowsOnFace",
    SHOULDERS_POSE: "ShouldersPose",
    EXPRESSION_LEVEL: "ExpressionLevel",
    MOUTH_OPEN: "MouthOpen",
    SMILE: "Smile",
    DARK_GLASSES: "DarkGlasses",
    REFLECTION_ON_GLASSES: "ReflectionOnGlasses",
    FRAMES_TOO_HEAVY: "FramesTooHeavy",
    FACE_OCCLUDED: "FaceOccluded",
    HEAD_COVERING: "HeadCovering",
    FOREHEAD_COVERING: "ForeheadCovering",
    STRONG_MAKEUP: "StrongMakeup",
    HEAD_PHONES: "Headphones",
    MEDICAL_MASK: "MedicalMask",
    BACKGROUND_UNIFORMITY: "BackgroundUniformity",
    SHADOWS_ON_BACKGROUND: "ShadowsOnBackground",
    OTHER_FACES: "OtherFaces",
    BACKGROUND_COLOR_MATCH: "BackgroundColorMatch",
    UNKNOWN: "Unknown",
    IMAGE_CHARACTERISTIC_ALL_RECOMMENDED: "ImageCharacteristic",
    HEAD_SIZE_AND_POSITION_ALL_RECOMMENDED: "HeadSizeAndPosition",
    FACE_IMAGE_QUALITY_ALL_RECOMMENDED: "FaceImageQuality",
    EYES_CHARACTERISTICS_ALL_RECOMMENDED: "EyesCharacteristics",
    SHADOW_AND_LIGHTING_ALL_RECOMMENDED: "ShadowsAndLightning",
    POSE_AND_EXPRESSION_ALL_RECOMMENDED: "PoseAndExpression",
    HEAD_OCCLUSION_ALL_RECOMMENDED: "HeadOcclusion",
    QUALITY_BACKGROUND_ALL_RECOMMENDED: "QualityBackground",
}

export const ScreenOrientation = {
    PORTRAIT: 1,
    LANDSCAPE: 2,
}

export const ButtonTag = {
    CLOSE: 1001,
    TORCH: 1002,
    CAMERA_SWITCH: 1003,
}

export const CustomizationFont = {
    ONBOARDING_SCREEN_START_BUTTON: "CustomizationFont.ONBOARDING_SCREEN_START_BUTTON",
    ONBOARDING_SCREEN_TITLE_LABEL: "CustomizationFont.ONBOARDING_SCREEN_TITLE_LABEL",
    ONBOARDING_SCREEN_SUBTITLE_LABEL: "CustomizationFont.ONBOARDING_SCREEN_SUBTITLE_LABEL",
    ONBOARDING_SCREEN_MESSAGE_LABELS: "CustomizationFont.ONBOARDING_SCREEN_MESSAGE_LABELS",
    CAMERA_SCREEN_HINT_LABEL: "CustomizationFont.CAMERA_SCREEN_HINT_LABEL",
    RETRY_SCREEN_RETRY_BUTTON: "CustomizationFont.RETRY_SCREEN_RETRY_BUTTON",
    RETRY_SCREEN_TITLE_LABEL: "CustomizationFont.RETRY_SCREEN_TITLE_LABEL",
    RETRY_SCREEN_SUBTITLE_LABEL: "CustomizationFont.RETRY_SCREEN_SUBTITLE_LABEL",
    RETRY_SCREEN_HINT_LABELS: "CustomizationFont.RETRY_SCREEN_HINT_LABELS",
    PROCESSING_SCREEN: "CustomizationFont.PROCESSING_SCREEN",
}

export const DetectFacesScenario = {
    CROP_CENTRAL_FACE: "CropCentralFace",
    CROP_ALL_FACES: "CropAllFaces",
    THUMBNAIL: "Thumbnail",
    ATTRIBUTES_ALL: "AttributesAll",
    QUALITY_FULL: "QualityFull",
    QUALITY_ICAO: "QualityICAO",
    QUALITY_VISA_SCHENGEN: "QualityVisaSchengen",
    QUALITY_VISA_USA: "QualityVisaUSA",
}

export const LivenessProcessStatus = {
    START: "START",
    PREPARING: "PREPARING",
    NEW_SESSION: "NEW_SESSION",
    NEXT_STAGE: "NEXT_STAGE",
    SECTOR_CHANGED: "SECTOR_CHANGED",
    PROGRESS: "PROGRESS",
    LOW_BRIGHTNESS: "LOW_BRIGHTNESS",
    FIT_FACE: "FIT_FACE",
    MOVE_AWAY: "MOVE_AWAY",
    MOVE_CLOSER: "MOVE_CLOSER",
    TURN_HEAD: "TURN_HEAD",
    PROCESSING: "PROCESSING",
    FAILED: "FAILED",
    RETRY: "RETRY",
    SUCCESS: "SUCCESS",
}

export const OutputImageCropAspectRatio = {
    OUTPUT_IMAGE_CROP_ASPECT_RATIO_3X4: 0,
    OUTPUT_IMAGE_CROP_ASPECT_RATIO_4X5: 1,
    OUTPUT_IMAGE_CROP_ASPECT_RATIO_2X3: 2,
    OUTPUT_IMAGE_CROP_ASPECT_RATIO_1X1: 3,
    OUTPUT_IMAGE_CROP_ASPECT_RATIO_7X9: 4,
}

export const LivenessType = {
    ACTIVE: "ACTIVE",
    PASSIVE: "PASSIVE",
}

export const LivenessSkipStep = {
    ONBOARDING_STEP: 1,
    SUCCESS_STEP: 2,
}

export const ImageQualityResultStatus = {
    IMAGE_QUALITY_RESULT_STATUS_FALSE: 0,
    IMAGE_QUALITY_RESULT_STATUS_TRUE: 1,
    IMAGE_QUALITY_RESULT_STATUS_UNDETERMINED: 2,
}

export const ImageType = {
    PRINTED: 1,
    RFID: 2,
    LIVE: 3,
    DOCUMENT_WITH_LIVE: 4,
    EXTERNAL: 5,
    GHOST_PORTRAIT: 6,
    BARCODE: 7,
}

export const FaceCaptureErrorCode = {
    CANCEL: "CANCEL",
    TIMEOUT: "TIMEOUT",
    NOT_INITIALIZED: "NOT_INITIALIZED",
    SESSION_START_FAILED: "SESSION_START_FAILED",
    CAMERA_NOT_AVAILABLE: "CAMERA_NOT_AVAILABLE",
    CAMERA_NO_PERMISSION: "CAMERA_NO_PERMISSION",
    IN_PROGRESS_ALREADY: "IN_PROGRESS_ALREADY",
    CONTEXT_IS_NULL: "CONTEXT_IS_NULL",
}

export const LivenessBackendErrorCode = {
    UNDEFINED: -1,
    NO_LICENSE: 200,
    LOW_QUALITY: 231,
    TRACK_BREAK: 246,
    CLOSED_EYES_DETECTED: 230,
    HIGH_ASYMMETRY: 232,
    FACE_OVER_EMOTIONAL: 233,
    SUNGLASSES_DETECTED: 234,
    SMALL_AGE: 235,
    HEADDRESS_DETECTED: 236,
    MEDICINE_MASK_DETECTED: 239,
    OCCLUSION_DETECTED: 240,
    FOREHEAD_GLASSES_DETECTED: 242,
    MOUTH_OPENED: 243,
    ART_MASK_DETECTED: 244,
    NOT_MATCHED: 237,
    IMAGES_COUNT_LIMIT_EXCEEDED: 238,
    ELECTRONIC_DEVICE_DETECTED: 245,
    WRONG_GEO: 247,
    WRONG_OF: 248,
    WRONG_VIEW: 249,
}

export const ProcessingMode = {
    ONLINE: "ONLINE",
    OFFLINE: "OFFLINE",
}

export const CustomizationImage = {
    ONBOARDING_SCREEN_CLOSE_BUTTON: "CustomizationImage.ONBOARDING_SCREEN_CLOSE_BUTTON",
    ONBOARDING_SCREEN_ILLUMINATION: "CustomizationImage.ONBOARDING_SCREEN_ILLUMINATION",
    ONBOARDING_SCREEN_ACCESSORIES: "CustomizationImage.ONBOARDING_SCREEN_ACCESSORIES",
    ONBOARDING_SCREEN_CAMERA_LEVEL: "CustomizationImage.ONBOARDING_SCREEN_CAMERA_LEVEL",
    CAMERA_SCREEN_CLOSE_BUTTON: "CustomizationImage.CAMERA_SCREEN_CLOSE_BUTTON",
    CAMERA_SCREEN_LIGHT_ON_BUTTON: "CustomizationImage.CAMERA_SCREEN_LIGHT_ON_BUTTON",
    CAMERA_SCREEN_LIGHT_OFF_BUTTON: "CustomizationImage.CAMERA_SCREEN_LIGHT_OFF_BUTTON",
    CAMERA_SCREEN_SWITCH_BUTTON: "CustomizationImage.CAMERA_SCREEN_SWITCH_BUTTON",
    RETRY_SCREEN_CLOSE_BUTTON: "CustomizationImage.RETRY_SCREEN_CLOSE_BUTTON",
    RETRY_SCREEN_HINT_ENVIRONMENT: "CustomizationImage.RETRY_SCREEN_HINT_ENVIRONMENT",
    RETRY_SCREEN_HINT_SUBJECT: "CustomizationImage.RETRY_SCREEN_HINT_SUBJECT",
    PROCESSING_SCREEN_CLOSE_BUTTON: "CustomizationImage.PROCESSING_SCREEN_CLOSE_BUTTON",
    SUCCESS_SCREEN_IMAGE: "CustomizationImage.SUCCESS_SCREEN_IMAGE",
}

export const DetectFacesAttribute = {
    AGE: "Age",
    EYE_RIGHT: "EyeRight",
    EYE_LEFT: "EyeLeft",
    EMOTION: "Emotion",
    SMILE: "Smile",
    GLASSES: "Glasses",
    HEAD_COVERING: "HeadCovering",
    FOREHEAD_COVERING: "ForeheadCovering",
    MOUTH: "Mouth",
    MEDICAL_MASK: "MedicalMask",
    OCCLUSION: "Occlusion",
    STRONG_MAKEUP: "StrongMakeup",
    HEADPHONES: "Headphones",
}

export const Enum = {
   FontStyle,
   CustomizationColor,
   ImageQualityGroupName,
   LicensingResultCode,
   DetectFacesErrorCode,
   InitErrorCode,
   LivenessStatus,
   CameraErrorCode,
   LivenessErrorCode,
   RecordingProcess,
   DetectFacesBackendErrorCode,
   MatchFacesErrorCode,
   ImageQualityCharacteristicName,
   ScreenOrientation,
   ButtonTag,
   CustomizationFont,
   DetectFacesScenario,
   LivenessProcessStatus,
   OutputImageCropAspectRatio,
   LivenessType,
   LivenessSkipStep,
   ImageQualityResultStatus,
   ImageType,
   FaceCaptureErrorCode,
   LivenessBackendErrorCode,
   ProcessingMode,
   CustomizationImage,
   DetectFacesAttribute,
}

export default class FaceSDK {
    static getServiceUrl(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static startLiveness(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getFaceSdkVersion(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static presentFaceCaptureActivity(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static stopFaceCaptureActivity(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    /**
     * @deprecated
     */
    static init(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static initialize(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static initializeWithConfig(config: any, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    /**
     * @deprecated
     */
    static deinit(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static deinitialize(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static isInitialized(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static stopLivenessProcessing(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static setRequestHeaders(headers: any, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static presentFaceCaptureActivityWithConfig(config: any, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static matchFacesWithConfig(request: string, config: any, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static startLivenessWithConfig(config: any, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static setServiceUrl(url: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static setLogs(isEnable: boolean, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static setSaveLogs(isSaveLog: boolean, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static setLogsFolder(path: boolean, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static matchFaces(request: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static detectFaces(request: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static setUiCustomizationLayer(json: any, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static setUiConfiguration(config: any, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static setLocalizationDictionary(dictionary: any, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static matchFacesSimilarityThresholdSplit(faces: string, similarity: number, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getPerson(personId: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static createPerson(name: string, groupIds: string, metadata: any, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static updatePerson(person: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static deletePerson(personId: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getPersonImages(personId: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getPersonImagesForPage(personId: string, page: number, size: number, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static addPersonImage(personId: string, image: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getPersonImage(personId: string, imageId: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static deletePersonImage(personId: string, imageId: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getGroups(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getGroupsForPage(page: number, size: number, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getPersonGroups(personId: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getPersonGroupsForPage(personId: string, page: number, size: number, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static createGroup(name: string, metadata: any, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getGroup(groupId: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static updateGroup(group: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static editPersonsInGroup(groupId: string, editGroupPersonsRequest: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getPersonsInGroup(groupId: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getPersonsInGroupForPage(groupId: string, page: number, size: number, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static deleteGroup(groupId: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static searchPerson(searchPersonRequest: any, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
}