#import "RNFaceApi.h"

@implementation RNFaceApi

RCT_EXPORT_MODULE();

NSString* videoEncoderCompletionEvent = @"videoEncoderCompletionEvent";

RNFaceApi* plugin;

- (NSArray<NSString*>*)supportedEvents {
    return @[videoEncoderCompletionEvent];
}

typedef void (^Callback)(NSString* response);

- (void)result:(NSString*)message :(Callback)callback {
    callback(message);
}

typedef void (^VideoEncoderCompletion)(NSString * _Nonnull transactionId, BOOL success);
VideoEncoderCompletion sendVideoEncoderCompletion = ^(NSString * _Nonnull transactionId, BOOL success) {
    [plugin sendEventWithName:videoEncoderCompletionEvent body:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateVideoEncoderCompletion:transactionId :success]]];
};

RCT_EXPORT_METHOD(exec:(NSString*)moduleName:(NSString*)action:(NSArray*)args:(RCTResponseSenderBlock)sCallback:(RCTResponseSenderBlock)eCallback) {
    plugin = self;
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
    else if([action isEqualToString:@"init"])
        [self init :successCallback :errorCallback];
    else if([action isEqualToString:@"deinit"])
        [self deinit :successCallback :errorCallback];
    else if([action isEqualToString:@"isInitialized"])
        [self isInitialized :successCallback :errorCallback];
    else if([action isEqualToString:@"stopLivenessProcessing"])
        [self stopLivenessProcessing :successCallback :errorCallback];
    else if([action isEqualToString:@"setRequestHeaders"])
        [self setRequestHeaders :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"presentFaceCaptureActivityWithConfig"])
        [self presentFaceCaptureActivityWithConfig :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"startLivenessWithConfig"])
        [self startLivenessWithConfig :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"setServiceUrl"])
        [self setServiceUrl :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"matchFaces"])
        [self matchFaces :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"detectFaces"])
        [self detectFaces :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"matchFacesWithConfig"])
        [self matchFacesWithConfig :[args objectAtIndex:0] :[args objectAtIndex:1] :successCallback :errorCallback];
    else if([action isEqualToString:@"setLanguage"])
        [self setLanguage :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"matchFacesSimilarityThresholdSplit"])
        [self matchFacesSimilarityThresholdSplit :[args objectAtIndex:0] :[args objectAtIndex:1] :successCallback :errorCallback];
    else
        [self result:[NSString stringWithFormat:@"%@/%@", @"method not implemented: ", action] :errorCallback];
}

- (void) getServiceUrl:(Callback)successCallback :(Callback)errorCallback{
    [self result:[RFSFaceSDK.service serviceURL] :successCallback];
}

NSDictionary* headers;
- (void) setRequestHeaders:(NSDictionary*)headers :(Callback)successCallback :(Callback)errorCallback {
    self.headers = headers;
    RFSFaceSDK.service.requestInterceptingDelegate = self;
    [self result:@"" :successCallback];
}

- (void) startLiveness:(Callback)successCallback :(Callback)errorCallback{
    dispatch_async(dispatch_get_main_queue(), ^{
        [RFSFaceSDK.service startLivenessFrom:[[[UIApplication sharedApplication] keyWindow] rootViewController] animated:true onLiveness:[self getLivenessCompletion:successCallback :errorCallback] completion:nil];
    });
}

- (void) getFaceSdkVersion:(Callback)successCallback :(Callback)errorCallback{
    [self result:[RFSFaceSDK.service version] :successCallback];
}

- (void) init:(Callback)successCallback :(Callback)errorCallback{
    [RFSFaceSDK.service initializeWithCompletion:^(BOOL success, NSError * _Nullable error) {
        if(success)
            [RFSFaceSDK.service setVideoUploadingDelegate:self];
        [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateInitCompletion:success :error]] :successCallback];
    }];
}

- (void) deinit:(Callback)successCallback :(Callback)errorCallback{
    [RFSFaceSDK.service deinitialize];
    [self result:@"" :successCallback];
}

- (void) isInitialized:(Callback)successCallback :(Callback)errorCallback {
    [self result:@"isInitialized() is an android-only method" :errorCallback];
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
        if([config valueForKey:@"copyright"] != nil)
            [builder setCopyright:[[config valueForKey:@"copyright"] boolValue]];
        if([config valueForKey:@"cameraSwitchEnabled"] != nil)
            [builder setCameraSwitchButtonEnabled:[[config valueForKey:@"cameraSwitchEnabled"] boolValue]];
        if([config valueForKey:@"cameraPositionIOS"] != nil)
            [builder setCameraPosition:[self RFSCameraPositionWithNSInteger:[[config valueForKey:@"cameraPositionIOS"] integerValue]]];
        if([config valueForKey:@"timeout"] != nil)
            [builder setTimeoutInterval:[config valueForKey:@"timeout"]];
        if([config valueForKey:@"torchButtonEnabled"] != nil)
            [builder setTorchButtonEnabled:[self RFSCameraPositionWithNSInteger:[[config valueForKey:@"torchButtonEnabled"] integerValue]]];
        if([config valueForKey:@"closeButtonEnabled"] != nil)
            [builder setCloseButtonEnabled:[self RFSCameraPositionWithNSInteger:[[config valueForKey:@"closeButtonEnabled"] integerValue]]];
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [RFSFaceSDK.service presentFaceCaptureViewControllerFrom:[[[UIApplication sharedApplication] keyWindow] rootViewController] animated:true configuration: configuration onCapture:[self getFaceCaptureCompletion:successCallback :errorCallback] completion:nil];
    });
}

- (void) startLivenessWithConfig:(NSDictionary*)config :(Callback)successCallback :(Callback)errorCallback{
    RFSLivenessConfiguration *configuration = [RFSLivenessConfiguration configurationWithBuilder:^(RFSLivenessConfigurationBuilder  * _Nonnull builder) {
        if([config valueForKey:@"copyright"] != nil)
            [builder setCopyright:[[config valueForKey:@"copyright"] boolValue]];
        if([config valueForKey:@"attemptsCount"] != nil)
            [builder setAttemptsCount:[[config valueForKey:@"attemptsCount"] integerValue]];
        if([config valueForKey:@"locationTrackingEnabled"] != nil)
            [builder setLocationTrackingEnabled:[[config valueForKey:@"locationTrackingEnabled"] boolValue]];
        if([config valueForKey:@"recordingProcess"] != nil)
            [builder setRecordingProcessEnabled:[[config valueForKey:@"recordingProcess"] boolValue]];
        if([config valueForKey:@"closeButtonEnabled"] != nil)
            [builder setCloseButtonEnabled:[self RFSCameraPositionWithNSInteger:[[config valueForKey:@"closeButtonEnabled"] integerValue]]];
        if([config valueForKey:@"sessionId"] != nil)
            [builder setSessionId:[config valueForKey:@"sessionId"]];
        if([config valueForKey:@"skipStep"] != nil) {
            [builder setStepSkippingMask:[self RFSLivenessStepSkipWithNSInteger:[[config valueForKey:@"skipStep"] integerValue]]];
        }
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

- (void) detectFaces:(NSString*)requestString :(Callback)successCallback :(Callback)errorCallback{
    [RFSFaceSDK.service detectFacesByRequest:[RFSWJSONConstructor RFSDetectFacesRequestFromJSON:[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL]] completion:[self getDetectFacesCompletion:successCallback :errorCallback]];
}

- (void) matchFacesWithConfig:(NSString*)requestString :(NSDictionary*)config :(Callback)successCallback :(Callback)errorCallback{
    [RFSFaceSDK.service matchFaces:[RFSWJSONConstructor RFSMatchFacesRequestFromJSON:[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL]] completion:[self getMatchFacesCompletion:successCallback :errorCallback]];
}

- (void) matchFacesSimilarityThresholdSplit:(NSString*)str :(NSNumber*)similarity :(Callback)successCallback :(Callback)errorCallback{
    NSArray *array = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSArray<RFSMatchFacesComparedFacesPair *> *faces = [RFSWJSONConstructor NSArrayRFSMatchFacesComparedFacesPairFromJSON:array];
    RFSMatchFacesSimilarityThresholdSplit *split = [RFSMatchFacesSimilarityThresholdSplit splitPairs:faces bySimilarityThreshold:similarity];
    [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateRFSMatchFacesSimilarityThresholdSplit:split]] :successCallback];
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

- (void (^)(RFSDetectFacesResponse* _Nonnull)) getDetectFacesCompletion:(Callback)successCallback :(Callback)errorCallback {
    return ^(RFSDetectFacesResponse* response) {
        [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateRFSDetectFacesResponse:response]] :successCallback];
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

-(RFSLivenessStepSkip)RFSLivenessStepSkipWithNSInteger:(NSInteger)value {
    switch(value){
        case 0:
            return RFSLivenessStepSkipNone;
        case 1:
            return RFSLivenessStepSkipOnboarding;
        case 2:
            return RFSLivenessStepSkipSuccess;
        default:
            return RFSLivenessStepSkipNone;
    }
}

-(unsigned int)intFromHexString:(NSString *)hexStr {
    unsigned int hexInt = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexInt];

    return hexInt;
}

-(UIColor *)getUIColorObjectFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha {
    unsigned int hexInt = [self intFromHexString:hexStr];

    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexInt & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexInt & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexInt & 0xFF))/255
                    alpha:alpha];

    return color;
}

- (NSURLRequest*)interceptorPrepareRequest:(NSURLRequest*)request {
    NSMutableURLRequest *interceptedRequest = [request mutableCopy];
    for(NSString* key in self.headers.allKeys)
        [interceptedRequest addValue:key forHTTPHeaderField:[self.headers valueForKey:key]];
    return interceptedRequest;
}

// Delegates

// RFSVideoUploadingDelegate
- (void)videoUploadingForTransactionId:(NSString * _Nonnull)transactionId didFinishedWithSuccess:(BOOL)success {
    sendVideoEncoderCompletion(transactionId, success);
}

@end
