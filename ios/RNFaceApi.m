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
    else if([action isEqualToString:@"startLivenessMatching"])
        [self startLivenessMatching :successCallback :errorCallback];
    else if([action isEqualToString:@"getFaceSdkVersion"])
        [self getFaceSdkVersion :successCallback :errorCallback];
    else if([action isEqualToString:@"livenessParams"])
        [self livenessParams :successCallback :errorCallback];
    else if([action isEqualToString:@"presentFaceCaptureActivity"])
        [self presentFaceCaptureActivity :successCallback :errorCallback];
    else if([action isEqualToString:@"stopFaceCaptureActivity"])
        [self stopFaceCaptureActivity :successCallback :errorCallback];
    else if([action isEqualToString:@"stopLivenessProcessing"])
        [self stopLivenessProcessing :successCallback :errorCallback];
    else if([action isEqualToString:@"presentFaceCaptureActivityByCameraId"])
        [self presentFaceCaptureActivityByCameraId :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"startLivenessMatchingByCameraId"])
        [self startLivenessMatchingByCameraId :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"setServiceUrl"])
        [self setServiceUrl :[args objectAtIndex:0] :successCallback :errorCallback];
    else if([action isEqualToString:@"matchFaces"])
        [self matchFaces :[args objectAtIndex:0] :successCallback :errorCallback];
    else
        [self result:[NSString stringWithFormat:@"%@/%@", @"method not implemented: ", action] :errorCallback];
}

- (void) getServiceUrl:(Callback)successCallback :(Callback)errorCallback{
    [self result:[RGLFace.service serviceURL] :successCallback];
}

- (void) startLivenessMatching:(Callback)successCallback :(Callback)errorCallback{
    dispatch_async(dispatch_get_main_queue(), ^{
        [RGLFace.service startLivenessFrom:[[[UIApplication sharedApplication] keyWindow] rootViewController] animated:true onLiveness:[self getLivenessCompletion:successCallback :errorCallback] completion:nil];
    });
}

- (void) getFaceSdkVersion:(Callback)successCallback :(Callback)errorCallback{
    [self result:[RGLFace.service version] :successCallback];
}

- (void) livenessParams:(Callback)successCallback :(Callback)errorCallback{
    [self result:[JSONConstructor dictToString:[JSONConstructor generateRGLLivenessParams:RGLFace.service.livenessParams]] :errorCallback];
}

- (void) presentFaceCaptureActivity:(Callback)successCallback :(Callback)errorCallback{
    dispatch_async(dispatch_get_main_queue(), ^{
        [RGLFace.service presentFaceCaptureViewControllerFrom:[[[UIApplication sharedApplication] keyWindow] rootViewController] animated:true onCapture:[self getFaceCaptureCompletion:successCallback :errorCallback] completion:nil];
    });
}

- (void) stopFaceCaptureActivity:(Callback)successCallback :(Callback)errorCallback{
    [RGLFace.service stopFaceCaptureViewController];
    [self result:@"" :successCallback];
}

- (void) stopLivenessProcessing:(Callback)successCallback :(Callback)errorCallback{
    [RGLFace.service stopLivenessProcessing];
    [self result:@"" :successCallback];
}

- (void) presentFaceCaptureActivityByCameraId:(NSNumber*)cameraId : (Callback)successCallback :(Callback)errorCallback{
    [self result:@"this is an android-only method" :errorCallback];
}

- (void) startLivenessMatchingByCameraId:(NSNumber*)cameraId : (Callback)successCallback :(Callback)errorCallback{
    [self result:@"this is an android-only method" :errorCallback];
}

- (void) setServiceUrl:(NSString*)url : (Callback)successCallback :(Callback)errorCallback{
    [RGLFace.service setServiceURL:url];
    [self result:@"" :successCallback];
}

- (void) matchFaces:(NSString*)requestString : (Callback)successCallback :(Callback)errorCallback{
    [RGLFace.service matchFaces:[JSONConstructor RGLMatchFacesRequestFromJSON:[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL]] completion:[self getMatchFacesCompletion:successCallback :errorCallback]];
}

- (void (^)(RGLLivenessResponse * _Nonnull)) getLivenessCompletion:(Callback)successCallback :(Callback)errorCallback {
    return ^(RGLLivenessResponse* response) {
        [self result:[JSONConstructor dictToString:[JSONConstructor generateRGLLivenessResponse:response]] :successCallback];
    };
}

- (void (^)(RGLFaceCaptureResponse * _Nonnull)) getFaceCaptureCompletion:(Callback)successCallback :(Callback)errorCallback {
    return ^(RGLFaceCaptureResponse* response) {
        [self result:[JSONConstructor dictToString:[JSONConstructor generateRGLFaceCaptureResponse:response]] :successCallback];
    };
}

- (void (^)(RGLMatchFacesResponse * _Nonnull)) getMatchFacesCompletion:(Callback)successCallback :(Callback)errorCallback {
    return ^(RGLMatchFacesResponse* response) {
        [self result:[JSONConstructor dictToString:[JSONConstructor generateRGLMatchFacesResponse:response]] :successCallback];
    };
}

@end
