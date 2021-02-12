#ifndef JSONConstructor_h
#define JSONConstructor_h

@import UIKit;
@import FaceSDK;

@interface JSONConstructor : NSObject

+(NSString* _Nonnull)dictToString:(NSMutableDictionary* _Nonnull)input;
+(NSMutableDictionary* _Nonnull)generateRGLLivenessParams:(RGLLivenessParams* _Nonnull)input;
+(NSMutableDictionary* _Nonnull)generateRGLLivenessResponse:(RGLLivenessResponse* _Nonnull)input;
+(NSMutableDictionary* _Nonnull)generateRGLFaceCaptureResponse:(RGLFaceCaptureResponse* _Nonnull)input;
+(NSMutableDictionary* _Nonnull)generateRGLMatchFacesResponse:(RGLMatchFacesResponse* _Nonnull)input;
+(RGLMatchFacesRequest* _Nonnull)RGLMatchFacesRequestFromJSON:(NSDictionary* _Nonnull)input;

@end
#endif
