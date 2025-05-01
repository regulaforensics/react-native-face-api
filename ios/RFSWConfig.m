#import "RFSWConfig.h"

@implementation RFSWConfig

+(RFSFaceCaptureConfiguration*)faceCaptureConfigFromJSON:(NSDictionary*)input {
    if (!input || [input isEqual:[NSNull null]])  return nil;
    return [RFSFaceCaptureConfiguration configurationWithBuilder:^(RFSFaceCaptureConfigurationBuilder  * _Nonnull builder) {
        for (NSString* key in input) {
            id value = input[key];
            NSDictionary* Switch = @{
                @"copyright": ^{ [builder setCopyright:[value boolValue]]; },
                @"cameraSwitchEnabled": ^{ [builder setCameraSwitchButtonEnabled:[value boolValue]]; },
                @"closeButtonEnabled": ^{ [builder setCloseButtonEnabled:[value boolValue]]; },
                @"torchButtonEnabled": ^{ [builder setTorchButtonEnabled:[value boolValue]]; },
                @"vibrateOnSteps": ^{ [builder setVibrateOnSteps:[value boolValue]]; },
                @"detectOcclusion": ^{ [builder setDetectOcclusion:[value boolValue]]; },
                @"showFaceAnimation": ^{ [builder setShowFaceAnimation:[value boolValue]]; },
                @"cameraPositionIOS": ^{ [builder setCameraPosition:[value integerValue]]; },
                @"screenOrientation": ^{ [builder setScreenOrientation:[RFSWJSONConstructor screenOrienrationFromJSON:value]]; },
                @"timeout": ^{ [builder setTimeoutInterval:value]; },
                @"holdStillDuration": ^{ [builder setHoldStillDuration:value]; },
            };
            if(Switch[key]) ((void(^)(void))Switch[key])();
        }
    }];
}

+(id)generateFaceCaptureConfig:(RFSFaceCaptureConfiguration*)input {
    NSMutableDictionary* result = @{
        @"copyright":@(input.copyright),
        @"cameraSwitchEnabled":@(input.cameraSwitchButtonEnabled),
        @"closeButtonEnabled":@(input.closeButtonEnabled),
        @"torchButtonEnabled":@(input.torchButtonEnabled),
        @"vibrateOnSteps":@(input.vibrateOnSteps),
        @"detectOcclusion":@(input.detectOcclusion),
        @"showFaceAnimation":@(input.showFaceAnimation),
        @"cameraPositionIOS":@(input.cameraPosition),
        @"screenOrientation":[RFSWJSONConstructor generateScreenOrienration:input.screenOrientation],
    }.mutableCopy;
    if (input.timeoutInterval) result[@"timeout"] = input.timeoutInterval;
    if (input.holdStillDuration) result[@"holdStillDuration"] = input.holdStillDuration;
    return result;
}

+(RFSLivenessConfiguration*)livenessConfigFromJSON:(NSDictionary*)input {
    if (!input || [input isEqual:[NSNull null]])  return nil;
    return [RFSLivenessConfiguration configurationWithBuilder:^(RFSLivenessConfigurationBuilder  * _Nonnull builder) {
        for (NSString* key in input) {
            id value = input[key];
            NSDictionary* Switch = @{
                @"copyright": ^{ [builder setCopyright:[value boolValue]]; },
                @"cameraSwitchEnabled": ^{ [builder setCameraSwitchButtonEnabled:[value boolValue]]; },
                @"closeButtonEnabled": ^{ [builder setCloseButtonEnabled:[value boolValue]]; },
                @"torchButtonEnabled": ^{ [builder setTorchButtonEnabled:[value boolValue]]; },
                @"vibrateOnSteps": ^{ [builder setVibrateOnSteps:[value boolValue]]; },
                @"cameraPositionIOS": ^{ [builder setCameraPosition:[value integerValue]]; },
                @"attemptsCount": ^{ [builder setAttemptsCount:[value integerValue]]; },
                @"locationTrackingEnabled": ^{ [builder setLocationTrackingEnabled:[value boolValue]]; },
                @"recordingProcess": ^{ [builder setRecordingProcess:[value integerValue]]; },
                @"livenessType": ^{ [builder setLivenessType:[value integerValue]]; },
                @"screenOrientation": ^{ [builder setScreenOrientation:[value integerValue]]; },
                @"tag": ^{ [builder setTag:value]; },
                @"skipStep": ^{ [builder setStepSkippingMask:[RFSWJSONConstructor livenessStepSkipFromJSON:value]]; },
                @"metadata": ^{ [builder setMetadata:value]; },
            };
            if(Switch[key]) ((void(^)(void))Switch[key])();
        }
    }];
}

+(id)generateLivenessConfig:(RFSLivenessConfiguration*)input {
    NSMutableDictionary* result = @{
        @"copyright":@(input.copyright),
        @"cameraSwitchEnabled":@(input.cameraSwitchButtonEnabled),
        @"closeButtonEnabled":@(input.closeButtonEnabled),
        @"torchButtonEnabled":@(input.torchButtonEnabled),
        @"vibrateOnSteps":@(input.vibrateOnSteps),
        @"cameraPositionIOS":@(input.cameraPosition),
        @"attemptsCount":@(input.attemptsCount),
        @"locationTrackingEnabled":@(input.locationTrackingEnabled),
        @"recordingProcess":@(input.recordingProcess),
        @"livenessType":@(input.livenessType),
        @"screenOrientation":@(input.screenOrientation),
        @"skipStep":[RFSWJSONConstructor generateLivenessStepSkip:input.stepSkippingMask],
        @"metadata":input.metadata,
    }.mutableCopy;
    if (input.tag) result[@"tag"] = input.tag;
    return result;
}

+(RFSMatchFacesConfiguration*)matchFacesConfigFromJSON:(NSDictionary*)input {
    if (!input || [input isEqual:[NSNull null]])  return nil;
    return [RFSMatchFacesConfiguration configurationWithBuilder:^(RFSMatchFacesConfigurationBuilder  * _Nonnull builder) {
        for (NSString* key in input) {
            id value = input[key];
            NSDictionary* Switch = @{
                @"processingMode": ^{ [builder setProcessingMode:[value integerValue]]; },
                @"locationTrackingEnabled": ^{ [builder setLocationTrackingEnabled:[value boolValue]]; },
            };
            if(Switch[key]) ((void(^)(void))Switch[key])();
        }
    }];
}

+(id)generateMatchFacesConfig:(RFSMatchFacesConfiguration*)input {
    return @{
        @"processingMode":@(input.processingMode),
        @"locationTrackingEnabled":@(input.locationTrackingEnabled),
    };
}

// For some reason if you iterate over dictionary using NSNumber* or id,
// it does't work as a key to dictionary unless you do this.
+(NSNumber*)toKey:(id)input {
    return [NSNumber numberWithInt:[input intValue]];
}

+(void)setCustomization:(NSDictionary*)config :(RFSCustomization*)result {
    RFSUIConfiguration* uiConfig = [result configuration];
    for (NSString* key in config) {
        NSDictionary* value = config[key];
        NSDictionary* Switch = @{
            @"colors": ^{ for (id k in value) [uiConfig valueForKey:key][[RFSWConfig toKey:k]] = [RFSWJSONConstructor colorWithInt:value[k]]; },
            @"fonts": ^{ for (id k in value) [uiConfig valueForKey:key][[RFSWConfig toKey:k]] = [RFSWJSONConstructor fontFromJSON:value[k]]; },
            @"images": ^{ for (id k in value) [uiConfig valueForKey:key][[RFSWConfig toKey:k]] = [RFSWJSONConstructor imageWithBase64:value[k]]; },
            @"uiCustomizationLayer": ^{ [result setCustomUILayerJSON:value]; },
        };
        ((void(^)(void))Switch[key])();
    }
}

+(id)imageQualityCharacteristicWithName:(NSString*)name recommendedRange:(NSArray*)recommendedRange customRange:(NSArray*)customRange color:(UIColor*)color {
    __block RFSImageQualityCharacteristic* result = nil;
    NSDictionary* Switch = @{
        @"ImageWidth": ^{ result = [RFSImageCharacteristics imageWidthWithRange:recommendedRange]; },
        @"ImageHeight": ^{ result = [RFSImageCharacteristics imageHeightWithRange:recommendedRange]; },
        @"ImageWidthToHeight": ^{ result = [RFSImageCharacteristics imageWidthToHeightWithRange:recommendedRange]; },
        @"ImageChannelsNumber": ^{ result = [RFSImageCharacteristics imageChannelsNumberWithValue:recommendedRange[0]]; },
        @"PaddingRatio": ^{ result = [RFSImageCharacteristics paddingRatioWithMinValue:recommendedRange[0] maxValue:recommendedRange[1]]; },
        @"ArtFace": ^{ result = RFSImageCharacteristics.artFace; },
        
        @"FaceMidPointHorizontalPosition": ^{ result = RFSHeadSizeAndPosition.faceMidPointHorizontalPosition; },
        @"FaceMidPointVerticalPosition": ^{ result = RFSHeadSizeAndPosition.faceMidPointVerticalPosition; },
        @"HeadWidthRatio": ^{ result = RFSHeadSizeAndPosition.headWidthRatio; },
        @"HeadHeightRatio": ^{ result = RFSHeadSizeAndPosition.headHeightRatio; },
        @"EyesDistance": ^{ result = RFSHeadSizeAndPosition.eyesDistance; },
        @"Yaw": ^{ result = RFSHeadSizeAndPosition.yaw; },
        @"Pitch": ^{ result = RFSHeadSizeAndPosition.pitch; },
        @"Roll": ^{ result = RFSHeadSizeAndPosition.roll; },
        
        @"BlurLevel": ^{ result = RFSFaceImageQuality.blurLevel; },
        @"NoiseLevel": ^{ result = RFSFaceImageQuality.noiseLevel; },
        @"UnnaturalSkinTone": ^{ result = RFSFaceImageQuality.unnaturalSkinTone; },
        @"FaceDynamicRange": ^{ result = RFSFaceImageQuality.faceDynamicRange; },
        
        @"EyeRightClosed": ^{ result = RFSEyesCharacteristics.eyeRightClosed; },
        @"EyeLeftClosed": ^{ result = RFSEyesCharacteristics.eyeLeftClosed; },
        @"EyeRightOccluded": ^{ result = RFSEyesCharacteristics.eyeRightOccluded; },
        @"EyeLeftOccluded": ^{ result = RFSEyesCharacteristics.eyeLeftOccluded; },
        @"EyesRed": ^{ result = RFSEyesCharacteristics.eyesRed; },
        @"EyeRightCoveredWithHair": ^{ result = RFSEyesCharacteristics.eyeRightCoveredWithHair; },
        @"EyeLeftCoveredWithHair": ^{ result = RFSEyesCharacteristics.eyeLeftCoveredWithHair; },
        @"OffGaze": ^{ result = RFSEyesCharacteristics.offGaze; },
        
        @"TooDark": ^{ result = RFSShadowsAndLightning.tooDark; },
        @"TooLight": ^{ result = RFSShadowsAndLightning.tooLight; },
        @"FaceGlare": ^{ result = RFSShadowsAndLightning.faceGlare; },
        @"ShadowsOnFace": ^{ result = RFSShadowsAndLightning.shadowsOnFace; },
        
        @"ShouldersPose": ^{ result = RFSPoseAndExpression.shouldersPose; },
        @"ExpressionLevel": ^{ result = RFSPoseAndExpression.expressionLevel; },
        @"MouthOpen": ^{ result = RFSPoseAndExpression.mouthOpen; },
        @"Smile": ^{ result = RFSPoseAndExpression.smile; },
        
        @"DarkGlasses": ^{ result = RFSHeadOcclusion.darkGlasses; },
        @"ReflectionOnGlasses": ^{ result = RFSHeadOcclusion.reflectionOnGlasses; },
        @"FramesTooHeavy": ^{ result = RFSHeadOcclusion.framesTooHeavy; },
        @"FaceOccluded": ^{ result = RFSHeadOcclusion.faceOccluded; },
        @"HeadCovering": ^{ result = RFSHeadOcclusion.headCovering; },
        @"ForeheadCovering": ^{ result = RFSHeadOcclusion.foreheadCovering; },
        @"StrongMakeup": ^{ result = RFSHeadOcclusion.strongMakeup; },
        @"Headphones": ^{ result = RFSHeadOcclusion.headphones; },
        @"MedicalMask": ^{ result = RFSHeadOcclusion.medicalMask; },
        
        @"BackgroundUniformity": ^{ result = RFSQualityBackground.backgroundUniformity; },
        @"ShadowsOnBackground": ^{ result = RFSQualityBackground.shadowsOnBackground; },
        @"OtherFaces": ^{ result = RFSQualityBackground.otherFaces; },
        @"BackgroundColorMatch": ^{
            if (color) result = [RFSQualityBackground backgroundColorMatchWithColor:color];
            else result = RFSQualityBackground.backgroundColorMatch;
        },
    };
    ((void(^)(void))Switch[name])();
    if (!result) [NSException raise:@"RFSImageQualityCharacteristic" format:@"name not found"];
    if (customRange) result = [result withCustomRange:customRange];
    return result;
}

@end
