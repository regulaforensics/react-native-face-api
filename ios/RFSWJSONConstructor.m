#import "RFSWJSONConstructor.h"
@import FaceSDK.Private;
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@implementation RFSWJSONConstructor

#pragma mark - Utils

+(id)toSendable:(id)input {
    if (!input || [input isEqual:[NSNull null]])  return nil;
    if ([input isKindOfClass:[NSDictionary class]] || [input isKindOfClass:[NSArray class]])
        return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:input
                                                                              options:NSJSONWritingPrettyPrinted
                                                                                error:nil]
                                     encoding:NSUTF8StringEncoding];
    return input;
}

+(id)convertArray:(NSArray*)input :(SEL)converter {
    NSMutableArray* result = @[].mutableCopy;
    for (id item in input)
        [result addObject:[RFSWJSONConstructor performSelector:converter withObject:item]];
    return result;
}

+(id)generateArray:(NSArray*)input :(SEL)toJson {
    if (!input) return [NSNull null];
    return [self convertArray:input :toJson];
}

+(id)arrayFromJSON:(NSArray*)input :(SEL)fromJson {
    if (!input || [input isEqual:[NSNull null]])  return nil;
    return [self convertArray:input :fromJson];
}

+(id)base64Decode:(NSString*)input {
    if (!input || [input isEqual:[NSNull null]])  return nil;
    return [[NSData alloc] initWithBase64EncodedString:input options:0];
}

+(id)base64Encode:(NSData*)input {
    if (!input) return [NSNull null];
    return [input base64EncodedStringWithOptions:0];
}

+(id)imageWithBase64:(NSString*)input {
    if (!input || [input isEqual:[NSNull null]])  return nil;
    return [UIImage imageWithData:[self base64Decode:input]];
}

+(id)base64WithImage:(UIImage*)input {
    if (!input) return [NSNull null];
    return [self base64Encode: UIImagePNGRepresentation(input)];
}

#pragma mark - Config

+(id)fontFromJSON:(NSDictionary*)input {
    return [UIFont fontWithName:input[@"name"]
                           size:[input[@"size"] integerValue]];
}

+(RFSLivenessStepSkip)livenessStepSkipFromJSON:(NSArray<NSNumber*>*)input {
    // same as input.contains(1)
    bool start = CFArrayContainsValue((__bridge CFArrayRef)input, CFRangeMake(0, input.count), (CFNumberRef)@0);
    bool done = CFArrayContainsValue((__bridge CFArrayRef)input, CFRangeMake(0, input.count), (CFNumberRef)@1);
    
    if (start && !done) return RFSLivenessStepSkipOnboarding;
    if (done && !start) return RFSLivenessStepSkipSuccess;
    if (start && done) return RFSLivenessStepSkipOnboarding | RFSLivenessStepSkipSuccess;
    
    return RFSLivenessStepSkipNone;
}

+(NSArray<NSNumber*>*)generateLivenessStepSkip:(RFSLivenessStepSkip)input {
    if(input == RFSLivenessStepSkipOnboarding) return @[@0];
    if(input == RFSLivenessStepSkipSuccess) return @[@1];
    if(input == (RFSLivenessStepSkipOnboarding | RFSLivenessStepSkipSuccess)) return @[@0, @1];
    return @[];
}

+(id)colorWithInt:(NSNumber*)input {
    if (!input || [input isEqual:[NSNull null]])  return nil;
    // Convert hex int to hex string
    NSInteger hexInt = [input integerValue];
    NSString* numbers = @"0123456789ABCDEF";
    NSString* hexString = @"";
    while (hexInt>0){
        int digit = hexInt % 16;
        hexString = [NSString stringWithFormat:@"%@%@", [numbers substringWithRange:NSMakeRange(digit, 1)], hexString];
        hexInt = hexInt/16;
    }
    // If we use int, then all the starting zeros are lost: 0x0F123456 == 0xF123456
    if (hexString.length == 5 || hexString.length == 7)
        hexString = [NSString stringWithFormat:@"0%@", hexString];
    hexString = [NSString stringWithFormat:@"#%@", hexString];
    
    // Convert hex string to UIColor
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed:red green: green blue: blue alpha: alpha];
}

+(CGFloat)colorComponentFrom:(NSString*)string start:(NSUInteger)start length:(NSUInteger)length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

+(id)intWithColor:(UIColor*)input {
    if (!input) return [NSNull null];
    
    const CGFloat *components = CGColorGetComponents(input.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    CGFloat a = components[3];
    
    NSString* hexString = [NSString stringWithFormat:@"#%02lX%02lX%02lX%02lX",
                           lroundf(a * 255),
                           lroundf(r * 255),
                           lroundf(g * 255),
                           lroundf(b * 255)];
    
    unsigned int hexInt = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexInt];
    
    return [NSNumber numberWithInteger:hexInt];
}

#pragma mark - Init

+(id)generateError:(NSError*)input {
    if (!input) return [NSNull null];
    NSMutableDictionary* result = @{
        @"code":@(input.code),
        @"underlyingError":[self generateUnderlyingError:input]
    }.mutableCopy;
    if (input.localizedDescription) result[@"message"] = input.localizedDescription;
    return result;
}

+(id)generateUnderlyingError:(NSError*)input {
    NSError* tempError = input.userInfo[NSUnderlyingErrorKey];
    if (!tempError) return [NSNull null];
    RFSBackendError* error = tempError.userInfo[NSUnderlyingErrorKey];
    if (!error) return [NSNull null];
    NSMutableDictionary* result = @{ @"code":@(error.code) }.mutableCopy;
    if (error.userInfo[RFSBackendErrorOriginalMessageKey]) result[@"message"] =error.userInfo[RFSBackendErrorOriginalMessageKey];
    return result;
}

+(id)faceSDKVersionFromJSON:(NSDictionary*)input {
    if (!input || [input isEqual:[NSNull null]])  return nil;
    RFSFaceSDKVersion* result = [RFSFaceSDKVersion new];
    
    [result setValue:input[@"api"] forKey:@"api"];
    [result setValue:input[@"core"] forKey:@"core"];
    [result setValue:input[@"coreMode"] forKey:@"coreMode"];
    
    return result;
}

+(id)generateFaceSDKVersion:(RFSFaceSDKVersion*)input {
    if (!input) return [NSNull null];
    NSMutableDictionary* result = @{}.mutableCopy;
    
    if (input.api) result[@"api"] = input.api;
    if (input.core) result[@"core"] = input.core;
    if (input.coreMode) result[@"coreMode"] = input.coreMode;
    
    return result;
}

+(id)generateInitCompletion:(BOOL)success :(NSError*)error {
    return @{
        @"success":@(success),
        @"error":[self generateError:error]
    };
}

+(id)initConfigFromJSON:(NSDictionary*)input {
    if (!input || [input isEqual:[NSNull null]])  return nil;
    return [RFSInitializationConfiguration configurationWithBuilder:^(RFSInitializationConfigurationBuilder * builder) {
        [builder setLicenseData:[self base64Decode:input[@"license"]]];
        if (input[@"licenseUpdate"]) [builder setLicenseUpdate:[input[@"licenseUpdate"] boolValue]];
    }];
}

+(id)generateInitConfig:(RFSInitializationConfiguration*)input {
    return @{
        @"license":[self base64Encode:input.licenseData],
        @"licenseUpdate":@(input.licenseUpdate)
    };
}

+(id)generateVideoEncoderCompletion:(NSString*)transactionId :(BOOL)success {
    NSMutableDictionary* result = @{
        @"success":@(success)
    }.mutableCopy;
    if (transactionId) result[@"transactionId"] = transactionId;
    return result;
}

#pragma mark - FaceCapture

+(id)faceCaptureImageFromJSON:(NSDictionary*)input {
    if (!input) return nil;
    RFSImage* result = [[RFSImage alloc] initWithImage:[self imageWithBase64:input[@"image"]]
                                                  type:[input[@"imageType"] integerValue]];
    [result setValue:input[@"tag"] forKey:@"identifier"];
    return result;
}

+(id)generateFaceCaptureImage:(RFSImage*)input {
    if (!input) return [NSNull null];
    return @{
        @"imageType":@(input.imageType),
        @"image":[self base64WithImage:input.image],
        @"tag":input.identifier,
    };
}

+(id)faceCaptureResponseFromJSON:(NSDictionary*)input {
    return [[RFSFaceCaptureResponse alloc] performSelector:NSSelectorFromString(@"initWithImage:error:")
                                                withObject:[self faceCaptureImageFromJSON:input[@"image"]]
                                                withObject:nil];
}

+(id)generateFaceCaptureResponse:(RFSFaceCaptureResponse*)input {
    return @{
        @"image":[self generateFaceCaptureImage:input.image],
        @"error":[self generateError:input.error]
    };
}

#pragma mark - Liveness

+(id)livenessResponseFromJSON:(NSDictionary*)input {
    RFSLivenessResponse* result = [RFSLivenessResponse alloc];
    SEL sel = NSSelectorFromString(@"initWithTag:transactionId:estimatedAge:status:normalImage:scaledImage:error:");
    IMP imp = [result methodForSelector:sel];
    void (*func)(id, SEL, id, id, id, NSInteger, id, id, id) = (void *)imp;
    func(result,
         sel,
         input[@"tag"],
         input[@"transactionId"],
         input[@"estimatedAge"],
         [input[@"liveness"] integerValue],
         [self imageWithBase64:input[@"image"]],
         [self imageWithBase64:input[@"image"]],
         nil);
    return result;
}

+(id)generateLivenessResponse:(RFSLivenessResponse*)input {
    if (!input) return [NSNull null];
    NSMutableDictionary* result = @{
        @"image":[self base64WithImage:input.image],
        @"liveness":@(input.liveness),
        @"error":[self generateError:input.error],
    }.mutableCopy;
    if (input.estimatedAge) result[@"estimatedAge"] = input.estimatedAge;
    if (input.tag) result[@"tag"] = input.tag;
    if (input.transactionId) result[@"transactionId"] = input.transactionId;
    return result;
}

+(id)generateLivenessNotification:(RFSLivenessProcessStatus)status result:(RFSLivenessResponse*)response {
    return @{
        @"status":@(status),
        @"result":[self generateLivenessResponse:response]
    };
}

#pragma mark - MatchFaces

+(id)matchFacesImageFromJSON:(NSDictionary*)input {
    bool detectAll = false;
    if (input[@"detectAll"]) detectAll = input[@"detectAll"];
    RFSMatchFacesImage* result = [[RFSMatchFacesImage alloc] initWithImage:[self imageWithBase64:input[@"image"]]
                                                                 imageType:[input[@"imageType"] integerValue]
                                                                 detectAll:detectAll];
    if (input[@"identifier"]) [result setValue:input[@"identifier"] forKey:@"identifier"];
    return result;
}

+(id)generateMatchFacesImage:(RFSMatchFacesImage*)input {
    return @{
        @"imageType":@(input.imageType),
        @"image":[self base64WithImage:input.image],
        @"detectAll":@(input.detectAll),
        @"identifier":input.identifier
    };
}

+(CGSize)sizeFromJSON:(NSDictionary*)input {
    if (!input) return CGSizeZero;
    return CGSizeMake([input[@"width"] floatValue],
                      [input[@"height"] floatValue]);
}

+(id)generateSize:(CGSize)input {
    if (CGSizeEqualToSize(input, CGSizeZero)) return [NSNull null];
    // this is default size that is created in sdk if you pass null
    if (CGSizeEqualToSize(input, CGSizeMake(60, 80))) return [NSNull null];
    return @{
        @"width": @(input.width),
        @"height":@(input.height)
    };
}

+(id)outputImageCropFromJSON:(NSDictionary*)input {
    if (!input || [input isEqual:[NSNull null]])  return nil;
    bool returnOriginalRect = false;
    if (input[@"returnOriginalRect"]) returnOriginalRect = [input[@"returnOriginalRect"] boolValue];
    return [[RFSOutputImageCrop alloc] initWithType:[input[@"type"] integerValue]
                                               size:[self sizeFromJSON:input[@"size"]]
                                           padColor:[self colorWithInt:input[@"padColor"]]
                                 returnOriginalRect:returnOriginalRect];
}

+(id)generateOutputImageCrop:(RFSOutputImageCrop*)input {
    if (!input) return [NSNull null];
    return @{
        @"type": @(input.type),
        @"size": [self generateSize:input.size],
        @"padColor": [self intWithColor:input.padColor],
        @"returnOriginalRect": @(input.returnOriginalRect)
    };
}

+(id)outputImageParamsFromJSON:(NSDictionary*)input {
    if (!input || [input isEqual:[NSNull null]])  return nil;
    RFSOutputImageParams* result = [RFSOutputImageParams new];
    result.backgroundColor = [self colorWithInt:input[@"backgroundColor"]];
    result.crop = [self outputImageCropFromJSON:input[@"crop"]];
    return result;
}

+(id)generateOutputImageParams:(RFSOutputImageParams*)input {
    if (!input) return [NSNull null];
    return @{
        @"crop": [self generateOutputImageCrop:input.crop],
        @"backgroundColor": [self intWithColor:input.backgroundColor],
    };
}

+(id)matchFacesRequestFromJSON:(NSDictionary*)input {
    RFSMatchFacesRequest* result = [[RFSMatchFacesRequest alloc] initWithImages:[self arrayFromJSON:input[@"images"] :@selector(matchFacesImageFromJSON:)]];
    result.metadata = input[@"metadata"];
    result.tag = input[@"tag"];
    result.outputImageParams = [RFSWJSONConstructor outputImageParamsFromJSON:input[@"outputImageParams"]];
    return result;
}

+(id)generateMatchFacesRequest:(RFSMatchFacesRequest*)input {
    if (!input) return [NSNull null];
    NSMutableDictionary* result = @{
        @"images":[self generateArray:input.images :@selector(generateMatchFacesImage:)],
    }.mutableCopy;
    if (input.metadata) result[@"metadata"] = input.metadata;
    if (input.tag) result[@"tag"] = input.tag;
    if (input.outputImageParams) result[@"outputImageParams"] = [self generateOutputImageParams:input.outputImageParams];
    return result;
}

+(id)pointFromJSON:(NSDictionary*)input {
    return [[RFSPoint alloc] initWithX:[input[@"x"] floatValue]
                                     y:[input[@"y"] floatValue]];
}

+(id)generatePoint:(RFSPoint*)input {
    return @{
        @"x":@(input.x),
        @"y":@(input.y)
    };
}

+(CGRect)rectFromJSON:(NSDictionary*)input {
    if (!input) return CGRectNull;
    return CGRectMake(
                      [input[@"left"] floatValue],
                      [input[@"top"] floatValue],
                      [input[@"right"] floatValue] - [input[@"left"] floatValue],
                      [input[@"bottom"] floatValue] - [input[@"top"] floatValue]);
}

+(id)generateRect:(CGRect)input {
    if (CGRectEqualToRect(input, CGRectNull)) return [NSNull null];
    return @{
        @"top":@(input.origin.y),
        @"left":@(input.origin.x),
        @"bottom":@(input.origin.y+input.size.height),
        @"right":@(input.origin.x+input.size.width)
    };
}

+(id)matchFacesDetectionFaceFromJSON:(NSDictionary*)input {
    if (!input || [input isEqual:[NSNull null]])  return nil;
    return [[RFSMatchFacesDetectionFace alloc] initWithFaceIndex:input[@"faceIndex"]
                                                       landmarks:[self arrayFromJSON:input[@"landmarks"] :@selector(pointFromJSON:)]
                                                        faceRect:[self rectFromJSON:input[@"faceRect"]]
                                                   rotationAngle:input[@"rotationAngle"]
                                                  thumbnailImage:nil
                                                            crop:[self imageWithBase64:input[@"crop"]]
                                                    originalRect:[self rectFromJSON:input[@"originalRect"]]];
}

+(id)generateMatchFacesDetectionFace:(RFSMatchFacesDetectionFace*)input {
    if (!input) return [NSNull null];
    NSMutableDictionary* result = @{
        @"faceIndex":input.faceIndex,
        @"landmarks":[self generateArray:input.landmarks :@selector(generatePoint:)],
        @"faceRect":[self generateRect:input.faceRect],
        @"crop":[self base64WithImage:input.crop],
        @"originalRect":[self generateRect:input.originalRect]
    }.mutableCopy;
    if (input.rotationAngle) result[@"rotationAngle"] = input.rotationAngle;
    return result;
}

+(id)matchFacesDetectionFromJSON:(NSDictionary*)input {
    RFSMatchFacesDetection* result = [RFSMatchFacesDetection alloc];
    SEL sel = NSSelectorFromString(@"initWithImageIndex:image:faces:error:");
    IMP imp = [result methodForSelector:sel];
    void (*func)(id, SEL, id, id, id, id) = (void *)imp;
    func(result,
         sel,
         input[@"imageIndex"],
         [self matchFacesImageFromJSON:input[@"image"]],
         [self arrayFromJSON:input[@"faces"] :@selector(matchFacesDetectionFaceFromJSON:)],
         nil);
    return result;
}

+(id)generateMatchFacesDetection:(RFSMatchFacesDetection*)input {
    return @{
        @"image":[self generateMatchFacesImage:input.image],
        @"imageIndex":input.imageIndex,
        @"faces":[self generateArray:input.faces :@selector(generateMatchFacesDetectionFace:)],
        @"error":[self generateError:input.error]
    };
}

+(id)comparedFaceFromJSON:(NSDictionary*)input {
    return [[RFSMatchFacesComparedFace alloc] initWithImageIndex:input[@"imageIndex"]
                                                           image:[self matchFacesImageFromJSON:input[@"image"]]
                                                       faceIndex:input[@"faceIndex"]
                                                            face:[self matchFacesDetectionFaceFromJSON:input[@"face"]]];
}

+(id)generateComparedFace:(RFSMatchFacesComparedFace*)input {
    NSMutableDictionary* result = @{
        @"imageIndex":input.imageIndex,
        @"image":[self generateMatchFacesImage:input.image],
        @"face":[self generateMatchFacesDetectionFace:input.face]
    }.mutableCopy;
    if (input.faceIndex) result[@"faceIndex"] = input.faceIndex;
    return result;
}

+(id)comparedFacesPairFromJSON:(NSDictionary*)input {
    return [[RFSMatchFacesComparedFacesPair alloc] initWithFirst:[self comparedFaceFromJSON:input[@"first"]]
                                                          second:[self comparedFaceFromJSON:input[@"second"]]
                                                           score:input[@"score"]
                                                      similarity:input[@"similarity"]
                                                           error:nil];
}

+(id)generateComparedFacesPair:(RFSMatchFacesComparedFacesPair*)input {
    NSMutableDictionary* result = @{
        @"first":[self generateComparedFace:input.first],
        @"second":[self generateComparedFace:input.second],
        @"error":[self generateError:input.error]
    }.mutableCopy;
    if (input.score) result[@"score"] = input.score;
    if (input.similarity) result[@"similarity"] = input.similarity;
    return result;
}

+(id)matchFacesResponseFromJSON:(NSDictionary*)input {
    RFSMatchFacesResponse* result = [RFSMatchFacesResponse alloc];
    SEL sel = NSSelectorFromString(@"initWithResults:detections:error:");
    IMP imp = [result methodForSelector:sel];
    void (*func)(id, SEL, id, id, id) = (void *)imp;
    func(result,
         sel,
         [self arrayFromJSON:input[@"results"] :@selector(comparedFacesPairFromJSON:)],
         [self arrayFromJSON:input[@"detections"] :@selector(matchFacesDetectionFromJSON:)],
         nil);
    [result setValue:input[@"tag"] forKey:@"tag"];
    return result;
}

+(id)generateMatchFacesResponse:(RFSMatchFacesResponse*)input {
    NSMutableDictionary* result = @{
        @"error":[self generateError:input.error],
        @"results":[self generateArray:input.results :@selector(generateComparedFacesPair:)],
        @"detections":[self generateArray:input.detections :@selector(generateMatchFacesDetection:)]
    }.mutableCopy;
    if (input.tag) result[@"tag"] = input.tag;
    return result;
}

+(id)generateComparedFacesSplit:(RFSMatchFacesSimilarityThresholdSplit*)input {
    return @{
        @"matchedFaces":[self generateArray:input.matchedFaces :@selector(generateComparedFacesPair:)],
        @"unmatchedFaces":[self generateArray:input.unmatchedFaces :@selector(generateComparedFacesPair:)],
    };
}

#pragma mark - DetectFaces

+(id)imageQualityRangeFromJSON:(NSDictionary*)input {
    if (!input || [input isEqual:[NSNull null]]) return nil;
    NSArray* array = @[input[@"min"], input[@"max"]];
    return [[RFSImageQualityRange alloc] performSelector:NSSelectorFromString(@"initWithRange:") withObject:array];
}

+(id)imageQualityRangeToArray:(RFSImageQualityRange*)input {
    if (!input || [input isEqual:[NSNull null]])  return nil;
    return @[input.min, input.max];
}

+(id)generateImageQualityRange:(RFSImageQualityRange*)input {
    if (!input) return [NSNull null];
    return @{
        @"min":input.min,
        @"max":input.max
    };
}

+(id)imageQualityCharacteristicFromJSON:(NSDictionary*)input {
    return [RFSWConfig imageQualityCharacteristicWithName:input[@"characteristicName"]
                                         recommendedRange:[self imageQualityRangeToArray:[self imageQualityRangeFromJSON:input[@"recommendedRange"]]]
                                              customRange:[self imageQualityRangeToArray:[self imageQualityRangeFromJSON:input[@"customRange"]]]
                                                    color:[self colorWithInt:input[@"color"]]];
}

+(id)generateImageQualityCharacteristic:(RFSImageQualityCharacteristic*)input {
    NSMutableDictionary* result =  @{
        @"characteristicName":input.name
    }.mutableCopy;
    if(input.recommendedRange) result[@"recommendedRange"] = [self generateImageQualityRange:input.recommendedRange];
    if(input.customRange) result[@"customRange"] = [self generateImageQualityRange:input.customRange];
    if ([input isKindOfClass:[RFSImageQualityColorCharacteristic class]])
        result[@"color"] = [self intWithColor:((RFSImageQualityColorCharacteristic*)input).color];
    
    return result;;
}

+(id)detectFacesConfigFromJSON:(NSDictionary*)input {
    if (!input || [input isEqual:[NSNull null]])  return nil;
    RFSDetectFacesConfiguration* result = [RFSDetectFacesConfiguration new];
    
    result.customQuality = [self arrayFromJSON:input[@"customQuality"] :@selector(imageQualityCharacteristicFromJSON:)];
    result.outputImageParams = [self outputImageParamsFromJSON:input[@"outputImageParams"]];
    if (input[@"onlyCentralFace"]) result.onlyCentralFace = [input[@"onlyCentralFace"] boolValue];
    result.attributes = input[@"attributes"];
    
    return result;
}

+(id)generateDetectFacesConfig:(RFSDetectFacesConfiguration*)input {
    NSMutableDictionary* result =  @{
        @"onlyCentralFace":@(input.onlyCentralFace),
    }.mutableCopy;
    if (input.customQuality) result[@"customQuality"] = [self generateArray:input.customQuality :@selector(generateImageQualityCharacteristic:)];
    if (input.outputImageParams) result[@"outputImageParams"] = [self generateOutputImageParams:input.outputImageParams];
    if (input.attributes) result[@"attributes"] = input.attributes;
    
    return result;;
}

+(id)detectFacesRequestFromJSON:(NSDictionary*)input {
    UIImage* image = [self imageWithBase64:input[@"image"]];
    if (input[@"scenario"] && ![input[@"scenario"] isEqual:[NSNull null]])
        return [[RFSDetectFacesRequest alloc] performSelector:NSSelectorFromString(@"initImage:scenario:") withObject:image withObject:input[@"scenario"]];
    RFSDetectFacesRequest* request = [[RFSDetectFacesRequest alloc] initWithImage:image configuration:[self detectFacesConfigFromJSON:input[@"configuration"]]];
    request.tag = input[@"tag"];
    return request;
}

+(id)generateDetectFacesRequest:(RFSDetectFacesRequest*)input {
    NSMutableDictionary* result =  @{
        @"image":[self base64WithImage:input.image],
    }.mutableCopy;
    if (input.tag) result[@"tag"] = input.tag;
    if (input.scenario) result[@"scenario"] = input.scenario;
    if (input.configuration) result[@"configuration"] = [self generateDetectFacesConfig:input.configuration];
    
    return result;;
}

+(id)imageQualityResultFromJSON:(NSDictionary*)input {
    RFSImageQualityResult* result = [RFSImageQualityResult alloc];
    SEL sel = NSSelectorFromString(@"initWithName:groupId:status:value:range:");
    IMP imp = [result methodForSelector:sel];
    void (*func)(id, SEL, id, NSInteger, NSInteger, id, id) = (void *)imp;
    func(result,
         sel,
         input[@"name"],
         [input[@"group"] integerValue],
         [input[@"status"] integerValue],
         input[@"value"],
         [self imageQualityRangeFromJSON:input[@"range"]]);
    return result;
}

+(id)generateImageQualityResult:(RFSImageQualityResult*)input {
    return @{
        @"name":input.name,
        @"group":@(input.group),
        @"status":@(input.status),
        @"range":[self generateImageQualityRange:input.range],
        @"value":input.value
    };
}

+(id)detectFacesAttributeResultFromJSON:(NSDictionary*)input {
    RFSDetectFacesAttributeResult* result = [RFSDetectFacesAttributeResult alloc];
    SEL sel = NSSelectorFromString(@"initWith:confidence:value:range:");
    IMP imp = [result methodForSelector:sel];
    void (*func)(id, SEL, id, id, id, id) = (void *)imp;
    func(result,
         sel,
         input[@"attribute"],
         input[@"confidence"],
         input[@"value"],
         [self imageQualityRangeToArray:[self imageQualityRangeFromJSON:input[@"range"]]]);
    return result;
}

+(id)generateDetectFacesAttributeResult:(RFSDetectFacesAttributeResult*)input {
    NSMutableDictionary* result = @{
        @"attribute":input.attribute,
        @"range":[self generateImageQualityRange:input.range],
    }.mutableCopy;
    if (input.value) result[@"value"] = input.value;
    if (input.confidence) result[@"confidence"] = input.confidence;
    return result;
}

+(id)detectFaceResultFromJSON:(NSDictionary*)input {
    RFSDetectFaceResult* result = [RFSDetectFaceResult alloc];
    SEL sel = NSSelectorFromString(@"initWithQuality:attributes:cropImageData:faceRect:landmarks:originalRect:");
    IMP imp = [result methodForSelector:sel];
    void (*func)(id, SEL, id, id, id, CGRect, id, CGRect) = (void *)imp;
    func(result,
         sel,
         [self arrayFromJSON:input[@"quality"] :@selector(imageQualityResultFromJSON:)],
         [self arrayFromJSON:input[@"attributes"] :@selector(detectFacesAttributeResultFromJSON:)],
         input[@"crop"],
         [self rectFromJSON:input[@"faceRect"]],
         [self arrayFromJSON:input[@"landmarks"] :@selector(pointFromJSON:)],
         [self rectFromJSON:input[@"originalRect"]]);
    return result;
}

+(id)generateDetectFaceResult:(RFSDetectFaceResult*)input {
    if (!input) return [NSNull null];
    return @{
        @"quality":[self generateArray:input.quality :@selector(generateImageQualityResult:)],
        @"attributes":[self generateArray:input.attributes :@selector(generateDetectFacesAttributeResult:)],
        @"landmarks":[self generateArray:input.landmarks :@selector(generatePoint:)],
        @"crop":[self base64WithImage:input.crop],
        @"faceRect":[self generateRect:input.faceRect],
        @"originalRect":[self generateRect:input.originalRect],
        @"isQualityCompliant":@(input.isQualityCompliant)
    };
}

+(id)detectFacesResponseFromJSON:(NSDictionary*)input {
    RFSDetectFacesResponse* result = [RFSDetectFacesResponse alloc];
    SEL sel = NSSelectorFromString(@"initWithDetections:scenario:error:");
    IMP imp = [result methodForSelector:sel];
    void (*func)(id, SEL, id, id, id) = (void *)imp;
    func(result,
         sel,
         [self arrayFromJSON:input[@"allDetections"] :@selector(detectFaceResultFromJSON:)],
         input[@"scenario"],
         nil);
    return result;
}

+(id)generateDetectFacesResponse:(RFSDetectFacesResponse*)input {
    NSMutableDictionary* result = @{
        @"detection":[self generateDetectFaceResult:input.detection],
        @"error":[self generateError:input.error],
        @"allDetections":[self generateArray:input.allDetections :@selector(generateDetectFaceResult:)]
    }.mutableCopy;
    if (input.scenario) result[@"scenario"] = input.scenario;
    return result;
}

#pragma mark - PersonDatabase

+(id)generatePersonDBResponse:(id)data :(NSError*)error {
    if (error) return @{ @"error": error.localizedDescription };
    else return @{ @"data": data };
}

+(NSDateFormatter*)dateFromatter {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    return dateFormatter;
}

+(id)dateFromJSON:(NSString*)input {
    return [self.dateFromatter dateFromString:input];
}

+(id)generateDate:(NSDate*)input {
    return [self.dateFromatter stringFromDate:input];
}

+(id)personFromJSON:(NSDictionary*)input {
    RFSPerson* result = [[RFSPerson alloc] performSelector:NSSelectorFromString(@"init")];
    [result setValue:input[@"id"] forKey:@"itemId"];
    [result setValue:input[@"metadata"] forKey:@"mutableMetadata"];
    [result setValue:[self dateFromJSON:input[@"createdAt"]] forKey:@"createdAt"];
    [result setValue:input[@"name"] forKey:@"name"];
    [result setValue:input[@"groups"] forKey:@"groups"];
    [result setValue:[self dateFromJSON:input[@"updatedAt"]] forKey:@"updatedAt"];
    return result;
}

+(id)generatePerson:(RFSPerson*)input {
    if (!input) return [NSNull null];
    NSMutableDictionary* result = @{
        @"updatedAt":[self generateDate:input.updatedAt],
        @"createdAt":[self generateDate:input.createdAt]
    }.mutableCopy;
    if (input.name) result[@"name"] = input.name;
    if (input.groups) result[@"groups"] = input.groups;
    if (input.itemId) result[@"id"] = input.itemId;
    if (input.metadata) result[@"metadata"] = input.metadata;
    return result;
}

+(id)idFromJSON:(NSDictionary*)input {
    return input[@"id"];
}

+(id)updatePersonFromJSON:(RFSPerson*)result :(NSDictionary*)json {
    if (json[@"name"] && ![json[@"name"] isEqual:[NSNull null]]) result.name = json[@"name"];
    if (json[@"metadata"] && ![json[@"metadata"] isEqual:[NSNull null]]) result.metadata = json[@"metadata"];
    return result;
}

+(id)urlFromJSON:(NSString*)input {
    if (!input || [input isEqual:[NSNull null]])  return nil;
    return [NSURL URLWithString:input];
}

+(id)generateUrl:(NSURL*)input {
    if (!input) return [NSNull null];
    return input.absoluteString;
}

+(id)personImageFromJSON:(NSDictionary*)input {
    RFSPersonImage* result = [[RFSPersonImage alloc] performSelector:NSSelectorFromString(@"init")];
    [result setValue:input[@"id"] forKey:@"itemId"];
    [result setValue:input[@"metadata"] forKey:@"metadata"];
    [result setValue:[self dateFromJSON:input[@"createdAt"]] forKey:@"createdAt"];
    [result setValue:[self urlFromJSON:input[@"url"]] forKey:@"url"];
    [result setValue:input[@"path"] forKey:@"path"];
    [result setValue:input[@"contentType"] forKey:@"contentType"];
    return result;
}

+(id)generatePersonImage:(RFSPersonImage*)input {
    if (!input) return [NSNull null];
    NSMutableDictionary* result = @{
        @"url":[self generateUrl:input.url],
        @"createdAt":[self generateDate:input.createdAt]
    }.mutableCopy;
    if (input.path) result[@"path"] = input.path;
    if (input.contentType) result[@"contentType"] = input.contentType;
    if (input.itemId) result[@"id"] = input.itemId;
    if (input.metadata) result[@"metadata"] = input.metadata;
    return result;
}

+(id)imageUploadFromJSON:(NSDictionary*)input {
    if (!input || [input isEqual:[NSNull null]])  return nil;
    if (input[@"imageUrl"] && ![input[@"imageUrl"] isEqual:[NSNull null]]) return [[RFSImageUpload alloc] initWithImageURL:[self urlFromJSON:input[@"imageUrl"]]];
    if (input[@"imageData"] && ![input[@"imageData"] isEqual:[NSNull null]]) return [[RFSImageUpload alloc] initWithImageData:[self base64Decode:input[@"imageData"]]];
    return nil;
}

+(id)generateImageUpload:(RFSImageUpload*)input {
    if (!input) return [NSNull null];
    NSMutableDictionary* result = @{}.mutableCopy;
    if (input.imageURL) result[@"imageUrl"] = [self generateUrl:input.imageURL];
    if (input.imageData) result[@"imageData"] = [self base64Encode:input.imageData];
    return result;
}

+(id)personGroupFromJSON:(NSDictionary*)input {
    RFSPersonGroup* result = [[RFSPersonGroup alloc] performSelector:NSSelectorFromString(@"init")];
    [result setValue:input[@"id"] forKey:@"itemId"];
    [result setValue:input[@"metadata"] forKey:@"mutableMetadata"];
    [result setValue:[self dateFromJSON:input[@"createdAt"]] forKey:@"createdAt"];
    [result setValue:input[@"name"] forKey:@"name"];
    return result;
}

+(id)generatePersonGroup:(RFSPersonGroup*)input {
    if (!input) return [NSNull null];
    NSMutableDictionary* result = @{
        @"createdAt":[self generateDate:input.createdAt]
    }.mutableCopy;
    if (input.name) result[@"name"] = input.name;
    if (input.itemId) result[@"id"] = input.itemId;
    if (input.metadata) result[@"metadata"] = input.metadata;
    return result;
}

+(id)updatePersonGroupFromJSON:(RFSPersonGroup*)result :(NSDictionary*)json {
    if (json[@"name"] && ![json[@"name"] isEqual:[NSNull null]]) result.name = json[@"name"];
    if (json[@"metadata"] && ![json[@"metadata"] isEqual:[NSNull null]]) result.metadata = json[@"metadata"];
    return result;
}

+(id)editGroupPersonsRequestFromJSON:(NSDictionary*)input {
    return [[RFSEditGroupPersonsRequest alloc] initWithPersonIdsToAdd:input[@"personIdsToAdd"]
                                                    personIdsToRemove:input[@"personIdsToRemove"]];
}

+(id)generateEditGroupPersonsRequest:(RFSEditGroupPersonsRequest*)input {
    if (!input) return [NSNull null];
    NSMutableDictionary* result = @{}.mutableCopy;
    if (input.personIdsToAdd) result[@"personIdsToAdd"] = input.personIdsToAdd;
    if (input.personIdsToRemove) result[@"personIdsToRemove"] = input.personIdsToRemove;
    return result;
}

+(id)searchPersonRequestFromJSON:(NSDictionary*)input {
    RFSSearchPersonRequest* result = [[RFSSearchPersonRequest alloc] initWithGroupIds:input[@"groupIdsForSearch"]
                                                                          imageUpload:[self imageUploadFromJSON:input[@"imageUpload"]]];
    result.threshold = input[@"threshold"];
    result.limit = input[@"limit"];
    if (input[@"detectAll"] && ![input[@"detectAll"] isEqual:[NSNull null]]) result.detectAll = input[@"detectAll"];
    result.outputImageParams = [self outputImageParamsFromJSON:input[@"outputImageParams"]];
    return result;
}

+(id)generateSearchPersonRequest:(RFSSearchPersonRequest*)input {
    if (!input) return [NSNull null];
    NSMutableDictionary* result = @{
        @"imageUpload": [self generateImageUpload:input.imageUpload],
        @"detectAll": @(input.detectAll)
    }.mutableCopy;
    if (input.threshold) result[@"threshold"] = input.threshold;
    if (input.limit) result[@"limit"] = input.limit;
    if (input.groupIdsForSearch) result[@"groupIdsForSearch"] = input.groupIdsForSearch;
    if (input.outputImageParams) result[@"outputImageParams"] = [self generateOutputImageParams:input.outputImageParams];
    return result;
}

+(id)searchPersonDetectionFromJSON:(NSDictionary*)input {
    RFSSearchPersonDetection* result = [RFSSearchPersonDetection alloc];
    SEL sel = NSSelectorFromString(@"initWithRoi:landmarks:crop:rotationAngle:");
    IMP imp = [result methodForSelector:sel];
    void (*func)(id, SEL, CGRect, id, id, id) = (void *)imp;
    func(result,
         sel,
         [self rectFromJSON:input[@"rect"]],
         [self arrayFromJSON:input[@"landmarks"] :@selector(pointFromJSON:)],
         [self imageWithBase64:input[@"crop"]],
         input[@"rotationAngle"]);
    return result;
}

+(id)generateSearchPersonDetection:(RFSSearchPersonDetection*)input {
    if (!input) return [NSNull null];
    NSMutableDictionary* result = @{
        @"landmarks":[self generateArray:input.landmarks :@selector(generatePoint:)],
        @"rect":[self generateRect:input.rect],
        @"crop":[self base64WithImage:input.crop],
    }.mutableCopy;
    if (input.rotationAngle) result[@"rotationAngle"] = input.rotationAngle;
    return result;
}

+(id)searchPersonImageFromJSON:(NSDictionary*)input {
    RFSSearchPersonImage* result = [[RFSSearchPersonImage alloc] performSelector:NSSelectorFromString(@"init")];
    [result setValue:input[@"id"] forKey:@"itemId"];
    [result setValue:input[@"metadata"] forKey:@"metadata"];
    [result setValue:[self dateFromJSON:input[@"createdAt"]] forKey:@"createdAt"];
    [result setValue:[self urlFromJSON:input[@"url"]] forKey:@"url"];
    [result setValue:input[@"path"] forKey:@"path"];
    [result setValue:input[@"contentType"] forKey:@"contentType"];
    [result setValue:input[@"similarity"] forKey:@"similarity"];
    [result setValue:input[@"distance"] forKey:@"distance"];
    return result;
}

+(id)generateSearchPersonImage:(RFSSearchPersonImage*)input {
    NSMutableDictionary* result = @{
        @"url":[self generateUrl:input.url],
        @"createdAt":[self generateDate:input.createdAt]
    }.mutableCopy;
    if (input.path) result[@"similarity"] = input.similarity;
    if (input.path) result[@"distance"] = input.distance;
    if (input.path) result[@"path"] = input.path;
    if (input.contentType) result[@"contentType"] = input.contentType;
    if (input.itemId) result[@"id"] = input.itemId;
    if (input.metadata) result[@"metadata"] = input.metadata;
    return result;
}

+(id)searchPersonFromJSON:(NSDictionary*)input {
    RFSSearchPerson* result = [[RFSSearchPerson alloc] performSelector:NSSelectorFromString(@"init")];
    [result setValue:input[@"id"] forKey:@"itemId"];
    [result setValue:input[@"metadata"] forKey:@"mutableMetadata"];
    [result setValue:[self dateFromJSON:input[@"createdAt"]] forKey:@"createdAt"];
    [result setValue:input[@"name"] forKey:@"name"];
    [result setValue:input[@"groups"] forKey:@"groups"];
    [result setValue:[self dateFromJSON:input[@"updatedAt"]] forKey:@"updatedAt"];
    [result setValue:[self arrayFromJSON:input[@"images"] :@selector(searchPersonImageFromJSON:)] forKey:@"images"];
    [result setValue:[self searchPersonDetectionFromJSON:input[@"detection"]] forKey:@"detection"];
    return result;
}

+(id)generateSearchPerson:(RFSSearchPerson*)input {
    if (!input) return [NSNull null];
    NSMutableDictionary* result = @{
        @"detection":[self generateSearchPersonDetection:input.detection],
        @"images":[self generateArray:input.images :@selector(generateSearchPersonImage:)],
        @"updatedAt":[self generateDate:input.updatedAt],
        @"createdAt":[self generateDate:input.createdAt]
    }.mutableCopy;
    if (input.name) result[@"name"] = input.name;
    if (input.groups) result[@"groups"] = input.groups;
    if (input.itemId) result[@"id"] = input.itemId;
    if (input.metadata) result[@"metadata"] = input.metadata;
    return result;
}

@end
