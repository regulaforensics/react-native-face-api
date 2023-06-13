#import "RNFaceApi.h"

NSString* RFSWVideoEncoderCompletionEvent = @"videoEncoderCompletionEvent";
NSString* RFSWOnCustomButtonTappedEvent = @"onCustomButtonTappedEvent";

RNFaceApi* RFSWPlugin;

@implementation RNFaceApi
@synthesize bridge = _bridge;
RCT_EXPORT_MODULE();

- (NSArray<NSString*>*)supportedEvents {
    return @[RFSWVideoEncoderCompletionEvent,
             RFSWOnCustomButtonTappedEvent];
}

- (void)result:(NSString*)message :(RFSWCallback)callback {
    if(message == nil)
        message = @"";
    callback(message);
}

- (void)videoUploadingForTransactionId:(NSString * _Nonnull)transactionId didFinishedWithSuccess:(BOOL)success {
    [RFSWPlugin sendEventWithName:RFSWVideoEncoderCompletionEvent body:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateVideoEncoderCompletion:transactionId :success]]];
}

- (void)onCustomButtonTappedWithTag:(NSInteger)tag {
    [RFSWPlugin sendEventWithName:RFSWOnCustomButtonTappedEvent body:@{@"msg": [NSNumber numberWithInteger:tag]}];
}

RCT_EXPORT_METHOD(exec:(NSString*)moduleName:(NSString*)action:(NSArray*)args:(RCTResponseSenderBlock)sCallback:(RCTResponseSenderBlock)eCallback) {
    RFSWPlugin = self;
    RFSWCallback successCallback = ^(NSString* response){
        sCallback(@[response]);
    };
    RFSWCallback errorCallback = ^(NSString* response){
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
    else if([action isEqualToString:@"setOnCustomButtonTappedListener"])
        [self setOnCustomButtonTappedListener :successCallback :errorCallback];
    else if([action isEqualToString:@"setUiCustomizationLayer"])
        [self setUiCustomizationLayer :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"setLanguage"])
        [self setLanguage :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"matchFacesSimilarityThresholdSplit"])
        [self matchFacesSimilarityThresholdSplit :[args objectAtIndex:0] :[args objectAtIndex:1] :successCallback :errorCallback];
    else if([action isEqualToString:@"getPersons"])
        [self getPersons :successCallback :errorCallback];
    else if([action isEqualToString:@"getPersonsForPage"])
        [self getPersonsForPage :[args objectAtIndex:0] :[args objectAtIndex:1] :successCallback :errorCallback];
    else if([action isEqualToString:@"getPerson"])
        [self getPerson :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"createPerson"])
        [self createPerson :[args objectAtIndex:0] :[args objectAtIndex:1] :successCallback :errorCallback];
    else if([action isEqualToString:@"updatePerson"])
        [self updatePerson :[args objectAtIndex:0] :[args objectAtIndex:1] :[args objectAtIndex:2] :successCallback :errorCallback];
    else if([action isEqualToString:@"deletePerson"])
        [self deletePerson :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"getPersonImages"])
        [self getPersonImages :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"getPersonImagesForPage"])
        [self getPersonImagesForPage :[args objectAtIndex:0] :[args objectAtIndex:1] :[args objectAtIndex:2] :successCallback :errorCallback];
    else if([action isEqualToString:@"addPersonImage"])
        [self addPersonImage :[args objectAtIndex:0] :[args objectAtIndex:1] :successCallback :errorCallback];
    else if([action isEqualToString:@"getPersonImage"])
        [self getPersonImage :[args objectAtIndex:0] :[args objectAtIndex:1] :successCallback :errorCallback];
    else if([action isEqualToString:@"deletePersonImage"])
        [self deletePersonImage :[args objectAtIndex:0] :[args objectAtIndex:1] :successCallback :errorCallback];
    else if([action isEqualToString:@"getGroups"])
        [self getGroups :successCallback :errorCallback];
    else if([action isEqualToString:@"getGroupsForPage"])
        [self getGroupsForPage :[args objectAtIndex:0] :[args objectAtIndex:1] :successCallback :errorCallback];
    else if([action isEqualToString:@"getPersonGroups"])
        [self getPersonGroups :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"getPersonGroupsForPage"])
        [self getPersonGroupsForPage :[args objectAtIndex:0] :[args objectAtIndex:1] :[args objectAtIndex:2] :successCallback :errorCallback];
    else if([action isEqualToString:@"createGroup"])
        [self createGroup :[args objectAtIndex:0] :[args objectAtIndex:1] :successCallback :errorCallback];
    else if([action isEqualToString:@"getGroup"])
        [self getGroup :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"updateGroup"])
        [self updateGroup :[args objectAtIndex:0] :[args objectAtIndex:1] :[args objectAtIndex:2] :successCallback :errorCallback];
    else if([action isEqualToString:@"editPersonsInGroup"])
        [self editPersonsInGroup :[args objectAtIndex:0] :[args objectAtIndex:1] :successCallback :errorCallback];
    else if([action isEqualToString:@"getPersonsInGroup"])
        [self getPersonsInGroup :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"getPersonsInGroupForPage"])
        [self getPersonsInGroupForPage :[args objectAtIndex:0] :[args objectAtIndex:1] :[args objectAtIndex:2] :successCallback :errorCallback];
    else if([action isEqualToString:@"deleteGroup"])
        [self deleteGroup :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"searchPerson"])
        [self searchPerson :[args objectAtIndex:0] :successCallback :errorCallback];
    else
        [self result:[NSString stringWithFormat:@"%@/%@", @"method not implemented: ", action] :errorCallback];
}

- (void) getServiceUrl:(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [self result:[RFSFaceSDK.service serviceURL] :successCallback];
}

- (void) setRequestHeaders:(NSDictionary*)headers :(RFSWCallback)successCallback :(RFSWCallback)errorCallback {
    self.headers = headers;
    RFSFaceSDK.service.requestInterceptingDelegate = self;
    [self result:@"" :successCallback];
}

- (void) startLiveness:(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    dispatch_async(dispatch_get_main_queue(), ^{
        [RFSFaceSDK.service startLivenessFrom:[[[UIApplication sharedApplication] keyWindow] rootViewController] animated:true onLiveness:[self getLivenessCompletion:successCallback :errorCallback] completion:nil];
    });
}

- (void) getFaceSdkVersion:(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [self result:[RFSFaceSDK.service version] :successCallback];
}

- (void) init:(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service initializeWithCompletion:^(BOOL success, NSError * _Nullable error) {
        if(success)
            [RFSFaceSDK.service setVideoUploadingDelegate:self];
        [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateInitCompletion:success :error]] :successCallback];
    }];
}

- (void) deinit:(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service deinitialize];
    [self result:@"" :successCallback];
}

- (void) isInitialized:(RFSWCallback)successCallback :(RFSWCallback)errorCallback {
    [self result:@"isInitialized() is an android-only method" :errorCallback];
}

- (void) setOnCustomButtonTappedListener:(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    RFSFaceSDK.service.customization.actionDelegate = self;
    [self result:@"" :successCallback];
}

- (void) setUiCustomizationLayer:(NSDictionary*)json :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    RFSFaceSDK.service.customization.customUILayerJSON = json;
    [self result:@"" :successCallback];
}

- (void) presentFaceCaptureActivity:(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    dispatch_async(dispatch_get_main_queue(), ^{
        [RFSFaceSDK.service presentFaceCaptureViewControllerFrom:[[[UIApplication sharedApplication] keyWindow] rootViewController] animated:true onCapture:[self getFaceCaptureCompletion:successCallback :errorCallback] completion:nil];
    });
}

- (void) stopFaceCaptureActivity:(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service stopFaceCaptureViewController];
    [self result:@"" :successCallback];
}

- (void) stopLivenessProcessing:(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service stopLivenessProcessing];
    [self result:@"" :successCallback];
}

- (void) presentFaceCaptureActivityWithConfig:(NSDictionary*)config :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
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
            [builder setTorchButtonEnabled:[[config valueForKey:@"torchButtonEnabled"] boolValue]];
        if([config valueForKey:@"closeButtonEnabled"] != nil)
            [builder setCloseButtonEnabled:[[config valueForKey:@"closeButtonEnabled"] boolValue]];
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [RFSFaceSDK.service presentFaceCaptureViewControllerFrom:[[[UIApplication sharedApplication] keyWindow] rootViewController] animated:true configuration: configuration onCapture:[self getFaceCaptureCompletion:successCallback :errorCallback] completion:nil];
    });
}

- (void) startLivenessWithConfig:(NSDictionary*)config :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
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
        if([config valueForKey:@"tag"] != nil)
            [builder setTag:[config valueForKey:@"tag"]];
        if([config valueForKey:@"skipStep"] != nil) {
            [builder setStepSkippingMask:[self RFSLivenessStepSkipsWithIntegerArray:[config valueForKey:@"skipStep"]]];
        }
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [RFSFaceSDK.service startLivenessFrom:[[[UIApplication sharedApplication] keyWindow] rootViewController] animated:true configuration: configuration onLiveness:[self getLivenessCompletion:successCallback :errorCallback] completion:nil];
    });
}

- (void) setServiceUrl:(NSString*)url :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service setServiceURL:url];
    [self result:@"" :successCallback];
}

- (void) matchFaces:(NSString*)requestString :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service matchFaces:[RFSWJSONConstructor RFSMatchFacesRequestFromJSON:[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL]] completion:[self getMatchFacesCompletion:successCallback :errorCallback]];
}

- (void) detectFaces:(NSString*)requestString :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service detectFacesByRequest:[RFSWJSONConstructor RFSDetectFacesRequestFromJSON:[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL]] completion:[self getDetectFacesCompletion:successCallback :errorCallback]];
}

- (void) matchFacesWithConfig:(NSString*)requestString :(NSDictionary*)config :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service matchFaces:[RFSWJSONConstructor RFSMatchFacesRequestFromJSON:[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL]] completion:[self getMatchFacesCompletion:successCallback :errorCallback]];
}

- (void) matchFacesSimilarityThresholdSplit:(NSString*)str :(NSNumber*)similarity :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    NSArray *array = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSArray<RFSMatchFacesComparedFacesPair *> *faces = [RFSWJSONConstructor NSArrayRFSMatchFacesComparedFacesPairFromJSON:array];
    RFSMatchFacesSimilarityThresholdSplit *split = [RFSMatchFacesSimilarityThresholdSplit splitPairs:faces bySimilarityThreshold:similarity];
    [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateRFSMatchFacesSimilarityThresholdSplit:split]] :successCallback];
}

- (void) setLanguage:(NSString*)language :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    RFSFaceSDK.service.localizationHandler = ^NSString * _Nullable(NSString * _Nonnull localizationKey) {
        NSString *result = NSLocalizedStringFromTable(localizationKey, language, @"");
        if (![result isEqualToString:localizationKey])
            return result;
        return nil;
    };
    [self result:@"" :successCallback];
}

- (void (^)(RFSLivenessResponse * _Nonnull)) getLivenessCompletion:(RFSWCallback)successCallback :(RFSWCallback)errorCallback {
    return ^(RFSLivenessResponse* response) {
        [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateRFSLivenessResponse:response]] :successCallback];
    };
}

- (void (^)(RFSFaceCaptureResponse * _Nonnull)) getFaceCaptureCompletion:(RFSWCallback)successCallback :(RFSWCallback)errorCallback {
    return ^(RFSFaceCaptureResponse* response) {
        [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateRFSFaceCaptureResponse:response]] :successCallback];
    };
}

- (void (^)(RFSMatchFacesResponse * _Nonnull)) getMatchFacesCompletion:(RFSWCallback)successCallback :(RFSWCallback)errorCallback {
    return ^(RFSMatchFacesResponse* response) {
        [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateRFSMatchFacesResponse:response]] :successCallback];
    };
}

- (void (^)(RFSDetectFacesResponse* _Nonnull)) getDetectFacesCompletion:(RFSWCallback)successCallback :(RFSWCallback)errorCallback {
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

-(RFSLivenessStepSkip)RFSLivenessStepSkipsWithIntegerArray:(NSArray<NSNumber*>*)input {
    // same as input.contains(1)
    bool start = CFArrayContainsValue((__bridge CFArrayRef)input, CFRangeMake(0, input.count), (CFNumberRef)@1);
    bool done = CFArrayContainsValue((__bridge CFArrayRef)input, CFRangeMake(0, input.count), (CFNumberRef)@2);

    if(start && !done){
        NSLog(@"START");
        return RFSLivenessStepSkipOnboarding;
    }
    if(done && !start){
        NSLog(@"DONE");
        return RFSLivenessStepSkipSuccess;
    }
    if(start && done){
        NSLog(@"BOTH");
        return RFSLivenessStepSkipOnboarding | RFSLivenessStepSkipSuccess;
    }
    return RFSLivenessStepSkipNone;
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

- (void) getPersons:(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service.personDatabase getPersons:^(RFSPageResponse<RFSPerson *> * response) {
        if(response.error != nil)
            [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateRFSPagePersonResponse:response]] :successCallback];
        else
            [self result:[RFSWJSONConstructor generateNSError:response.error] :errorCallback];
    }];
}

- (void) getPersonsForPage:(NSNumber*)page :(NSNumber*)size :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service.personDatabase getPersonsForPage:[page integerValue] size:[size integerValue] completion:^(RFSPageResponse<RFSPerson *> * response) {
        if(response.error != nil)
            [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateRFSPagePersonResponse:response]] :successCallback];
        else
            [self result:[RFSWJSONConstructor generateNSError:response.error] :errorCallback];
    }];
}

- (void) getPerson:(NSNumber*)personId :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service.personDatabase getPersonByPersonId:[personId integerValue] completion:^(RFSItemResponse<RFSPerson *> * response) {
        if(response.error != nil)
            [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateRFSPerson:response.item]] :successCallback];
        else
            [self result:[RFSWJSONConstructor generateNSError:response.error] :errorCallback];
    }];
}

- (void) createPerson:(NSString*)name :(NSDictionary*)metadata :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service.personDatabase createPersonWithName:name metadata:metadata completion:^(RFSItemResponse<RFSPerson *> * response) {
        if(response.error == nil)
            [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateRFSPerson:response.item]] :successCallback];
        else
            [self result:[RFSWJSONConstructor generateNSError:response.error] :errorCallback];
    }];
}

- (void) updatePerson:(NSNumber*)personId :(NSString*)name :(NSDictionary*)metadata :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service.personDatabase updatePersonByPersonId:[personId integerValue] name:name metadata:metadata completion:^(RFSComfirmResponse * success) {
        if(success)
            [self result:@"" :successCallback];
        else
            [self result:@"" :errorCallback];
    }];
}

- (void) deletePerson:(NSNumber*)personId :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service.personDatabase deletePersonByPersonId:[personId integerValue] completion:^(RFSComfirmResponse * success) {
        if(success)
            [self result:@"" :successCallback];
        else
            [self result:@"" :errorCallback];
    }];
}

- (void) getPersonImages:(NSNumber*)personId :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service.personDatabase getPersonImagesByPersonId:[personId integerValue] completion:^(RFSPageResponse<RFSPersonImage *> * response) {
        if(response.error != nil)
            [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateRFSPagePersonImageResponse:response]] :successCallback];
        else
            [self result:[RFSWJSONConstructor generateNSError:response.error] :errorCallback];
    }];
}

- (void) getPersonImagesForPage:(NSNumber*)personId :(NSNumber*)page :(NSNumber*)size :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service.personDatabase getPersonImagesByPersonId:[personId integerValue] page:[page integerValue] size:[size integerValue] completion:^(RFSPageResponse<RFSPersonImage *> * response) {
        if(response.error != nil)
            [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateRFSPagePersonImageResponse:response]] :successCallback];
        else
            [self result:[RFSWJSONConstructor generateNSError:response.error] :errorCallback];
    }];
}

- (void) addPersonImage:(NSNumber*)personId :(NSDictionary*)image :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    RFSImageUpload *imageUpload = [RFSWJSONConstructor RFSImageUploadFromJSON:image];
    [RFSFaceSDK.service.personDatabase addPersonImageByPersonId:[personId integerValue] imageUpload:imageUpload completion:^(RFSItemResponse<RFSPersonImage *> * response) {
        if(response.error != nil)
            [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateRFSPersonImage:response.item]] :successCallback];
        else
            [self result:[RFSWJSONConstructor generateNSError:response.error] :errorCallback];
    }];
}

- (void) getPersonImage:(NSNumber*)personId :(NSNumber*)imageId :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service.personDatabase getPersonImageByPersonId:[personId integerValue] imageId:[imageId integerValue] completion:^(RFSDataResponse* response) {
        if(response.error != nil)
            [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateNSDataImage:response.data]] :successCallback];
        else
            [self result:[RFSWJSONConstructor generateNSError:response.error] :errorCallback];
    }];
}

- (void) deletePersonImage:(NSNumber*)personId :(NSNumber*)imageId :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service.personDatabase deletePersonImageByPersonId:[personId integerValue] imageId: [imageId integerValue] completion:^(RFSComfirmResponse * success) {
        if(success)
            [self result:@"" :successCallback];
        else
            [self result:@"" :errorCallback];
    }];
}

- (void) getGroups:(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service.personDatabase getGroups:^(RFSPageResponse<RFSPersonGroup *> * response) {
        if(response.error != nil)
            [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateRFSPagePersonGroupResponse:response]] :successCallback];
        else
            [self result:[RFSWJSONConstructor generateNSError:response.error] :errorCallback];
    }];
}

- (void) getGroupsForPage:(NSNumber*)page :(NSNumber*)size :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service.personDatabase getGroupsForPage:[page integerValue] size:[size integerValue] completion:^(RFSPageResponse<RFSPersonGroup *> * response) {
        if(response.error != nil)
            [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateRFSPagePersonGroupResponse:response]] :successCallback];
        else
            [self result:[RFSWJSONConstructor generateNSError:response.error] :errorCallback];
    }];
}

- (void) getPersonGroups:(NSNumber*)personId :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service.personDatabase getPersonGroupsByPersonId:[personId integerValue] completion:^(RFSPageResponse<RFSPersonGroup *> * response) {
        if(response.error != nil)
            [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateRFSPagePersonGroupResponse:response]] :successCallback];
        else
            [self result:[RFSWJSONConstructor generateNSError:response.error] :errorCallback];
    }];
}

- (void) getPersonGroupsForPage:(NSNumber*)personId :(NSNumber*)page :(NSNumber*)size :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service.personDatabase getPersonGroupsByPersonId:[personId integerValue] page:[page integerValue] size:[size integerValue] completion:^(RFSPageResponse<RFSPersonGroup *> * response) {
        if(response.error != nil)
            [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateRFSPagePersonGroupResponse:response]] :successCallback];
        else
            [self result:[RFSWJSONConstructor generateNSError:response.error] :errorCallback];
    }];
}

- (void) createGroup:(NSString*)name :(NSDictionary*)metadata :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service.personDatabase createGroupWithName:name metadata:metadata completion:^(RFSItemResponse<RFSPersonGroup *> * response) {
        if(response.error == nil)
            [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateRFSPersonGroup:response.item]] :successCallback];
        else
            [self result:[RFSWJSONConstructor generateNSError:response.error] :errorCallback];
    }];
}

- (void) getGroup:(NSNumber*)groupId :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service.personDatabase getGroupByGroupId:[groupId integerValue] completion:^(RFSItemResponse<RFSPersonGroup *> * response) {
        if(response.error == nil)
            [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateRFSPersonGroup:response.item]] :successCallback];
        else
            [self result:[RFSWJSONConstructor generateNSError:response.error] :errorCallback];
    }];
}

- (void) updateGroup:(NSNumber*)groupId :(NSString*)name :(NSDictionary*)metadata :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service.personDatabase updateGroupByGroupId:[groupId integerValue] name:name metadata:metadata completion:^(RFSComfirmResponse * success) {
        if(success)
            [self result:@"" :successCallback];
        else
            [self result:@"" :errorCallback];
    }];
}

- (void) editPersonsInGroup:(NSNumber*)groupId :(NSDictionary*)editGroupPersonsRequest :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    RFSEditGroupPersonsRequest *request = [RFSWJSONConstructor RFSEditGroupPersonsRequestFromJSON:editGroupPersonsRequest];
    [RFSFaceSDK.service.personDatabase editGroupPersonsByGroupId:[groupId integerValue] request:request completion:^(RFSComfirmResponse * success) {
        if(success)
            [self result:@"" :successCallback];
        else
            [self result:@"" :errorCallback];
    }];
}

- (void) getPersonsInGroup:(NSNumber*)groupId :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service.personDatabase getGroupPersonsByGroupId:[groupId integerValue] completion:^(RFSPageResponse<RFSPerson *> * response) {
        if(response.error != nil)
            [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateRFSPagePersonResponse:response]] :successCallback];
        else
            [self result:[RFSWJSONConstructor generateNSError:response.error] :errorCallback];
    }];
}

- (void) getPersonsInGroupForPage:(NSNumber*)groupId :(NSNumber*)page :(NSNumber*)size :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service.personDatabase getGroupPersonsByGroupId:[groupId integerValue] page:[page integerValue] size:[size integerValue] completion:^(RFSPageResponse<RFSPerson *> * response) {
        if(response.error != nil)
            [self result:[RFSWJSONConstructor dictToString:[RFSWJSONConstructor generateRFSPagePersonResponse:response]] :successCallback];
        else
            [self result:[RFSWJSONConstructor generateNSError:response.error] :errorCallback];
    }];
}

- (void) deleteGroup:(NSNumber*)groupId :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    [RFSFaceSDK.service.personDatabase deleteGroupByGroupId:[groupId integerValue] completion:^(RFSComfirmResponse * success) {
        if(success)
            [self result:@"" :successCallback];
        else
            [self result:@"" :errorCallback];
    }];
}

- (void) searchPerson:(NSDictionary*)searchPersonRequest :(RFSWCallback)successCallback :(RFSWCallback)errorCallback{
    RFSSearchPersonRequest *request = [RFSWJSONConstructor RFSSearchPersonRequestFromJSON:searchPersonRequest];
    [RFSFaceSDK.service.personDatabase searchPerson:request completion:^(RFSSearchPersonResponse *response) {
        if(response.error != nil) {
            NSMutableArray<NSDictionary*> *results = [NSMutableArray new];
            for(RFSSearchPerson* searchPerson in response.results)
                [results addObject:[RFSWJSONConstructor generateRFSSearchPerson:searchPerson]];
            [self result:[RFSWJSONConstructor arrayToString:results] :successCallback];
        } else
            [self result:[RFSWJSONConstructor generateNSError:response.error] :errorCallback];
    }];
}

@end
