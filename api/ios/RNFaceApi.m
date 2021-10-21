#import "RNFaceApi.h"

@implementation RNFaceApi

RCT_EXPORT_MODULE();

typedef void (^Callback)(NSString* response);

- (void)result:(NSString*)message :(Callback)callback {
    callback(message);
}

RCT_EXPORT_METHOD(exec:(NSString*)moduleName:(NSString*)action:(NSArray*)args:(RCTResponseSenderBlock)sCallback:(RCTResponseSenderBlock)eCallback) {
    Callback successCallback = ^(NSString* response){
        sCallback(@[response]);
    };
    Callback errorCallback = ^(NSString* response){
        eCallback(@[response]);
    };

    if([action isEqualToString:@"getServiceUrl"])
        [self getServiceUrl :successCallback :errorCallback];
    else if([action isEqualToString:@"startLiveness"])
        [self startLiveness :successCallback :errorCallback];
    else if([action isEqualToString:@"getFaceSdkVersion"])
        [self getFaceSdkVersion :successCallback :errorCallback];
    else if([action isEqualToString:@"presentFaceCaptureActivity"])
        [self presentFaceCaptureActivity :successCallback :errorCallback];
    else if([action isEqualToString:@"stopFaceCaptureActivity"])
        [self stopFaceCaptureActivity :successCallback :errorCallback];
    else if([action isEqualToString:@"stopLivenessProcessing"])
        [self stopLivenessProcessing :successCallback :errorCallback];
    else if([action isEqualToString:@"presentFaceCaptureActivityWithConfig"])
        [self presentFaceCaptureActivityWithConfig :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"startLivenessWithConfig"])
        [self startLivenessWithConfig :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"setServiceUrl"])
        [self setServiceUrl :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"matchFaces"])
        [self matchFaces :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"setLanguage"])
        [self setLanguage :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"matchFacesWithConfig"])
        [self matchFacesWithConfig :[args objectAtIndex:0] :[args objectAtIndex:1] :successCallback :errorCallback];
    else
        [self result:[NSString stringWithFormat:@"%@/%@", @"method not implemented: ", action] :errorCallback];
}

- (void) getServiceUrl:(Callback)successCallback :(Callback)errorCallback{
    [self result:[RFSFaceSDK.service serviceURL] :successCallback];
}

- (void) startLiveness:(Callback)successCallback :(Callback)errorCallback{
    dispatch_async(dispatch_get_main_queue(), ^{
        [RFSFaceSDK.service startLivenessFrom:[[[UIApplication sharedApplication] keyWindow] rootViewController] animated:true onLiveness:[self getLivenessCompletion:successCallback :errorCallback] completion:nil];
    });
}

- (void) getFaceSdkVersion:(Callback)successCallback :(Callback)errorCallback{
    [self result:[RFSFaceSDK.service version] :successCallback];
}

- (void) presentFaceCaptureActivity:(Callback)successCallback :(Callback)errorCallback{
    dispatch_async(dispatch_get_main_queue(), ^{
        [RFSFaceSDK.service presentFaceCaptureViewControllerFrom:[[[UIApplication sharedApplication] keyWindow] rootViewController] animated:true onCapture:[self getFaceCaptureCompletion:successCallback :errorCallback] completion:nil];
    });
}

- (void) stopFaceCaptureActivity:(Callback)successCallback :(Callback)errorCallback{
    [RFSFaceSDK.service stopFaceCaptureViewController];
    [self result:@"" :successCallback];
}

- (void) stopLivenessProcessing:(Callback)successCallback :(Callback)errorCallback{
    [RFSFaceSDK.service stopLivenessProcessing];
    [self result:@"" :successCallback];
}

- (void) presentFaceCaptureActivityWithConfig:(NSDictionary*)config :(Callback)successCallback :(Callback)errorCallback{
    RFSFaceCaptureConfiguration *configuration = [RFSFaceCaptureConfiguration configurationWithBuilder:^(RFSFaceCaptureConfigurationBuilder  * _Nonnull builder) {
        if([config valueForKey:@"cameraSwitchEnabled"] != nil)
            [builder setCameraSwitchEnabled:[[config valueForKey:@"cameraSwitchEnabled"] boolValue]];
        if([config valueForKey:@"showHelpTextAnimation"] != nil)
            [builder setEnableHintAnimation:[[config valueForKey:@"showHelpTextAnimation"] boolValue]];
        if([config valueForKey:@"cameraPositionIOS"] != nil)
            [builder setCameraPosition:[self RFSCameraPositionWithNSInteger:[[config valueForKey:@"cameraPositionIOS"] integerValue]]];
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [RFSFaceSDK.service presentFaceCaptureViewControllerFrom:[[[UIApplication sharedApplication] keyWindow] rootViewController] animated:true configuration: configuration onCapture:[self getFaceCaptureCompletion:successCallback :errorCallback] completion:nil];
    });
}

- (void) startLivenessWithConfig:(NSDictionary*)config :(Callback)successCallback :(Callback)errorCallback{
    RFSLivenessConfiguration *configuration = [RFSLivenessConfiguration configurationWithBuilder:^(RFSLivenessConfigurationBuilder  * _Nonnull builder) {
        if([config valueForKey:@"attemptsCount"] != nil)
            [builder setAttemptsCount:[[config valueForKey:@"attemptsCount"] integerValue]];
        if([config valueForKey:@"cameraSwitchEnabled"] != nil)
            [builder setCameraSwitchEnabled:[[config valueForKey:@"cameraSwitchEnabled"] boolValue]];
        if([config valueForKey:@"showHelpTextAnimation"] != nil)
            [builder setEnableHintAnimation:[[config valueForKey:@"showHelpTextAnimation"] boolValue]];
        if([config valueForKey:@"cameraPositionIOS"] != nil)
            [builder setCameraPosition:[self RFSCameraPositionWithNSInteger:[[config valueForKey:@"cameraPositionIOS"] integerValue]]];
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [RFSFaceSDK.service startLivenessFrom:[[[UIApplication sharedApplication] keyWindow] rootViewController] animated:true configuration: configuration onLiveness:[self getLivenessCompletion:successCallback :errorCallback] completion:nil];
    });
}

- (void) setServiceUrl:(NSString*)url :(Callback)successCallback :(Callback)errorCallback{
    [RFSFaceSDK.service setServiceURL:url];
    [self result:@"" :successCallback];
}

- (void) matchFaces:(NSString*)requestString :(Callback)successCallback :(Callback)errorCallback{
    [RFSFaceSDK.service matchFaces:[RFSWJSONConstructor RFSMatchFacesRequestFromJSON:[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL]] completion:[self getMatchFacesCompletion:successCallback :errorCallback]];
}

- (void) matchFacesWithConfig:(NSString*)requestString :(NSDictionary*)config :(Callback)successCallback :(Callback)errorCallback{
    [RFSFaceSDK.service matchFaces:[RFSWJSONConstructor RFSMatchFacesRequestFromJSON:[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL]] completion:[self getMatchFacesCompletion:successCallback :errorCallback]];
}

- (void) setLanguage:(NSString*)language :(Callback)successCallback :(Callback)errorCallback{
    RFSFaceSDK.service.localizationHandler = ^NSString * _Nullable(NSString * _Nonnull localizationKey) {
        NSString *result = NSLocalizedStringFromTable(localizationKey, language, @"");
        if (![result isEqualToString:localizationKey])
            return result;
        return nil;
    };
    [self result:@"" :successCallback];
}

- (void (^)(RFSLivenessResponse * _Nonnull)) getLivenessCompletion:(Callback)successCallback :(Callback)errorCallback {
    return ^(RFSLivenessResponse* response) {
        [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateRFSLivenessResponse:response]] :successCallback];
    };
}

- (void (^)(RFSFaceCaptureResponse * _Nonnull)) getFaceCaptureCompletion:(Callback)successCallback :(Callback)errorCallback {
    return ^(RFSFaceCaptureResponse* response) {
        [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateRFSFaceCaptureResponse:response]] :successCallback];
    };
}

- (void (^)(RFSMatchFacesResponse * _Nonnull)) getMatchFacesCompletion:(Callback)successCallback :(Callback)errorCallback {
    return ^(RFSMatchFacesResponse* response) {
        [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateRFSMatchFacesResponse:response]] :successCallback];
    };
}

-(RFSCameraPosition)RFSCameraPositionWithNSInteger:(NSInteger)value {
    switch(value){
        case 0:
            return RFSCameraPositionBack;
        case 1:
            return RFSCameraPositionFront;
        default:
            return RFSCameraPositionBack;
    }
}

@end
