import { NativeModules } from 'react-native'
export const { RNFaceApi } = NativeModules

export class Customization {
    colors?: Record<number, number>
    fonts?: Record<number, Font>
    images?: Record<number, string>
    uiCustomizationLayer?: Record<string, any>

    static fromJson(jsonObject?: any): Customization | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new Customization

        result.colors = jsonObject["colors"]
        result.fonts = jsonObject["fonts"]
        result.images = jsonObject["images"]
        result.uiCustomizationLayer = jsonObject["uiCustomizationLayer"]

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

export class DetectFaceResult {
    quality?: ImageQualityResult[]
    attributes?: DetectFacesAttributeResult[]
    crop?: string
    faceRect?: Rect
    originalRect?: Rect
    landmarks?: Point[]
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
        result.crop = jsonObject["crop"]
        result.faceRect = Rect.fromJson(jsonObject["faceRect"])
        result.originalRect = Rect.fromJson(jsonObject["originalRect"])
        result.landmarks = []
        if (jsonObject["landmarks"] != null) {
            for (const i in jsonObject["landmarks"]) {
                const item = Point.fromJson(jsonObject["landmarks"][i])
                if (item != undefined)
                    result.landmarks.push(item)
            }
        }
        result.isQualityCompliant = jsonObject["isQualityCompliant"]

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

export class DetectFacesConfig {
    attributes?: string[]
    customQuality?: ImageQualityCharacteristic[]
    outputImageParams?: OutputImageParams
    onlyCentralFace?: boolean

    static fromJson(jsonObject?: any): DetectFacesConfig | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new DetectFacesConfig

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

export class UnderlyingException {
    code?: number
    message?: string

    static fromJson(jsonObject?: any): UnderlyingException | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new UnderlyingException

        result.code = jsonObject["code"]
        result.message = jsonObject["message"]

        return result
    }
}

export class DetectFacesException {
    code?: number
    message?: string
    underlyingError?: UnderlyingException

    static fromJson(jsonObject?: any): DetectFacesException | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new DetectFacesException

        result.code = jsonObject["code"]
        result.message = jsonObject["message"]
        result.underlyingError = UnderlyingException.fromJson(jsonObject["underlyingError"])

        return result
    }
}

export class DetectFacesRequest {
    tag?: string
    scenario?: string
    image?: string
    configuration?: DetectFacesConfig

    static fromJson(jsonObject?: any): DetectFacesRequest | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new DetectFacesRequest

        result.tag = jsonObject["tag"]
        result.scenario = jsonObject["scenario"]
        result.image = jsonObject["image"]
        result.configuration = DetectFacesConfig.fromJson(jsonObject["configuration"])

        return result
    }
}

export class DetectFacesResponse {
    detection?: DetectFaceResult
    scenario?: string
    error?: DetectFacesException
    allDetections?: DetectFaceResult[]

    static fromJson(jsonObject?: any): DetectFacesResponse | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new DetectFacesResponse

        result.detection = DetectFaceResult.fromJson(jsonObject["detection"])
        result.scenario = jsonObject["scenario"]
        result.error = DetectFacesException.fromJson(jsonObject["error"])
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

export class FaceCaptureConfig {
    copyright?: boolean
    cameraSwitchEnabled?: boolean
    closeButtonEnabled?: boolean
    torchButtonEnabled?: boolean
    vibrateOnSteps?: boolean
    cameraPositionAndroid?: number
    cameraPositionIOS?: number
    screenOrientation?: number[]
    timeout?: number
    holdStillDuration?: number

    static fromJson(jsonObject?: any): FaceCaptureConfig | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new FaceCaptureConfig

        result.copyright = jsonObject["copyright"]
        result.cameraSwitchEnabled = jsonObject["cameraSwitchEnabled"]
        result.closeButtonEnabled = jsonObject["closeButtonEnabled"]
        result.torchButtonEnabled = jsonObject["torchButtonEnabled"]
        result.vibrateOnSteps = jsonObject["vibrateOnSteps"]
        result.cameraPositionAndroid = jsonObject["cameraPositionAndroid"]
        result.cameraPositionIOS = jsonObject["cameraPositionIOS"]
        result.screenOrientation = []
        if (jsonObject["screenOrientation"] != null) {
            for (const i in jsonObject["screenOrientation"]) {
                result.screenOrientation.push(jsonObject["screenOrientation"][i])
            }
        }
        result.timeout = jsonObject["timeout"]
        result.holdStillDuration = jsonObject["holdStillDuration"]

        return result
    }
}

export class FaceCaptureException {
    code?: number
    message?: string

    static fromJson(jsonObject?: any): FaceCaptureException | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new FaceCaptureException

        result.code = jsonObject["code"]
        result.message = jsonObject["message"]

        return result
    }
}

export class FaceCaptureImage {
    imageType?: number
    image?: string
    tag?: string

    static fromJson(jsonObject?: any): FaceCaptureImage | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new FaceCaptureImage

        result.imageType = jsonObject["imageType"]
        result.image = jsonObject["image"]
        result.tag = jsonObject["tag"]

        return result
    }
}

export class FaceCaptureResponse {
    error?: FaceCaptureException
    image?: FaceCaptureImage

    static fromJson(jsonObject?: any): FaceCaptureResponse | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new FaceCaptureResponse

        result.error = FaceCaptureException.fromJson(jsonObject["error"])
        result.image = FaceCaptureImage.fromJson(jsonObject["image"])

        return result
    }
}

export class OutputImageCrop {
    type?: number
    size?: Size
    padColor?: number
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

export class OutputImageParams {
    backgroundColor?: number
    crop?: OutputImageCrop

    static fromJson(jsonObject?: any): OutputImageParams | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new OutputImageParams

        result.backgroundColor = jsonObject["backgroundColor"]
        result.crop = OutputImageCrop.fromJson(jsonObject["crop"])

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

export class ImageQualityCharacteristic {
    characteristicName?: string
    color?: number
    recommendedRange?: ImageQualityRange
    customRange?: ImageQualityRange

    static fromJson(jsonObject?: any): ImageQualityCharacteristic | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new ImageQualityCharacteristic

        result.characteristicName = jsonObject["characteristicName"]
        result.color = jsonObject["color"]
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

export class FaceSDKVersion {
    api?: string
    core?: string
    coreMode?: string

    static fromJson(jsonObject?: any): FaceSDKVersion | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new FaceSDKVersion

        result.api = jsonObject["api"]
        result.core = jsonObject["core"]
        result.coreMode = jsonObject["coreMode"]

        return result
    }
}

export class InitConfig {
    license?: string
    licenseUpdate?: boolean

    static fromJson(jsonObject?: any): InitConfig | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new InitConfig

        result.license = jsonObject["license"]
        result.licenseUpdate = jsonObject["licenseUpdate"]

        return result
    }
}

export class InitException {
    code?: number
    message?: string
    underlyingError?: UnderlyingException

    static fromJson(jsonObject?: any): InitException | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new InitException

        result.code = jsonObject["code"]
        result.message = jsonObject["message"]
        result.underlyingError = UnderlyingException.fromJson(jsonObject["underlyingError"])

        return result
    }
}

export class LivenessConfig {
    copyright?: boolean
    cameraSwitchEnabled?: boolean
    closeButtonEnabled?: boolean
    torchButtonEnabled?: boolean
    vibrateOnSteps?: boolean
    cameraPositionAndroid?: number
    cameraPositionIOS?: number
    screenOrientation?: number[]
    locationTrackingEnabled?: boolean
    attemptsCount?: number
    recordingProcess?: number
    livenessType?: number
    tag?: string
    skipStep?: number[]
    metadata?: any

    static fromJson(jsonObject?: any): LivenessConfig | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new LivenessConfig

        result.copyright = jsonObject["copyright"]
        result.cameraSwitchEnabled = jsonObject["cameraSwitchEnabled"]
        result.closeButtonEnabled = jsonObject["closeButtonEnabled"]
        result.torchButtonEnabled = jsonObject["torchButtonEnabled"]
        result.vibrateOnSteps = jsonObject["vibrateOnSteps"]
        result.cameraPositionAndroid = jsonObject["cameraPositionAndroid"]
        result.cameraPositionIOS = jsonObject["cameraPositionIOS"]
        result.screenOrientation = []
        if (jsonObject["screenOrientation"] != null) {
            for (const i in jsonObject["screenOrientation"]) {
                result.screenOrientation.push(jsonObject["screenOrientation"][i])
            }
        }
        result.locationTrackingEnabled = jsonObject["locationTrackingEnabled"]
        result.attemptsCount = jsonObject["attemptsCount"]
        result.recordingProcess = jsonObject["recordingProcess"]
        result.livenessType = jsonObject["livenessType"]
        result.tag = jsonObject["tag"]
        result.skipStep = []
        if (jsonObject["skipStep"] != null) {
            for (const i in jsonObject["skipStep"]) {
                result.skipStep.push(jsonObject["skipStep"][i])
            }
        }
        result.metadata = jsonObject["metadata"]

        return result
    }
}

export class LivenessException {
    code?: number
    message?: string
    underlyingError?: UnderlyingException

    static fromJson(jsonObject?: any): LivenessException | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new LivenessException

        result.code = jsonObject["code"]
        result.message = jsonObject["message"]
        result.underlyingError = UnderlyingException.fromJson(jsonObject["underlyingError"])

        return result
    }
}

export class LivenessNotification {
    status?: number
    response?: LivenessResponse

    static fromJson(jsonObject?: any): LivenessNotification | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new LivenessNotification

        result.status = jsonObject["status"]
        result.response = LivenessResponse.fromJson(jsonObject["response"])

        return result
    }
}

export class LivenessResponse {
    image?: string
    liveness?: number
    tag?: string
    transactionId?: string
    estimatedAge?: number
    error?: LivenessException

    static fromJson(jsonObject?: any): LivenessResponse | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new LivenessResponse

        result.image = jsonObject["image"]
        result.liveness = jsonObject["liveness"]
        result.tag = jsonObject["tag"]
        result.transactionId = jsonObject["transactionId"]
        result.estimatedAge = jsonObject["estimatedAge"]
        result.error = LivenessException.fromJson(jsonObject["error"])

        return result
    }
}

export class ComparedFace {
    imageIndex?: number
    image?: MatchFacesImage
    faceIndex?: number
    face?: MatchFacesDetectionFace

    static fromJson(jsonObject?: any): ComparedFace | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new ComparedFace

        result.imageIndex = jsonObject["imageIndex"]
        result.image = MatchFacesImage.fromJson(jsonObject["image"])
        result.faceIndex = jsonObject["faceIndex"]
        result.face = MatchFacesDetectionFace.fromJson(jsonObject["face"])

        return result
    }
}

export class ComparedFacesPair {
    first?: ComparedFace
    second?: ComparedFace
    similarity?: number
    score?: number
    error?: MatchFacesException

    static fromJson(jsonObject?: any): ComparedFacesPair | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new ComparedFacesPair

        result.first = ComparedFace.fromJson(jsonObject["first"])
        result.second = ComparedFace.fromJson(jsonObject["second"])
        result.similarity = jsonObject["similarity"]
        result.score = jsonObject["score"]
        result.error = MatchFacesException.fromJson(jsonObject["error"])

        return result
    }
}

export class ComparedFacesSplit {
    matchedFaces?: ComparedFacesPair[]
    unmatchedFaces?: ComparedFacesPair[]

    static fromJson(jsonObject?: any): ComparedFacesSplit | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new ComparedFacesSplit

        result.matchedFaces = []
        if (jsonObject["matchedFaces"] != null) {
            for (const i in jsonObject["matchedFaces"]) {
                const item = ComparedFacesPair.fromJson(jsonObject["matchedFaces"][i])
                if (item != undefined)
                    result.matchedFaces.push(item)
            }
        }
        result.unmatchedFaces = []
        if (jsonObject["unmatchedFaces"] != null) {
            for (const i in jsonObject["unmatchedFaces"]) {
                const item = ComparedFacesPair.fromJson(jsonObject["unmatchedFaces"][i])
                if (item != undefined)
                    result.unmatchedFaces.push(item)
            }
        }

        return result
    }
}

export class MatchFacesConfig {
    processingMode?: number

    static fromJson(jsonObject?: any): MatchFacesConfig | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new MatchFacesConfig

        result.processingMode = jsonObject["processingMode"]

        return result
    }
}

export class MatchFacesDetection {
    imageIndex?: number
    image?: MatchFacesImage
    faces?: MatchFacesDetectionFace[]
    error?: MatchFacesException

    static fromJson(jsonObject?: any): MatchFacesDetection | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new MatchFacesDetection

        result.imageIndex = jsonObject["imageIndex"]
        result.image = MatchFacesImage.fromJson(jsonObject["image"])
        result.faces = []
        if (jsonObject["faces"] != null) {
            for (const i in jsonObject["faces"]) {
                const item = MatchFacesDetectionFace.fromJson(jsonObject["faces"][i])
                if (item != undefined)
                    result.faces.push(item)
            }
        }
        result.error = MatchFacesException.fromJson(jsonObject["error"])

        return result
    }
}

export class MatchFacesDetectionFace {
    faceIndex?: number
    landmarks?: Point[]
    faceRect?: Rect
    rotationAngle?: number
    originalRect?: Rect
    crop?: string

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
        result.originalRect = Rect.fromJson(jsonObject["originalRect"])
        result.crop = jsonObject["crop"]

        return result
    }
}

export class MatchFacesException {
    code?: number
    message?: string
    underlyingError?: UnderlyingException

    static fromJson(jsonObject?: any): MatchFacesException | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new MatchFacesException

        result.code = jsonObject["code"]
        result.message = jsonObject["message"]
        result.underlyingError = UnderlyingException.fromJson(jsonObject["underlyingError"])

        return result
    }
}

export class MatchFacesImage {
    image?: string
    imageType?: number
    detectAll?: boolean
    identifier?: string

    static fromJson(jsonObject?: any): MatchFacesImage | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new MatchFacesImage

        result.image = jsonObject["image"]
        result.imageType = jsonObject["imageType"]
        result.detectAll = jsonObject["detectAll"]
        result.identifier = jsonObject["identifier"]

        return result
    }
}

export class MatchFacesRequest {
    images?: MatchFacesImage[]
    outputImageParams?: OutputImageParams
    tag?: string
    metadata?: any

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
        result.outputImageParams = OutputImageParams.fromJson(jsonObject["outputImageParams"])
        result.tag = jsonObject["tag"]
        result.metadata = jsonObject["metadata"]

        return result
    }
}

export class MatchFacesResponse {
    results?: ComparedFacesPair[]
    detections?: MatchFacesDetection[]
    tag?: string
    error?: MatchFacesException

    static fromJson(jsonObject?: any): MatchFacesResponse | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new MatchFacesResponse

        result.results = []
        if (jsonObject["results"] != null) {
            for (const i in jsonObject["results"]) {
                const item = ComparedFacesPair.fromJson(jsonObject["results"][i])
                if (item != undefined)
                    result.results.push(item)
            }
        }
        result.detections = []
        if (jsonObject["detections"] != null) {
            for (const i in jsonObject["detections"]) {
                const item = MatchFacesDetection.fromJson(jsonObject["detections"][i])
                if (item != undefined)
                    result.detections.push(item)
            }
        }
        result.tag = jsonObject["tag"]
        result.error = MatchFacesException.fromJson(jsonObject["error"])

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

export class PageableItemList {
    items?: any[]
    page?: number
    totalPages?: number

    static fromJson(jsonObject?: any): PageableItemList | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new PageableItemList

        result.items = []
        if (jsonObject["items"] != null) {
            for (const i in jsonObject["items"]) {
                result.items.push(jsonObject["items"][i])
            }
        }
        result.page = jsonObject["page"]
        result.totalPages = jsonObject["totalPages"]

        return result
    }
}

export class Person {
    name?: string
    updatedAt?: string
    groups?: string[]
    id?: string
    metadata?: any
    createdAt?: string

    static fromJson(jsonObject?: any): Person | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new Person

        result.name = jsonObject["name"]
        result.updatedAt = jsonObject["updatedAt"]
        result.groups = []
        if (jsonObject["groups"] != null) {
            for (const i in jsonObject["groups"]) {
                result.groups.push(jsonObject["groups"][i])
            }
        }
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

export class SearchPerson {
    images?: SearchPersonImage[]
    detection?: SearchPersonDetection
    name?: string
    updatedAt?: string
    groups?: string[]
    id?: string
    metadata?: any
    createdAt?: string

    static fromJson(jsonObject?: any): SearchPerson | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new SearchPerson

        result.images = []
        if (jsonObject["images"] != null) {
            for (const i in jsonObject["images"]) {
                const item = SearchPersonImage.fromJson(jsonObject["images"][i])
                if (item != undefined)
                    result.images.push(item)
            }
        }
        result.detection = SearchPersonDetection.fromJson(jsonObject["detection"])
        result.name = jsonObject["name"]
        result.updatedAt = jsonObject["updatedAt"]
        result.groups = []
        if (jsonObject["groups"] != null) {
            for (const i in jsonObject["groups"]) {
                result.groups.push(jsonObject["groups"][i])
            }
        }
        result.id = jsonObject["id"]
        result.metadata = jsonObject["metadata"]
        result.createdAt = jsonObject["createdAt"]

        return result
    }
}

export class SearchPersonDetection {
    landmarks?: Point[]
    rect?: Rect
    crop?: string
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
        result.crop = jsonObject["crop"]
        result.rotationAngle = jsonObject["rotationAngle"]

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

export class SearchPersonRequest {
    imageUpload?: ImageUpload
    groupIdsForSearch?: string[]
    threshold?: number
    limit?: number
    detectAll?: boolean
    outputImageParams?: OutputImageParams

    static fromJson(jsonObject?: any): SearchPersonRequest | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new SearchPersonRequest

        result.imageUpload = ImageUpload.fromJson(jsonObject["imageUpload"])
        result.groupIdsForSearch = []
        if (jsonObject["groupIdsForSearch"] != null) {
            for (const i in jsonObject["groupIdsForSearch"]) {
                result.groupIdsForSearch.push(jsonObject["groupIdsForSearch"][i])
            }
        }
        result.threshold = jsonObject["threshold"]
        result.limit = jsonObject["limit"]
        result.detectAll = jsonObject["detectAll"]
        result.outputImageParams = OutputImageParams.fromJson(jsonObject["outputImageParams"])

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

export class PersonDBResponse {
    data?: any
    error?: string

    static fromJson(jsonObject?: any): PersonDBResponse | undefined {
        if (jsonObject == null || jsonObject == undefined) return undefined
        const result = new PersonDBResponse

        result.data = jsonObject["data"]
        result.error = jsonObject["error"]

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
    ONBOARDING_SCREEN_START_BUTTON_BACKGROUND: 100,
    ONBOARDING_SCREEN_START_BUTTON_TITLE: 101,
    ONBOARDING_SCREEN_BACKGROUND: 102,
    ONBOARDING_SCREEN_TITLE_LABEL_TEXT: 103,
    ONBOARDING_SCREEN_SUBTITLE_LABEL_TEXT: 104,
    ONBOARDING_SCREEN_MESSAGE_LABELS_TEXT: 105,
    CAMERA_SCREEN_STROKE_NORMAL: 200,
    CAMERA_SCREEN_STROKE_ACTIVE: 201,
    CAMERA_SCREEN_SECTOR_TARGET: 202,
    CAMERA_SCREEN_SECTOR_ACTIVE: 203,
    CAMERA_SCREEN_FRONT_HINT_LABEL_BACKGROUND: 204,
    CAMERA_SCREEN_FRONT_HINT_LABEL_TEXT: 205,
    CAMERA_SCREEN_BACK_HINT_LABEL_BACKGROUND: 206,
    CAMERA_SCREEN_BACK_HINT_LABEL_TEXT: 207,
    CAMERA_SCREEN_LIGHT_TOOLBAR_TINT: 208,
    CAMERA_SCREEN_DARK_TOOLBAR_TINT: 209,
    RETRY_SCREEN_BACKGROUND: 300,
    RETRY_SCREEN_RETRY_BUTTON_BACKGROUND: 301,
    RETRY_SCREEN_RETRY_BUTTON_TITLE: 302,
    RETRY_SCREEN_TITLE_LABEL_TEXT: 303,
    RETRY_SCREEN_SUBTITLE_LABEL_TEXT: 304,
    RETRY_SCREEN_HINT_LABELS_TEXT: 305,
    PROCESSING_SCREEN_BACKGROUND: 400,
    PROCESSING_SCREEN_PROGRESS: 401,
    PROCESSING_SCREEN_TITLE: 402,
    SUCCESS_SCREEN_BACKGROUND: 500,
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
    OK: 0,
    LICENSE_CORRUPTED: 1,
    INVALID_DATE: 2,
    INVALID_VERSION: 3,
    INVALID_DEVICE_ID: 4,
    INVALID_SYSTEM_OR_APP_ID: 5,
    NO_CAPABILITIES: 6,
    NO_AUTHENTICITY: 7,
    LICENSE_ABSENT: 8,
    NO_INTERNET: 9,
    NO_DATABASE: 10,
    DATABASE_INCORRECT: 11,
}

export const DetectFacesErrorCode = {
    IMAGE_EMPTY: 0,
    FR_FACE_NOT_DETECTED: 1,
    FACER_NO_LICENSE: 2,
    FACER_IS_NOT_INITIALIZED: 3,
    FACER_COMMAND_IS_NOT_SUPPORTED: 4,
    FACER_COMMAND_PARAMS_READ_ERROR: 5,
    PROCESSING_FAILED: 6,
    REQUEST_FAILED: 7,
    API_CALL_FAILED: 8,
}

export const CameraPosition = {
    FRONT: 0,
    BACK: 1,
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
    PASSED: 0,
    UNKNOWN: 1,
}

export const LivenessErrorCode = {
    NOT_INITIALIZED: 0,
    NO_LICENSE: 1,
    API_CALL_FAILED: 2,
    SESSION_START_FAILED: 3,
    CANCELLED: 4,
    PROCESSING_TIMEOUT: 5,
    PROCESSING_FAILED: 6,
    PROCESSING_FRAME_FAILED: 7,
    APPLICATION_INACTIVE: 8,
    CONTEXT_IS_NULL: 9,
    IN_PROGRESS_ALREADY: 10,
    ZOOM_NOT_SUPPORTED: 11,
    CAMERA_NO_PERMISSION: 12,
    CAMERA_NOT_AVAILABLE: 13,
}

export const RecordingProcess = {
    ASYNCHRONOUS_UPLOAD: 0,
    SYNCHRONOUS_UPLOAD: 1,
    NOT_UPLOAD: 2,
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
    IMAGE_EMPTY: 0,
    FACE_NOT_DETECTED: 1,
    LANDMARKS_NOT_DETECTED: 2,
    FACE_ALIGNER_FAILED: 3,
    DESCRIPTOR_EXTRACTOR_ERROR: 4,
    IMAGES_COUNT_LIMIT_EXCEEDED: 5,
    API_CALL_FAILED: 6,
    PROCESSING_FAILED: 7,
    NO_LICENSE: 8,
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
    PORTRAIT: 0,
    LANDSCAPE: 1,
}

export const CustomizationFont = {
    ONBOARDING_SCREEN_START_BUTTON: 100,
    ONBOARDING_SCREEN_TITLE_LABEL: 101,
    ONBOARDING_SCREEN_SUBTITLE_LABEL: 102,
    ONBOARDING_SCREEN_MESSAGE_LABELS: 103,
    CAMERA_SCREEN_HINT_LABEL: 200,
    RETRY_SCREEN_RETRY_BUTTON: 300,
    RETRY_SCREEN_TITLE_LABEL: 301,
    RETRY_SCREEN_SUBTITLE_LABEL: 302,
    RETRY_SCREEN_HINT_LABELS: 303,
    PROCESSING_SCREEN: 400,
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
    START: 0,
    PREPARING: 1,
    NEW_SESSION: 2,
    NEXT_STAGE: 3,
    SECTOR_CHANGED: 4,
    PROGRESS: 5,
    LOW_BRIGHTNESS: 6,
    FIT_FACE: 7,
    MOVE_AWAY: 8,
    MOVE_CLOSER: 9,
    TURN_HEAD: 10,
    PROCESSING: 11,
    FAILED: 12,
    RETRY: 13,
    SUCCESS: 14,
}

export const OutputImageCropAspectRatio = {
    OUTPUT_IMAGE_CROP_ASPECT_RATIO_3X4: 0,
    OUTPUT_IMAGE_CROP_ASPECT_RATIO_4X5: 1,
    OUTPUT_IMAGE_CROP_ASPECT_RATIO_2X3: 2,
    OUTPUT_IMAGE_CROP_ASPECT_RATIO_1X1: 3,
    OUTPUT_IMAGE_CROP_ASPECT_RATIO_7X9: 4,
}

export const LivenessType = {
    ACTIVE: 0,
    PASSIVE: 1,
}

export const LivenessSkipStep = {
    ONBOARDING_STEP: 0,
    SUCCESS_STEP: 1,
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
    CANCEL: 0,
    TIMEOUT: 1,
    NOT_INITIALIZED: 2,
    SESSION_START_FAILED: 3,
    CAMERA_NOT_AVAILABLE: 4,
    CAMERA_NO_PERMISSION: 5,
    IN_PROGRESS_ALREADY: 6,
    CONTEXT_IS_NULL: 7,
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
    ONLINE: 0,
    OFFLINE: 1,
}

export const CustomizationImage = {
    ONBOARDING_SCREEN_CLOSE_BUTTON: 100,
    ONBOARDING_SCREEN_ILLUMINATION: 101,
    ONBOARDING_SCREEN_ACCESSORIES: 102,
    ONBOARDING_SCREEN_CAMERA_LEVEL: 103,
    CAMERA_SCREEN_CLOSE_BUTTON: 200,
    CAMERA_SCREEN_LIGHT_ON_BUTTON: 201,
    CAMERA_SCREEN_LIGHT_OFF_BUTTON: 202,
    CAMERA_SCREEN_SWITCH_BUTTON: 203,
    RETRY_SCREEN_CLOSE_BUTTON: 300,
    RETRY_SCREEN_HINT_ENVIRONMENT: 301,
    RETRY_SCREEN_HINT_SUBJECT: 302,
    PROCESSING_SCREEN_CLOSE_BUTTON: 400,
    SUCCESS_SCREEN_IMAGE: 500,
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
   CameraPosition,
   InitErrorCode,
   LivenessStatus,
   LivenessErrorCode,
   RecordingProcess,
   DetectFacesBackendErrorCode,
   MatchFacesErrorCode,
   ImageQualityCharacteristicName,
   ScreenOrientation,
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
    static getVersion(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getServiceUrl(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static setServiceUrl(url: string | null, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static setLocalizationDictionary(dictionary: Record<string, string>, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static setRequestHeaders(headers: Record<string, string>, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static setCustomization(config: Customization, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static isInitialized(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static initialize(config: InitConfig | null, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static deinitialize(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static startFaceCapture(config: FaceCaptureConfig | null, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static stopFaceCapture(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static startLiveness(config: LivenessConfig | null, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static stopLiveness(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static matchFaces(request: MatchFacesRequest, config: MatchFacesConfig | null, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static splitComparedFaces(facesPairs: ComparedFacesPair[], similarityThreshold: number, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static detectFaces(request: DetectFacesRequest, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static createPerson(name: string, groupIds: string[] | null, metadata: Record<string, any> | null, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static updatePerson(person: Person, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static deletePerson(personId: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getPerson(personId: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static addPersonImage(personId: string, image: ImageUpload, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static deletePersonImage(personId: string, imageId: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getPersonImage(personId: string, imageId: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getPersonImages(personId: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getPersonImagesForPage(personId: string, page: number, size: number, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static createGroup(name: string, metadata: Record<string, any> | null, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static updateGroup(group: PersonGroup, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static editPersonsInGroup(groupId: string, editGroupPersonsRequest: EditGroupPersonsRequest, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static deleteGroup(groupId: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getGroup(groupId: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getGroups(successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getGroupsForPage(page: number, size: number, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getPersonGroups(personId: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getPersonGroupsForPage(personId: string, page: number, size: number, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getPersonsInGroup(groupId: string, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static getPersonsInGroupForPage(groupId: string, page: number, size: number, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
    static searchPerson(searchPersonRequest: SearchPersonRequest, successCallback: (response: string) => void, errorCallback?: (error: string) => void): void
}