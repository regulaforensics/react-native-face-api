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
    else if([action isEqualToString:@"presentFaceCaptureActivityByCameraId"])
        [self presentFaceCaptureActivityByCameraId :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"startLivenessByCameraId"])
        [self startLivenessByCameraId :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"setServiceUrl"])
        [self setServiceUrl :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"matchFaces"])
        [self matchFaces :[args objectAtIndex:0] :successCallback :errorCallback];
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

- (void) presentFaceCaptureActivityByCameraId:(NSNumber*)cameraId : (Callback)successCallback :(Callback)errorCallback{
    [self result:@"this is an android-only method" :errorCallback];
}

- (void) startLivenessByCameraId:(NSNumber*)cameraId : (Callback)successCallback :(Callback)errorCallback{
    [self result:@"this is an android-only method" :errorCallback];
}

- (void) setServiceUrl:(NSString*)url : (Callback)successCallback :(Callback)errorCallback{
    [RFSFaceSDK.service setServiceURL:url];
    [self result:@"" :successCallback];
}

- (void) matchFaces:(NSString*)requestString : (Callback)successCallback :(Callback)errorCallback{
    [RFSFaceSDK.service matchFaces:[RFSJSONConstructor RFSMatchFacesRequestFromJSON:[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL]] completion:[self getMatchFacesCompletion:successCallback :errorCallback]];
}

- (void (^)(RFSLivenessResponse * _Nonnull)) getLivenessCompletion:(Callback)successCallback :(Callback)errorCallback {
    return ^(RFSLivenessResponse* response) {
        [self result:[RFSJSONConstructor dictToString:[RFSJSONConstructor generateRFSLivenessResponse:response]] :successCallback];
    };
}

- (void (^)(RFSFaceCaptureResponse * _Nonnull)) getFaceCaptureCompletion:(Callback)successCallback :(Callback)errorCallback {
    return ^(RFSFaceCaptureResponse* response) {
        [self result:[RFSJSONConstructor dictToString:[RFSJSONConstructor generateRFSFaceCaptureResponse:response]] :successCallback];
    };
}

- (void (^)(RFSMatchFacesResponse * _Nonnull)) getMatchFacesCompletion:(Callback)successCallback :(Callback)errorCallback {
    return ^(RFSMatchFacesResponse* response) {
        [self result:[RFSJSONConstructor dictToString:[RFSJSONConstructor generateRFSMatchFacesResponse:response]] :successCallback];
    };
}

@end
