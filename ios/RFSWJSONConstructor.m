#import "RFSWJSONConstructor.h"
@import FaceSDK.Private;

@implementation RFSWJSONConstructor

+(NSString*)dictToString:(NSMutableDictionary*)input {
    if(input == nil) return nil;
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:input options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
}

+(NSString*)arrayToString:(NSMutableArray*)input {
    if(input == nil) return nil;
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:input options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
}

+(NSData*)base64Decode:(NSString*)input {
    if(input == nil) return nil;
    return [[NSData alloc] initWithBase64EncodedString:input options:0];
}

+(NSMutableDictionary* _Nonnull)generateNSError:(NSError* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"errorCode"] = [NSString stringWithFormat:@"%ld",(long)input.code];
    result[@"message"] = input.localizedDescription;

    return result;
}

+(NSString* _Nonnull)generateNSDate:(NSDate*)input {
    return [NSDateFormatter localizedStringFromDate:[NSDate date]
                                          dateStyle:NSDateFormatterShortStyle
                                          timeStyle:NSDateFormatterFullStyle];
}

+(NSURL* _Nonnull)NSURLFromJSON:(NSString*)input {
    if (input == nil) return nil;
    return [NSURL URLWithString:input];
}

+(NSString* _Nonnull)generateNSURL:(NSURL*)input {
    if (input == nil) return nil;
    return input.absoluteString;
}

+(RFSRecordingProcess)RFSRecordingProcessWithString:(NSString*)value {
    if([value  isEqual: @"ASYNCHRONOUS_UPLOAD"])
        return RFSRecordingProcessAsynchronousUpload;
    else if([value  isEqual: @"SYNCHRONOUS_UPLOAD"])
        return RFSRecordingProcessSynchronousUpload;
    else if([value  isEqual: @"NOT_UPLOAD"])
        return RFSRecordingProcessNotUpload;
    else
        return RFSRecordingProcessNotUpload;
}

+(RFSLivenessType)RFSLivenessTypeWithString:(NSString*)value {
    if([value  isEqual: @"ACTIVE"])
        return RFSLivenessTypeActive;
    else if([value  isEqual: @"PASSIVE"])
        return RFSLivenessTypePassive;
    else
        return RFSLivenessTypeActive;
}

+(NSString*)generateRFSDetectFacesAttribute:(RFSDetectFacesAttribute)value {
    if(value == RFSDetectFacesAttributeAge)
        return @"Age";
    else if(value == RFSDetectFacesAttributeEyeLeft)
        return @"EyeLeft";
    else if(value == RFSDetectFacesAttributeEyeRight)
        return @"EyeRight";
    else if(value == RFSDetectFacesAttributeEmotion)
        return @"Emotion";
    else if(value == RFSDetectFacesAttributeSmile)
        return @"Smile";
    else if(value == RFSDetectFacesAttributeGlasses)
        return @"Glasses";
    else if(value == RFSDetectFacesAttributeHeadCovering)
        return @"HeadCovering";
    else if(value == RFSDetectFacesAttributeForeheadCovering)
        return @"ForeheadCovering";
    else if(value == RFSDetectFacesAttributeMouth)
        return @"Mouth";
    else if(value == RFSDetectFacesAttributeMedicalMask)
        return @"MedicalMask";
    else if(value == RFSDetectFacesAttributeOcclusion)
        return @"Occlusion";
    else if(value == RFSDetectFacesAttributeStrongMakeup)
        return @"StrongMakeup";
    else if(value == RFSDetectFacesAttributeHeadphones)
        return @"Headphones";
    else
        return @"";
}

+(NSString*)generateRFSLivenessStatus:(RFSLivenessStatus)value {
    if(value == RFSLivenessStatusPassed)
        return @"PASSED";
    else if(value == RFSLivenessStatusUnknown)
        return @"UNKNOWN";
    else
        return @"UNKNOWN";
}

+(NSString*)generateRFSImageQualityCharacteristicName:(RFSImageQualityCharacteristicName)value {
    if(value == RFSImageQualityCharacteristicNameImageWidth)
        return @"ImageWidth";
    else if(value == RFSImageQualityCharacteristicNameImageHeight)
        return @"ImageHeight";
    else if(value == RFSImageQualityCharacteristicNameImageWidthToHeight)
        return @"ImageWidthToHeight";
    else if(value == RFSImageQualityCharacteristicNameImageChannelsNumber)
        return @"ImageChannelsNumber";
    else if(value == RFSImageQualityCharacteristicNamePaddingRatio)
        return @"PaddingRatio";
    else if(value == RFSImageQualityCharacteristicNameFaceMidPointHorizontalPosition)
        return @"FaceMidPointHorizontalPosition";
    else if(value == RFSImageQualityCharacteristicNameFaceMidPointVerticalPosition)
        return @"FaceMidPointVerticalPosition";
    else if(value == RFSImageQualityCharacteristicNameHeadWidthRatio)
        return @"HeadWidthRatio";
    else if(value == RFSImageQualityCharacteristicNameHeadHeightRatio)
        return @"HeadHeightRatio";
    else if(value == RFSImageQualityCharacteristicNameEyesDistance)
        return @"EyesDistance";
    else if(value == RFSImageQualityCharacteristicNameYaw)
        return @"Yaw";
    else if(value == RFSImageQualityCharacteristicNamePitch)
        return @"Pitch";
    else if(value == RFSImageQualityCharacteristicNameRoll)
        return @"Roll";
    else if(value == RFSImageQualityCharacteristicNameBlurLevel)
        return @"BlurLevel";
    else if(value == RFSImageQualityCharacteristicNameNoiseLevel)
        return @"NoiseLevel";
    else if(value == RFSImageQualityCharacteristicNameUnnaturalSkinTone)
        return @"UnnaturalSkinTone";
    else if(value == RFSImageQualityCharacteristicNameFaceDynamicRange)
        return @"FaceDynamicRange";
    else if(value == RFSImageQualityCharacteristicNameEyeRightClosed)
        return @"EyeRightClosed";
    else if(value == RFSImageQualityCharacteristicNameEyeLeftClosed)
        return @"EyeLeftClosed";
    else if(value == RFSImageQualityCharacteristicNameEyeRightOccluded)
        return @"EyeRightOccluded";
    else if(value == RFSImageQualityCharacteristicNameEyeLeftOccluded)
        return @"EyeLeftOccluded";
    else if(value == RFSImageQualityCharacteristicNameEyesRed)
        return @"EyesRed";
    else if(value == RFSImageQualityCharacteristicNameEyeRightCoveredWithHair)
        return @"EyeRightCoveredWithHair";
    else if(value == RFSImageQualityCharacteristicNameEyeLeftCoveredWithHair)
        return @"EyeLeftCoveredWithHair";
    else if(value == RFSImageQualityCharacteristicNameOffGaze)
        return @"OffGaze";
    else if(value == RFSImageQualityCharacteristicNameTooDark)
        return @"TooDark";
    else if(value == RFSImageQualityCharacteristicNameTooLight)
        return @"TooLight";
    else if(value == RFSImageQualityCharacteristicNameFaceGlare)
        return @"FaceGlare";
    else if(value == RFSImageQualityCharacteristicNameShadowsOnFace)
        return @"ShadowsOnFace";
    else if(value == RFSImageQualityCharacteristicNameShouldersPose)
        return @"ShouldersPose";
    else if(value == RFSImageQualityCharacteristicNameExpressionLevel)
        return @"ExpressionLevel";
    else if(value == RFSImageQualityCharacteristicNameMouthOpen)
        return @"MouthOpen";
    else if(value == RFSImageQualityCharacteristicNameSmile)
        return @"Smile";
    else if(value == RFSImageQualityCharacteristicNameDarkGlasses)
        return @"DarkGlasses";
    else if(value == RFSImageQualityCharacteristicNameReflectionOnGlasses)
        return @"ReflectionOnGlasses";
    else if(value == RFSImageQualityCharacteristicNameFramesTooHeavy)
        return @"FramesTooHeavy";
    else if(value == RFSImageQualityCharacteristicNameFaceOccluded)
        return @"FaceOccluded";
    else if(value == RFSImageQualityCharacteristicNameHeadCovering)
        return @"HeadCovering";
    else if(value == RFSImageQualityCharacteristicNameForeheadCovering)
        return @"ForeheadCovering";
    else if(value == RFSImageQualityCharacteristicNameStrongMakeup)
        return @"StrongMakeup";
    else if(value == RFSImageQualityCharacteristicNameHeadphones)
        return @"Headphones";
    else if(value == RFSImageQualityCharacteristicNameMedicalMask)
        return @"MedicalMask";
    else if(value == RFSImageQualityCharacteristicNameBackgroundUniformity)
        return @"BackgroundUniformity";
    else if(value == RFSImageQualityCharacteristicNameShadowsOnBackground)
        return @"ShadowsOnBackground";
    else if(value == RFSImageQualityCharacteristicNameOtherFaces)
        return @"OtherFaces";
    else if(value == RFSImageQualityCharacteristicNameBackgroundColorMatch)
        return @"BackgroundColorMatch";
    else if(value == RFSImageQualityCharacteristicNameArtFace)
        return @"ArtFace";
    else
        return @"Unknown";
}

+(NSNumber*)generateRFSImageQualityGroup:(RFSImageQualityGroup)value {
    if(value == RFSImageQualityGroupImageСharacteristics)
        return @1;
    else if(value == RFSImageQualityGroupHeadSizeAndPosition)
        return @2;
    else if(value == RFSImageQualityGroupFaceQuality)
        return @3;
    else if(value == RFSImageQualityGroupEyesCharacteristics)
        return @4;
    else if(value == RFSImageQualityGroupShadowsAndLightning)
        return @5;
    else if(value == RFSImageQualityGroupPoseAndExpression)
        return @6;
    else if(value == RFSImageQualityGroupHeadOcclusion)
        return @7;
    else if(value == RFSImageQualityGroupBackground)
        return @8;
    else
        return @9;
}

+(NSNumber*)generateRFSImageQualityResultStatus:(RFSImageQualityResultStatus)value {
    if(value == RFSImageQualityResultStatusFalse)
        return @1;
    else if(value == RFSImageQualityResultStatusTrue)
        return @2;
    else if(value == RFSImageQualityResultStatusUndetermined)
        return @3;
    else
        return @3;
}

+(NSNumber*)generateRFSImageType:(RFSImageType)value {
    if(value == RFSImageTypePrinted)
        return @1;
    else if(value == RFSImageTypeRFID)
        return @2;
    else if(value == RFSImageTypeLive)
        return @3;
    else if(value == RFSImageTypeDocumentWithLive)
        return @4;
    else if(value == RFSImageTypeExternal)
        return @5;
    else
        return @0;
}

+(NSMutableDictionary* _Nonnull)generateInitCompletion:(BOOL)success :(NSError* _Nullable)error {
    NSMutableDictionary *result = [NSMutableDictionary new];

    result[@"success"] = success ? @YES : @NO;
    result[@"error"] = [self generateNSError:error];

    return result;
}

+(NSString*)generateRFSLivenessProcessStatus:(RFSLivenessProcessStatus)value {
    if(value == RFSLivenessProcessStatusStart)
        return @"START";
    else if(value == RFSLivenessProcessStatusPreparing)
        return @"PREPARING";
    else if(value == RFSLivenessProcessStatusNewSession)
        return @"NEW_SESSION";
    else if(value == RFSLivenessProcessStatusProgress)
        return @"PROGRESS";
    else if(value == RFSLivenessProcessStatusNextStage)
        return @"NEXT_STAGE";
    else if(value == RFSLivenessProcessStatusSectorChanged)
        return @"SECTOR_CHANGED";
    else if(value == RFSLivenessProcessStatusProcessing)
        return @"PROCESSING";
    else if(value == RFSLivenessProcessStatusLowBrightness)
        return @"LOW_BRIGHTNESS";
    else if(value == RFSLivenessProcessStatusFitFace)
        return @"FIT_FACE";
    else if(value == RFSLivenessProcessStatusMoveAway)
        return @"MOVE_AWAY";
    else if(value == RFSLivenessProcessStatusMoveCloser)
        return @"MOVE_CLOSER";
    else if(value == RFSLivenessProcessStatusTurnHead)
        return @"TURN_HEAD";
    else if(value == RFSLivenessProcessStatusFailed)
        return @"FAILED";
    else if(value == RFSLivenessProcessStatusRetry)
        return @"RETRY";
    else if(value == RFSLivenessProcessStatusSuccess)
        return @"SUCCESS";
    else
        return @"";
}

+(NSMutableDictionary* _Nonnull)generateLivenessNotification:(RFSLivenessProcessStatus)status result:(RFSLivenessResponse*)response {
    NSMutableDictionary *result = [NSMutableDictionary new];

    result[@"status"] = [self generateRFSLivenessProcessStatus: status];
    result[@"result"] = [self generateRFSLivenessResponse:response];

    return result;
}

+(NSMutableDictionary*)generateVideoEncoderCompletion:(NSString * _Nonnull)transactionId :(BOOL)success {
    NSMutableDictionary* result = [NSMutableDictionary new];

    result[@"transactionId"] = transactionId;
    result[@"success"] = success ? @YES : @NO;

    return result;
}

// From JSON

+(RFSInitializationConfiguration*)RFSInitializationConfigurationFromJSON:(NSDictionary*)input {
    return [RFSInitializationConfiguration configurationWithBuilder:^(RFSInitializationConfigurationBuilder * _Nonnull builder) {
        [builder setLicenseData:[self base64Decode:[input valueForKey:@"license"]]];
        if([input valueForKey:@"licenseUpdate"] != nil)
            [builder setLicenseUpdate:[[input valueForKey:@"licenseUpdate"] boolValue]];
    }];
}

+(RFSMatchFacesRequest*)RFSMatchFacesRequestFromJSON:(NSDictionary*)input {
    RFSMatchFacesRequest* result = [[RFSMatchFacesRequest alloc] initWithImages:[self NSArrayRFSMatchFacesImageFromJSON:[input valueForKey:@"images"]]];

    if([input valueForKey:@"outputImageParams"] != nil)
        result.outputImageParams = [RFSWJSONConstructor RFSOutputImageParamsFromJSON:[input valueForKey:@"outputImageParams"]];
    if([input valueForKey:@"metadata"] != nil)
        result.metadata = [NSJSONSerialization JSONObjectWithData: [[[input valueForKey:@"metadata"] stringValue] dataUsingEncoding:NSUTF8StringEncoding] options: 0 error: nil];

    return result;
}

+(RFSDetectFacesRequest*)RFSDetectFacesRequestFromJSON:(NSDictionary*)input {
    NSString* CROP_CENTRAL_FACE = @"CropCentralFace";
    NSString* CROP_ALL_FACES = @"CropAllFaces";
    NSString* THUMBNAIL = @"Thumbnail";
    NSString* ATTRIBUTES_ALL = @"AttributesAll";
    NSString* QUALITY_FULL = @"QualityFull";
    NSString* QUALITY_ICAO = @"QualityICAO";
    NSString* QUALITY_VISA_SCHENGEN = @"QualityVisaSchengen";
    NSString* QUALITY_VISA_USA = @"QualityVisaUSA";

    UIImage* image = [self UIImageFromJSON:[input valueForKey:@"image"]];

    if([input valueForKey:@"scenario"] != nil){
        NSString* scenario = [input valueForKey:@"scenario"];

        if([scenario isEqualToString:CROP_CENTRAL_FACE])
            return [RFSDetectFacesRequest cropCentralFaceRequestForImage:image];
        else if([scenario isEqualToString:CROP_ALL_FACES])
            return [RFSDetectFacesRequest cropAllFacesRequestForImage:image];
        else if([scenario isEqualToString:THUMBNAIL])
            return [RFSDetectFacesRequest thumbnailRequestForImage:image];
        else if([scenario isEqualToString:ATTRIBUTES_ALL])
            return [RFSDetectFacesRequest allAttributesRequestForImage:image];
        else if([scenario isEqualToString:QUALITY_FULL])
            return [RFSDetectFacesRequest qualityFullRequestForImage:image];
        else if([scenario isEqualToString:QUALITY_ICAO])
            return [RFSDetectFacesRequest qualityICAORequestForImage:image];
        else if([scenario isEqualToString:QUALITY_VISA_SCHENGEN])
            return [RFSDetectFacesRequest qualityVisaSchengenRequestForImage:image];
        else if([scenario isEqualToString:QUALITY_VISA_USA])
            return [RFSDetectFacesRequest qualityVisaUSARequestForImage:image];
    }

    RFSDetectFacesConfiguration* configuration = [self RFSDetectFacesConfigurationFromJSON: [input objectForKey:@"configuration"]];

    RFSDetectFacesRequest* request = [[RFSDetectFacesRequest alloc] initWithImage:image configuration:configuration];
    if([input valueForKey:@"tag"] != nil)
        request.tag = [input valueForKey:@"tag"];;

    return request;
}

+(RFSDetectFacesConfiguration*)RFSDetectFacesConfigurationFromJSON:(NSDictionary*)input {
    RFSDetectFacesConfiguration* result = [RFSDetectFacesConfiguration new];

    if([input valueForKey:@"attributes"] != nil){
        NSMutableArray<RFSDetectFacesAttribute>* attributes = [[NSMutableArray alloc] init];
        for(NSString* item in [input valueForKey:@"attributes"])
            [attributes addObject:item];
        result.attributes = attributes;
    }
    if([input valueForKey:@"onlyCentralFace"] != nil){
        result.onlyCentralFace = [input valueForKey:@"onlyCentralFace"];
    }
    if([input valueForKey:@"customQuality"] != nil){
        NSMutableArray<RFSImageQualityCharacteristic*>* customQuality = [[NSMutableArray alloc] init];
        for(NSDictionary* item in [input objectForKey:@"customQuality"])
            [customQuality addObjectsFromArray:[self RFSImageQualityCharacteristicFromJSON:item]];
        result.customQuality = customQuality;
    }
    if([input valueForKey:@"outputImageParams"] != nil){
        result.outputImageParams = [self RFSOutputImageParamsFromJSON:[input valueForKey:@"outputImageParams"]];
    }

    return result;
}

+(RFSOutputImageParams*)RFSOutputImageParamsFromJSON:(NSDictionary*)input {
    RFSOutputImageParams* result = [RFSOutputImageParams new];

    if([input valueForKey:@"backgroundColor"] != nil){
        result.backgroundColor = [self colorWithString:[input valueForKey:@"backgroundColor"]];
    }
    if([input valueForKey:@"crop"] != nil){
        result.crop = [self RFSOutputImageCropFromJSON:[input valueForKey:@"crop"]];
    }

    return result;
}

+(RFSOutputImageCrop*)RFSOutputImageCropFromJSON:(NSDictionary*)input {
    RFSOutputImageCropAspectRatio type = RFSOutputImageCropAspectRatio3x4;
    if([input valueForKey:@"type"] != nil){
        type = [[input valueForKey:@"type"] integerValue];
    } else return nil;
    CGSize size = CGSizeMake(0, 0);
    if([input valueForKey:@"size"] != nil){
        size = [self CGSizeFromJSON:[input objectForKey:@"size"]];
    } else return [[RFSOutputImageCrop alloc] initWithType:type];
    UIColor* padColor = nil;
    if([input valueForKey:@"padColor"] != nil){
        padColor = [self colorWithString:[input valueForKey:@"padColor"]];
    }
    BOOL returnOriginalRect = FALSE;
    if([input valueForKey:@"returnOriginalRect"] != nil){
        returnOriginalRect = [[input valueForKey:@"returnOriginalRect"] boolValue];
    } else return [[RFSOutputImageCrop alloc] initWithType:type size:size];

    return [[RFSOutputImageCrop alloc] initWithType:type size:size padColor:padColor returnOriginalRect:returnOriginalRect];
}

+(CGSize)CGSizeFromJSON:(NSDictionary*)input {
    CGFloat width = 0;
    CGFloat height = 0;
    if([input valueForKey:@"width"] != nil){
        width = [[input valueForKey:@"width"] doubleValue];
    }
    if([input valueForKey:@"height"] != nil){
        height = [[input valueForKey:@"height"] doubleValue];
    }

    return CGSizeMake(width, height);
}

+(UIColor*)colorWithInt:(NSNumber*)hexInt {
    return [self colorWithString:[self hexStringWithInt:[hexInt integerValue]]];
}

+(NSString*)hexStringWithInt:(NSInteger)input {
    NSString* numbers = @"0123456789ABCDEF";
    NSString* result = @"";
    while(input>0){
        int digit = input % 16;
        result = [NSString stringWithFormat:@"%@%@", [numbers substringWithRange:NSMakeRange(digit, 1)], result];
        input = input/16;
    }
    // If we use int, then all the staring zeros are lost: 0x0F123456 == 0xF123456
    if(result.length == 5 || result.length == 7)
        result = [NSString stringWithFormat:@"0%@", result];
    return [NSString stringWithFormat:@"#%@", result];
}

+(UIColor*)colorWithString:(NSString*) hexString {
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
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+(UIFont*)UIFontFromJSON:(NSDictionary*)input {
    return [UIFont fontWithName:[input valueForKey:@"name"] size:[[input valueForKey:@"size"] integerValue]];
}

+(CGFloat)colorComponentFrom:(NSString*)string start:(NSUInteger)start length:(NSUInteger)length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

+(NSArray<RFSImageQualityCharacteristic *> *)RFSImageQualityCharacteristicFromJSON:(NSDictionary*)input {
    RFSImageQualityCharacteristic* result = [RFSImageCharacteristics paddingRatioWithMinValue:@0 maxValue:@0.5];

    NSMutableArray<NSNumber*>* range = [NSMutableArray new];
    NSNumber* min = @0;
    NSNumber* max = @1;
    if([input valueForKey:@"range"] != nil) {
        NSObject* temp = [input valueForKey:@"range"];
        if([temp valueForKey:@"min"] != nil){
            min = [temp valueForKey:@"min"];
            [range addObject:min];
        }
        if([temp valueForKey:@"max"] != nil){
            max = [temp valueForKey:@"max"];
            [range addObject:max];
        }
    }

    if([input valueForKey:@"characteristicName"] == nil) return nil;
    NSString* name = [input valueForKey:@"characteristicName"];

    if([name isEqualToString:@"ImageWidth"]){
        if([input valueForKey:@"range"] != nil)
            result = [RFSImageCharacteristics imageWidthWithRange:range];
        else return nil;
    } else if([name isEqualToString:@"ImageHeight"]){
        if([input valueForKey:@"range"] != nil)
            result = [RFSImageCharacteristics imageHeightWithRange:range];
        else return nil;
    } else if([name isEqualToString:@"ImageWidthToHeight"]){
        if([input valueForKey:@"range"] != nil)
            result = [RFSImageCharacteristics imageWidthToHeightWithRange:range];
        else return nil;
    } else if([name isEqualToString:@"ImageChannelsNumber"]){
        if([input valueForKey:@"imageChannelsNumber"] != nil)
            result = [RFSImageCharacteristics imageChannelsNumberWithValue:[input valueForKey:@"imageChannelsNumber"]];
        else return nil;
    } else if([name isEqualToString:@"PaddingRatio"])
        result = [RFSImageCharacteristics paddingRatioWithMinValue:min maxValue:max];
    else if([name isEqualToString:@"ArtFace"])
        result = RFSImageCharacteristics.artFace;
    else if([name isEqualToString:@"ImageCharacteristic"])
        return RFSImageCharacteristics.allRecommended;

    else if([name isEqualToString:@"FaceMidPointHorizontalPosition"])
        result = RFSHeadSizeAndPosition.faceMidPointHorizontalPosition;
    else if([name isEqualToString:@"FaceMidPointVerticalPosition"])
        result = RFSHeadSizeAndPosition.faceMidPointVerticalPosition;
    else if([name isEqualToString:@"HeadWidthRatio"])
        result = RFSHeadSizeAndPosition.headWidthRatio;
    else if([name isEqualToString:@"HeadHeightRatio"])
        result = RFSHeadSizeAndPosition.headHeightRatio;
    else if([name isEqualToString:@"EyesDistance"])
        result = RFSHeadSizeAndPosition.eyesDistance;
    else if([name isEqualToString:@"Yaw"])
        result = RFSHeadSizeAndPosition.yaw;
    else if([name isEqualToString:@"Pitch"])
        result = RFSHeadSizeAndPosition.pitch;
    else if([name isEqualToString:@"Roll"])
        result = RFSHeadSizeAndPosition.roll;
    else if([name isEqualToString:@"HeadSizeAndPosition"])
        return RFSHeadSizeAndPosition.allRecommended;

    else if([name isEqualToString:@"BlurLevel"])
        result = RFSFaceImageQuality.blurLevel;
    else if([name isEqualToString:@"NoiseLevel"])
        result = RFSFaceImageQuality.noiseLevel;
    else if([name isEqualToString:@"UnnaturalSkinTone"])
        result = RFSFaceImageQuality.unnaturalSkinTone;
    else if([name isEqualToString:@"FaceDynamicRange"])
        result = RFSFaceImageQuality.faceDynamicRange;
    else if([name isEqualToString:@"FaceImageQuality"])
        return RFSFaceImageQuality.allRecommended;

    else if([name isEqualToString:@"EyeRightClosed"])
        result = RFSEyesCharacteristics.eyeRightClosed;
    else if([name isEqualToString:@"EyeLeftClosed"])
        result = RFSEyesCharacteristics.eyeLeftClosed;
    else if([name isEqualToString:@"EyeRightOccluded"])
        result = RFSEyesCharacteristics.eyeRightOccluded;
    else if([name isEqualToString:@"EyeLeftOccluded"])
        result = RFSEyesCharacteristics.eyeLeftOccluded;
    else if([name isEqualToString:@"EyesRed"])
        result = RFSEyesCharacteristics.eyesRed;
    else if([name isEqualToString:@"EyeRightCoveredWithHair"])
        result = RFSEyesCharacteristics.eyeRightCoveredWithHair;
    else if([name isEqualToString:@"EyeLeftCoveredWithHair"])
        result = RFSEyesCharacteristics.eyeLeftCoveredWithHair;
    else if([name isEqualToString:@"OffGaze"])
        result = RFSEyesCharacteristics.offGaze;
    else if([name isEqualToString:@"EyesCharacteristics"])
        return RFSEyesCharacteristics.allRecommended;

    else if([name isEqualToString:@"TooDark"])
        result = RFSShadowsAndLightning.tooDark;
    else if([name isEqualToString:@"TooLight"])
        result = RFSShadowsAndLightning.tooLight;
    else if([name isEqualToString:@"FaceGlare"])
        result = RFSShadowsAndLightning.faceGlare;
    else if([name isEqualToString:@"ShadowsOnFace"])
        result = RFSShadowsAndLightning.shadowsOnFace;
    else if([name isEqualToString:@"ShadowsAndLightning"])
        return RFSShadowsAndLightning.allRecommended;

    else if([name isEqualToString:@"ShouldersPose"])
        result = RFSPoseAndExpression.shouldersPose;
    else if([name isEqualToString:@"ExpressionLevel"])
        result = RFSPoseAndExpression.expressionLevel;
    else if([name isEqualToString:@"MouthOpen"])
        result = RFSPoseAndExpression.mouthOpen;
    else if([name isEqualToString:@"Smile"])
        result = RFSPoseAndExpression.smile;
    else if([name isEqualToString:@"PoseAndExpression"])
        return RFSPoseAndExpression.allRecommended;

    else if([name isEqualToString:@"DarkGlasses"])
        result = RFSHeadOcclusion.darkGlasses;
    else if([name isEqualToString:@"ReflectionOnGlasses"])
        result = RFSHeadOcclusion.reflectionOnGlasses;
    else if([name isEqualToString:@"FramesTooHeavy"])
        result = RFSHeadOcclusion.framesTooHeavy;
    else if([name isEqualToString:@"FaceOccluded"])
        result = RFSHeadOcclusion.faceOccluded;
    else if([name isEqualToString:@"HeadCovering"])
        result = RFSHeadOcclusion.headCovering;
    else if([name isEqualToString:@"ForeheadCovering"])
        result = RFSHeadOcclusion.foreheadCovering;
    else if([name isEqualToString:@"StrongMakeup"])
        result = RFSHeadOcclusion.strongMakeup;
    else if([name isEqualToString:@"Headphones"])
        result = RFSHeadOcclusion.headphones;
    else if([name isEqualToString:@"MedicalMask"])
        result = RFSHeadOcclusion.medicalMask;
    else if([name isEqualToString:@"HeadOcclusion"])
        return RFSHeadOcclusion.allRecommended;

    else if([name isEqualToString:@"BackgroundUniformity"])
        result = RFSQualityBackground.backgroundUniformity;
    else if([name isEqualToString:@"ShadowsOnBackground"])
        result = RFSQualityBackground.shadowsOnBackground;
    else if([name isEqualToString:@"OtherFaces"])
        result = RFSQualityBackground.otherFaces;
    else if([name isEqualToString:@"BackgroundColorMatch"]){
        if([input valueForKey:@"color"] != nil)
            result = [RFSQualityBackground backgroundColorMatchWithColor:[self colorWithString:[input valueForKey:@"color"]]];
        else
            result = RFSQualityBackground.backgroundColorMatch;
    } else if([name isEqualToString:@"QualityBackground"])
        return RFSQualityBackground.allRecommended;

    NSMutableArray<RFSImageQualityCharacteristic*>* resultArray = [NSMutableArray new];
    if([input valueForKey:@"customRange"] != nil) {
        NSObject* customRange = [input valueForKey:@"customRange"];
        if([customRange valueForKey:@"min"] != nil)
            [range addObject:[customRange valueForKey:@"min"]];
        if([customRange valueForKey:@"max"] != nil)
            [range addObject:[customRange valueForKey:@"max"]];

        [resultArray addObject:[result withCustomRange:range]];
        return resultArray;
    }
    [resultArray addObject:result];
    return resultArray;
}

+(RFSUIConfiguration*)RFSUIConfigurationFromJSON:(NSDictionary*)input {
    return [RFSUIConfiguration configurationWithBuilderBlock:^(RFSUIConfigurationBuilder * _Nonnull builder) {
        for(NSString* key in input){
            if([key isEqual: @"CustomizationColor.ONBOARDING_SCREEN_START_BUTTON_BACKGROUND"])
                [builder setColor:[self colorWithInt:[input valueForKey:key]] forItem:OnboardingScreenStartButtonBackground];
            if([key isEqual: @"CustomizationColor.ONBOARDING_SCREEN_START_BUTTON_TITLE"])
                [builder setColor:[self colorWithInt:[input valueForKey:key]] forItem:OnboardingScreenStartButtonTitle];
            if([key isEqual: @"CustomizationColor.ONBOARDING_SCREEN_BACKGROUND"])
                [builder setColor:[self colorWithInt:[input valueForKey:key]] forItem:OnboardingScreenBackground];
            if([key isEqual: @"CustomizationColor.ONBOARDING_SCREEN_TITLE_LABEL_TEXT"])
                [builder setColor:[self colorWithInt:[input valueForKey:key]] forItem:OnboardingScreenTitleLabelText];
            if([key isEqual: @"CustomizationColor.ONBOARDING_SCREEN_MESSAGE_LABEL_TEXT"])
                [builder setColor:[self colorWithInt:[input valueForKey:key]] forItem:OnboardingScreenMessageLabelsText];
            if([key isEqual: @"CustomizationColor.CAMERA_SCREEN_STROKE_NORMAL"])
                [builder setColor:[self colorWithInt:[input valueForKey:key]] forItem:CameraScreenStrokeNormal];
            if([key isEqual: @"CustomizationColor.CAMERA_SCREEN_STROKE_ACTIVE"])
                [builder setColor:[self colorWithInt:[input valueForKey:key]] forItem:CameraScreenStrokeActive];
            if([key isEqual: @"CustomizationColor.CAMERA_SCREEN_SECTOR_TARGET"])
                [builder setColor:[self colorWithInt:[input valueForKey:key]] forItem:CameraScreenSectorTarget];
            if([key isEqual: @"CustomizationColor.CAMERA_SCREEN_SECTOR_ACTIVE"])
                [builder setColor:[self colorWithInt:[input valueForKey:key]] forItem:CameraScreenSectorActive];
            if([key isEqual: @"CustomizationColor.CAMERA_SCREEN_FRONT_HINT_LABEL_BACKGROUND"])
                [builder setColor:[self colorWithInt:[input valueForKey:key]] forItem:CameraScreenFrontHintLabelBackground];
            if([key isEqual: @"CustomizationColor.CAMERA_SCREEN_FRONT_HINT_LABEL_TEXT"])
                [builder setColor:[self colorWithInt:[input valueForKey:key]] forItem:CameraScreenFrontHintLabelText];
            if([key isEqual: @"CustomizationColor.CAMERA_SCREEN_BACK_HINT_LABEL_BACKGROUND"])
                [builder setColor:[self colorWithInt:[input valueForKey:key]] forItem:CameraScreenBackHintLabelBackground];
            if([key isEqual: @"CustomizationColor.CAMERA_SCREEN_BACK_HINT_LABEL_TEXT"])
                [builder setColor:[self colorWithInt:[input valueForKey:key]] forItem:CameraScreenBackHintLabelText];
            if([key isEqual: @"CustomizationColor.CAMERA_SCREEN_LIGHT_TOOLBAR_TINT"])
                [builder setColor:[self colorWithInt:[input valueForKey:key]] forItem:CameraScreenLightToolbarTint];
            if([key isEqual: @"CustomizationColor.CAMERA_SCREEN_DARK_TOOLBAR_TINT"])
                [builder setColor:[self colorWithInt:[input valueForKey:key]] forItem:CameraScreenDarkToolbarTint];
            if([key isEqual: @"CustomizationColor.RETRY_SCREEN_BACKGROUND"])
                [builder setColor:[self colorWithInt:[input valueForKey:key]] forItem:RetryScreenBackground];
            if([key isEqual: @"CustomizationColor.RETRY_SCREEN_RETRY_BUTTON_BACKGROUND"])
                [builder setColor:[self colorWithInt:[input valueForKey:key]] forItem:RetryScreenRetryButtonBackground];
            if([key isEqual: @"CustomizationColor.RETRY_SCREEN_RETRY_BUTTON_TITLE"])
                [builder setColor:[self colorWithInt:[input valueForKey:key]] forItem:RetryScreenRetryButtonTitle];
            if([key isEqual: @"CustomizationColor.RETRY_SCREEN_TITLE_LABEL_TEXT"])
                [builder setColor:[self colorWithInt:[input valueForKey:key]] forItem:RetryScreenTitleLabelText];
            if([key isEqual: @"CustomizationColor.RETRY_SCREEN_HINT_LABELS_TEXT"])
                [builder setColor:[self colorWithInt:[input valueForKey:key]] forItem:RetryScreenHintLabelsText];
            if([key isEqual: @"CustomizationColor.PROCESSING_SCREEN_BACKGROUND"])
                [builder setColor:[self colorWithInt:[input valueForKey:key]] forItem:ProcessingScreenBackground];
            if([key isEqual: @"CustomizationColor.PROCESSING_SCREEN_PROGRESS"])
                [builder setColor:[self colorWithInt:[input valueForKey:key]] forItem:ProcessingScreenProgress];
            if([key isEqual: @"CustomizationColor.PROCESSING_SCREEN_TITLE"])
                [builder setColor:[self colorWithInt:[input valueForKey:key]] forItem:ProcessingScreenTitleLabel];
            if([key isEqual: @"CustomizationColor.SUCCESS_SCREEN_BACKGROUND"])
                [builder setColor:[self colorWithInt:[input valueForKey:key]] forItem:ProcessingScreenBackground];

            if([key isEqual: @"CustomizationImage.ONBOARDING_SCREEN_CLOSE_BUTTON"])
                [builder setImage:[self UIImageFromJSON:[input valueForKey:key]] forItem:OnboardingScreenCloseButton];
            if([key isEqual: @"CustomizationImage.ONBOARDING_SCREEN_ILLUMINATION"])
                [builder setImage:[self UIImageFromJSON:[input valueForKey:key]] forItem:OnboardingScreenIllumination];
            if([key isEqual: @"CustomizationImage.ONBOARDING_SCREEN_ACCESSORIES"])
                [builder setImage:[self UIImageFromJSON:[input valueForKey:key]] forItem:OnboardingScreenAccessories];
            if([key isEqual: @"CustomizationImage.ONBOARDING_SCREEN_CAMERA_LEVEL"])
                [builder setImage:[self UIImageFromJSON:[input valueForKey:key]] forItem:OnboardingScreenCameraLevel];
            if([key isEqual: @"CustomizationImage.CAMERA_SCREEN_CLOSE_BUTTON"])
                [builder setImage:[self UIImageFromJSON:[input valueForKey:key]] forItem:CameraScreenCloseButton];
            if([key isEqual: @"CustomizationImage.CAMERA_SCREEN_LIGHT_ON_BUTTON"])
                [builder setImage:[self UIImageFromJSON:[input valueForKey:key]] forItem:CameraScreenLightOnButton];
            if([key isEqual: @"CustomizationImage.CAMERA_SCREEN_LIGHT_OFF_BUTTON"])
                [builder setImage:[self UIImageFromJSON:[input valueForKey:key]] forItem:CameraScreenLightOffButton];
            if([key isEqual: @"CustomizationImage.CAMERA_SCREEN_SWITCH_BUTTON"])
                [builder setImage:[self UIImageFromJSON:[input valueForKey:key]] forItem:CameraScreenSwitchButton];
            if([key isEqual: @"CustomizationImage.RETRY_SCREEN_CLOSE_BUTTON"])
                [builder setImage:[self UIImageFromJSON:[input valueForKey:key]] forItem:RetryScreenCloseButton];
            if([key isEqual: @"CustomizationImage.RETRY_SCREEN_HINT_ENVIRONMENT"])
                [builder setImage:[self UIImageFromJSON:[input valueForKey:key]] forItem:RetryScreenHintEnvironment];
            if([key isEqual: @"CustomizationImage.RETRY_SCREEN_HINT_SUBJECT"])
                [builder setImage:[self UIImageFromJSON:[input valueForKey:key]] forItem:RetryScreenHintSubject];
            if([key isEqual: @"CustomizationImage.PROCESSING_SCREEN_CLOSE_BUTTON"])
                [builder setImage:[self UIImageFromJSON:[input valueForKey:key]] forItem:ProcessingScreenCloseButton];
            if([key isEqual: @"CustomizationImage.SUCCESS_SCREEN_IMAGE"])
                [builder setImage:[self UIImageFromJSON:[input valueForKey:key]] forItem:SuccessScreenImage];

            if([key isEqual: @"CustomizationFont.ONBOARDING_SCREEN_START_BUTTON"])
                [builder setFont:[self UIFontFromJSON:[input objectForKey:key]] forItem:OnboardingScreenStartButton];
            if([key isEqual: @"CustomizationFont.ONBOARDING_SCREEN_TITLE_LABEL"])
                [builder setFont:[self UIFontFromJSON:[input objectForKey:key]] forItem:OnboardingScreenTitleLabel];
            if([key isEqual: @"CustomizationFont.ONBOARDING_SCREEN_MESSAGE_LABEL"])
                [builder setFont:[self UIFontFromJSON:[input objectForKey:key]] forItem:OnboardingScreenMessageLabels];
            if([key isEqual: @"CustomizationFont.CAMERA_SCREEN_HINT_LABEL"])
                [builder setFont:[self UIFontFromJSON:[input objectForKey:key]] forItem:CameraScreenHintLabel];
            if([key isEqual: @"CustomizationFont.RETRY_SCREEN_RETRY_BUTTON"])
                [builder setFont:[self UIFontFromJSON:[input objectForKey:key]] forItem:RetryScreenRetryButton];
            if([key isEqual: @"CustomizationFont.RETRY_SCREEN_TITLE_LABEL"])
                [builder setFont:[self UIFontFromJSON:[input objectForKey:key]] forItem:RetryScreenTitleLabel];
            if([key isEqual: @"CustomizationFont.RETRY_SCREEN_HINT_LABELS"])
                [builder setFont:[self UIFontFromJSON:[input objectForKey:key]] forItem:RetryScreenHintLabels];
            if([key isEqual: @"CustomizationFont.PROCESSING_SCREEN"])
                [builder setFont:[self UIFontFromJSON:[input objectForKey:key]] forItem:ProcessingScreenLabel];
        }
    }];
}

+(RFSImage*)RFSImageFromJSON:(NSDictionary*)input {
    RFSImage* result = [[RFSImage alloc] initWithImage:[self UIImageFromJSON:[input valueForKey:@"bitmap"]] type:[[input valueForKey:@"imageType"] integerValue]];

    return result;
}

+(NSMutableDictionary*)generateCGRect:(CGRect)input {
    NSMutableDictionary *result = [NSMutableDictionary new];

    result[@"top"] = @(input.origin.y);
    result[@"left"] = @(input.origin.x);
    result[@"bottom"] = @(input.origin.y+input.size.height);
    result[@"right"] = @(input.origin.x+input.size.width);

    return result;
}

+(RFSMatchFacesImage*)RFSMatchFacesImageFromJSON:(NSDictionary*)input {
    UIImage* image = [self UIImageFromJSON:[input valueForKey:@"bitmap"]];
    bool hasDetectAll = false;
    bool detectAll = false;
    RFSImageType imageType = RFSImageTypePrinted;
    if([input valueForKey:@"detectAll"] != nil){
        hasDetectAll = true;
        detectAll = [input valueForKey:@"detectAll"];
    }
    if([input valueForKey:@"imageType"] != nil)
        imageType = [[input valueForKey:@"imageType"] integerValue];
    if(hasDetectAll)
        return [[RFSMatchFacesImage alloc] initWithImage:image imageType:imageType detectAll:detectAll];
    return [[RFSMatchFacesImage alloc] initWithImage:image imageType:imageType];
}

+(UIImage*)UIImageFromJSON:(NSString*)input {
    if([[input substringToIndex:5]  isEqual: @"data:"])
        input = [input substringFromIndex:[input rangeOfString:@","].location + 1];
    return [UIImage imageWithData:[[NSData alloc]initWithBase64EncodedString:input options:NSDataBase64DecodingIgnoreUnknownCharacters]];
}

+(NSMutableArray<RFSImage*>*)NSArrayRFSImageFromJSON:(NSArray*)input {
    NSMutableArray<RFSImage*>* result = [[NSMutableArray alloc] init];
    for(NSDictionary* item in input)
        [result addObject:[self RFSImageFromJSON:item]];

    return result;
}

+(NSMutableArray<RFSMatchFacesImage*>*)NSArrayRFSMatchFacesImageFromJSON:(NSArray*)input {
    NSMutableArray<RFSMatchFacesImage*>* result = [[NSMutableArray alloc] init];
    for(NSDictionary* item in input)
        [result addObject:[self RFSMatchFacesImageFromJSON:item]];

    return result;
}

+(NSMutableArray<RFSMatchFacesComparedFacesPair*>*)NSArrayRFSMatchFacesComparedFacesPairFromJSON:(NSArray*)input {
    NSMutableArray<RFSMatchFacesComparedFacesPair*>* result = [[NSMutableArray alloc] init];
    for(NSDictionary* item in input)
        [result addObject:[self RFSMatchFacesComparedFacesPairFromJSON:item]];

    return result;
}

+(RFSMatchFacesComparedFacesPair*)RFSMatchFacesComparedFacesPairFromJSON:(NSDictionary*)input {
    RFSMatchFacesComparedFace *first = nil;
    if([input valueForKey:@"first"] != nil){
        first = [self RFSMatchFacesComparedFaceFromJSON:[input valueForKey:@"first"]];
    }
    RFSMatchFacesComparedFace *second = nil;
    if([input valueForKey:@"second"] != nil){
        second = [self RFSMatchFacesComparedFaceFromJSON:[input valueForKey:@"second"]];
    }
    NSError *exception = nil;
    if([input valueForKey:@"exception"] != nil){
        exception = [self NSErrorFromJSON:[input valueForKey:@"exception"]];
    }
    NSNumber *similarity = 0;
    if([input valueForKey:@"similarity"] != nil){
        similarity = [input valueForKey:@"similarity"];
    }
    NSNumber *score = 0;
    if([input valueForKey:@"score"] != nil){
        score = [input valueForKey:@"score"];
    }

    return [[RFSMatchFacesComparedFacesPair alloc] initWithFirst:first second:second score:score similarity:similarity error:exception];
}

+(NSError*)NSErrorFromJSON:(NSDictionary*)input {
    if([input valueForKey:@"errorCode"] != nil)
        return [NSError errorWithDomain:RFSMatchFacesErrorDomain code:[[input valueForKey:@"errorCode"] integerValue] userInfo:nil];
    return nil;
}

+(RFSMatchFacesComparedFace*)RFSMatchFacesComparedFaceFromJSON:(NSDictionary*)input {
    RFSMatchFacesImage *image = nil;
    if([input valueForKey:@"image"] != nil){
        image = [self RFSMatchFacesImageFromJSON:[input valueForKey:@"image"]];
    }
    RFSMatchFacesDetectionFace *face = nil;
    if([input valueForKey:@"face"] != nil){
        face = [self RFSMatchFacesDetectionFaceFromJSON:[input valueForKey:@"face"]];
    }
    NSNumber *imageIndex = 0;
    if([input valueForKey:@"imageIndex"] != nil){
        imageIndex = [input valueForKey:@"imageIndex"];
    }
    NSNumber *faceIndex = 0;
    if([input valueForKey:@"faceIndex"] != nil){
        faceIndex = [input valueForKey:@"faceIndex"];
    }

    return [[RFSMatchFacesComparedFace alloc] initWithImageIndex:imageIndex image:image faceIndex:faceIndex face:face];
}

+(RFSMatchFacesDetectionFace*)RFSMatchFacesDetectionFaceFromJSON:(NSDictionary*)input {
    CGRect faceRect = CGRectNull;
    if([input valueForKey:@"faceRect"] != nil){
        faceRect = [self CGRectFromJSON:[input valueForKey:@"faceRect"]];
    }
    CGRect originalRect = CGRectNull;
    if([input valueForKey:@"originalRect"] != nil){
        originalRect = [self CGRectFromJSON:[input valueForKey:@"originalRect"]];
    }
    NSArray<RFSPoint*> *landmarks = [NSArray new];
    if([input valueForKey:@"landmarks"] != nil){
        landmarks = [self NSArrayRFSPointFromJSON:[input valueForKey:@"landmarks"]];
    }
    NSNumber *rotationAngle = 0;
    if([input valueForKey:@"rotationAngle"] != nil){
        rotationAngle = [input valueForKey:@"rotationAngle"];
    }
    NSNumber *faceIndex = 0;
    if([input valueForKey:@"faceIndex"] != nil){
        faceIndex = [input valueForKey:@"faceIndex"];
    }
    UIImage *crop = nil;
    if([input valueForKey:@"crop"] != nil){
        crop = [self UIImageFromJSON:[input valueForKey:@"crop"]];
    }

    return [[RFSMatchFacesDetectionFace alloc] initWithFaceIndex:faceIndex landmarks:landmarks faceRect:faceRect rotationAngle:rotationAngle thumbnailImage:nil crop:crop originalRect:originalRect];
}

+(CGRect)CGRectFromJSON:(NSDictionary*)input {
    CGFloat bottom = 0;
    if([input valueForKey:@"bottom"] != nil && [input valueForKey:@"bottom"] != [NSNull null]){
        bottom = [[input valueForKey:@"bottom"] floatValue];
    }
    CGFloat top = 0;
    if([input valueForKey:@"top"] != nil && [input valueForKey:@"top"] != [NSNull null]){
        top = [[input valueForKey:@"top"] floatValue];
    }
    CGFloat left = 0;
    if([input valueForKey:@"left"] != nil && [input valueForKey:@"left"] != [NSNull null]){
        left = [[input valueForKey:@"left"] floatValue];
    }
    CGFloat right = 0;
    if([input valueForKey:@"right"] != nil && [input valueForKey:@"right"] != [NSNull null]){
        right = [[input valueForKey:@"right"] floatValue];
    }

    return CGRectMake(left, top, right - left, bottom - top);
}

+(NSMutableArray<RFSPoint*>*)NSArrayRFSPointFromJSON:(NSArray*)input {
    NSMutableArray<RFSPoint*>* result = [[NSMutableArray alloc] init];
    for(NSDictionary* item in input)
        [result addObject:[self RFSPointFromJSON:item]];

    return result;
}

+(RFSPoint*)RFSPointFromJSON:(NSDictionary*)input {
    CGFloat x = 0;
    if([input valueForKey:@"x"] != nil){
        x = [[input valueForKey:@"x"] floatValue];
    }
    CGFloat y = 0;
    if([input valueForKey:@"y"] != nil){
        y = [[input valueForKey:@"y"] floatValue];
    }

    return [[RFSPoint alloc] initWithX:x y:y];
}

+(NSString*)idFromJSON:(NSDictionary*)input {
    return [input valueForKey:@"id"];
}

+(RFSPerson*)updatePersonFromJSON:(RFSPerson*)person :(NSDictionary*)json {
    if([json valueForKey:@"name"] != nil)
        person.name = [json valueForKey:@"name"];
    if([json valueForKey:@"metadata"] != nil)
        person.metadata = [json valueForKey:@"metadata"];
    return person;
}

+(RFSPersonGroup*)updatePersonGroupFromJSON:(RFSPersonGroup*)group :(NSDictionary*)json {
    if([json valueForKey:@"name"] != nil)
        group.name = [json valueForKey:@"name"];
    if([json valueForKey:@"metadata"] != nil)
        group.metadata = [json valueForKey:@"metadata"];
    return group;
}

+(RFSEditGroupPersonsRequest*)RFSEditGroupPersonsRequestFromJSON:(NSDictionary*)input {
    NSArray<NSString*> *personIdsToAdd = [NSArray new];
    if([input valueForKey:@"personIdsToAdd"] != nil)
        personIdsToAdd = [input valueForKey:@"personIdsToAdd"];
    NSArray<NSString*> *personIdsToRemove = [NSArray new];
    if([input valueForKey:@"personIdsToRemove"] != nil)
        personIdsToRemove = [input valueForKey:@"personIdsToRemove"];

    return [[RFSEditGroupPersonsRequest alloc] initWithPersonIdsToAdd:personIdsToAdd personIdsToRemove:personIdsToRemove];
}

+(RFSSearchPersonRequest*)RFSSearchPersonRequestFromJSON:(NSDictionary*)input {
    RFSSearchPersonRequest *result;

    RFSImageUpload *imageUpload = [self RFSImageUploadFromJSON: [input valueForKey:@"imageUpload"]];

    if([input valueForKey:@"groupIdsForSearch"] != nil)
        result = [[RFSSearchPersonRequest alloc] initWithGroupIds:[input valueForKey:@"groupIdsForSearch"] imageUpload:imageUpload];
    else
        result = [[RFSSearchPersonRequest alloc]  initWithImageUpload:imageUpload];

    if([input valueForKey:@"threshold"] != nil)
        result.threshold = [input valueForKey:@"threshold"];
    if([input valueForKey:@"limit"] != nil)
        result.limit = [input valueForKey:@"limit"];
    if([input valueForKey:@"detectAll"] != nil)
        result.detectAll = [input valueForKey:@"detectAll"];
    if([input valueForKey:@"outputImageParams"] != nil)
        result.outputImageParams = [self RFSOutputImageParamsFromJSON:[input valueForKey:@"outputImageParams"]];

    return result;
}

+(RFSImageUpload*)RFSImageUploadFromJSON:(NSDictionary*)input {
    if([input valueForKey:@"imageUrl"] != nil)
        return [[RFSImageUpload alloc] initWithImageURL:[self NSURLFromJSON:[input valueForKey:@"imageUrl"]]];
    else  if([input valueForKey:@"imageData"] != nil)
        return [[RFSImageUpload alloc] initWithImageData:[[NSData alloc] initWithBase64EncodedString: [input valueForKey:@"imageData"] options:0]];
    return nil;
}

+(NSMutableDictionary* _Nonnull)generateRFSPagePersonResponse:(RFSPageResponse<RFSPerson *>* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    if(input.items != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(RFSPerson* item in input.items)
            if(item != nil)
                [array addObject:[self generateRFSPerson:item]];
        result[@"items"] = array;
    }
    result[@"page"] = @(input.page);
    result[@"totalPages"] = @(input.totalPages);

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSPagePersonImageResponse:(RFSPageResponse<RFSPersonImage *>* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    if(input.items != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(RFSPersonImage* item in input.items)
            if(item != nil)
                [array addObject:[self generateRFSPersonImage:item]];
        result[@"items"] = array;
    }
    result[@"page"] = @(input.page);
    result[@"totalPages"] = @(input.totalPages);

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSPagePersonGroupResponse:(RFSPageResponse<RFSPersonGroup *>* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    if(input.items != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(RFSPersonGroup* item in input.items)
            if(item != nil)
                [array addObject:[self generateRFSPersonGroup:item]];
        result[@"items"] = array;
    }
    result[@"page"] = @(input.page);
    result[@"totalPages"] = @(input.totalPages);

    return result;
}

+(NSMutableDictionary* _Nonnull)generateNSDataImage:(NSData*)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"image"] = [input base64EncodedDataWithOptions:0];

    return result;
}

    // To JSON

+(NSMutableDictionary* _Nonnull)generateRFSFaceCaptureResponse:(RFSFaceCaptureResponse* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return nil;

    result[@"image"] = [self generateRFSImage:input.image];
    result[@"exception"] = [self generateNSError:input.error];

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSLivenessResponse:(RFSLivenessResponse* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return nil;

    result[@"bitmap"] = [UIImageJPEGRepresentation(input.image, 1.0) base64EncodedStringWithOptions:0];
    result[@"liveness"] = [self generateRFSLivenessStatus:input.liveness];
    result[@"estimatedAge"] = input.estimatedAge;
    result[@"exception"] = [self generateNSError:input.error];
    result[@"tag"] = input.tag;
    result[@"transactionId"] = input.transactionId;

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesResponse:(RFSMatchFacesResponse* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return nil;

    result[@"tag"] = input.tag;
    result[@"exception"] = [self generateNSError:input.error];
    if(input.results != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(RFSMatchFacesComparedFacesPair* item in input.results)
            if(item != nil)
                [array addObject:[self generateRFSMatchFacesComparedFacesPair:item]];
        result[@"results"] = array;
    }
    if(input.detections != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(RFSMatchFacesDetection* item in input.detections)
            if(item != nil)
                [array addObject:[self generateRFSMatchFacesDetection:item]];
        result[@"detections"] = array;
    }

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSImage:(RFSImage* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return nil;

    result[@"imageType"] = [self generateRFSImageType:input.imageType];
    result[@"bitmap"] = [UIImageJPEGRepresentation(input.image, 1.0) base64EncodedStringWithOptions:0];

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesImage:(RFSMatchFacesImage* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return nil;

    result[@"imageType"] = [self generateRFSImageType:input.imageType];
    result[@"bitmap"] = [UIImageJPEGRepresentation(input.image, 1.0) base64EncodedStringWithOptions:0];
    result[@"detectAll"] = @(input.detectAll);
    result[@"identifier"] = input.identifier;

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesComparedFacesPair:(RFSMatchFacesComparedFacesPair* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return nil;

    result[@"first"] = [self generateRFSMatchFacesComparedFace:input.first];
    result[@"second"] = [self generateRFSMatchFacesComparedFace:input.second];
    result[@"score"] = input.score;
    result[@"similarity"] = input.similarity;
    result[@"exception"] = [self generateNSError:input.error];

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesComparedFace:(RFSMatchFacesComparedFace* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return nil;

    result[@"imageIndex"] = input.imageIndex;
    result[@"faceIndex"] = input.faceIndex;
    result[@"image"] = [self generateRFSMatchFacesImage:input.image];
    result[@"face"] = [self generateRFSMatchFacesDetectionFace:input.face];

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesDetectionFace:(RFSMatchFacesDetectionFace* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return nil;

    result[@"rotationAngle"] = input.rotationAngle;
    result[@"faceIndex"] = input.faceIndex;
    if(input.landmarks != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(RFSPoint* item in input.landmarks)
            if(item != nil)
                [array addObject:[self generateRFSPoint:item]];
        result[@"landmarks"] = array;
    }
    result[@"faceRect"] = [self generateCGRect:input.faceRect];

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesDetection:(RFSMatchFacesDetection* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return nil;

    result[@"image"] = [self generateRFSMatchFacesImage:input.image];
    result[@"imageIndex"] = input.imageIndex;
    if(input.faces != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(RFSMatchFacesDetectionFace* item in input.faces)
            if(item != nil)
                [array addObject:[self generateRFSMatchFacesDetectionFace:item]];
        result[@"faces"] = array;
    }
    result[@"exception"] = [self generateNSError:input.error];

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSPoint:(RFSPoint* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return nil;

    result[@"x"] = @(input.x);
    result[@"y"] = @(input.y);

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesSimilarityThresholdSplit:(RFSMatchFacesSimilarityThresholdSplit* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return nil;

    if(input.matchedFaces != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(RFSMatchFacesComparedFacesPair* item in input.matchedFaces)
            if(item != nil)
                [array addObject:[self generateRFSMatchFacesComparedFacesPair:item]];
        result[@"matchedFaces"] = array;
    }
    if(input.unmatchedFaces != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(RFSMatchFacesComparedFacesPair* item in input.unmatchedFaces)
            if(item != nil)
                [array addObject:[self generateRFSMatchFacesComparedFacesPair:item]];
        result[@"unmatchedFaces"] = array;
    }

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSImageQualityRange:(RFSImageQualityRange* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return nil;

    result[@"min"] = input.min;
    result[@"max"] = input.max;

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSDetectFacesResponse:(RFSDetectFacesResponse* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return nil;

    result[@"detection"] = [self generateRFSDetectFaceResult:input.detection];
    result[@"scenario"] = input.scenario;
    result[@"error"] = [self generateNSError:input.error];
    if(input.allDetections != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(RFSDetectFaceResult* item in input.allDetections)
            if(item != nil)
                [array addObject:[self generateRFSDetectFaceResult:item]];
        result[@"allDetections"] = array;
    }

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSDetectFaceResult:(RFSDetectFaceResult* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return nil;

    if(input.quality != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(RFSImageQualityResult* item in input.quality)
            if(item != nil)
                [array addObject:[self generateRFSImageQualityResult:item]];
        result[@"quality"] = array;
    }
    if(input.attributes != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(RFSDetectFacesAttributeResult* item in input.attributes)
            if(item != nil)
                [array addObject:[self generateRFSDetectFacesAttributeResult:item]];
        result[@"attributes"] = array;
    }
    if(input.landmarks != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(RFSPoint* item in input.landmarks)
            if(item != nil)
                [array addObject:[self generateRFSPoint:item]];
        result[@"landmarks"] = array;
    }
    result[@"crop"] = [UIImageJPEGRepresentation(input.crop, 1.0) base64EncodedStringWithOptions:0];
    result[@"faceRect"] = [self generateCGRect:input.faceRect];
    result[@"originalRect"] = [self generateCGRect:input.originalRect];
    result[@"isQualityCompliant"] = @(input.isQualityCompliant);

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSImageQualityResult:(RFSImageQualityResult* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return nil;

    result[@"name"] = [self generateRFSImageQualityCharacteristicName:input.name];
    result[@"group"] = [self generateRFSImageQualityGroup:input.group];
    result[@"status"] = [self generateRFSImageQualityResultStatus:input.status];
    result[@"range"] = [self generateRFSImageQualityRange:input.range];
    result[@"value"] = input.value;

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSDetectFacesAttributeResult:(RFSDetectFacesAttributeResult* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return nil;

    result[@"attribute"] = [self generateRFSDetectFacesAttribute:input.attribute];
    result[@"value"] = input.value;
    result[@"range"] = [self generateRFSImageQualityRange:input.range];
    result[@"confidence"] = input.confidence;

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSPerson:(RFSPerson* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return nil;

    result[@"name"] = input.name;
    if(input.groups != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(NSString* item in input.groups)
            if(item != nil)
                [array addObject:item];
        result[@"groups"] = array;
    }
    result[@"updatedAt"] = [self generateNSDate:input.updatedAt];
    result[@"id"] = input.itemId;
    result[@"metadata"] = input.metadata;
    result[@"createdAt"] = [self generateNSDate:input.createdAt];

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSPersonImage:(RFSPersonImage* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return nil;

    result[@"path"] = input.path;
    result[@"url"] = [self generateNSURL:input.url];
    result[@"contentType"] = input.contentType;
    result[@"id"] = input.itemId;
    result[@"metadata"] = input.metadata;
    result[@"createdAt"] = [self generateNSDate:input.createdAt];

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSPersonGroup:(RFSPersonGroup* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return nil;

    result[@"name"] = input.name;
    result[@"id"] = input.itemId;
    result[@"metadata"] = input.metadata;
    result[@"createdAt"] = [self generateNSDate:input.createdAt];

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSSearchPerson:(RFSSearchPerson* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return nil;

    result[@"detection"] = [self generateRFSSearchPersonDetection:input.detection];
    if(input.images != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(RFSSearchPersonImage* item in input.images)
            if(item != nil)
                [array addObject:[self generateRFSSearchPersonImage:item]];
        result[@"images"] = array;
    }
    result[@"name"] = input.name;
    if(input.groups != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(NSString* item in input.groups)
            if(item != nil)
                [array addObject:item];
        result[@"groups"] = array;
    }
    result[@"updatedAt"] = [self generateNSDate:input.updatedAt];
    result[@"id"] = input.itemId;
    result[@"metadata"] = input.metadata;
    result[@"createdAt"] = [self generateNSDate:input.createdAt];

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSSearchPersonImage:(RFSSearchPersonImage* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return nil;

    result[@"similarity"] = input.similarity;
    result[@"distance"] = input.distance;
    result[@"path"] = input.path;
    result[@"url"] = [self generateNSURL:input.url];
    result[@"contentType"] = input.contentType;
    result[@"id"] = input.itemId;
    result[@"metadata"] = input.metadata;
    result[@"createdAt"] = [self generateNSDate:input.createdAt];

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSSearchPersonDetection:(RFSSearchPersonDetection* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return nil;

    if(input.landmarks != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(RFSPoint* item in input.landmarks)
            if(item != nil)
                [array addObject:[self generateRFSPoint:item]];
        result[@"landmarks"] = array;
    }
    result[@"rect"] = [self generateCGRect:input.rect];
    result[@"cropImage"] = [UIImageJPEGRepresentation(input.crop, 1.0) base64EncodedStringWithOptions:0];
    result[@"rotationAngle"] = input.rotationAngle;

    return result;
}

@end