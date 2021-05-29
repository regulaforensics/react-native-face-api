#ifndef JSONConstructor_h
#define JSONConstructor_h

@import UIKit;
@import FaceSDK;

@interface JSONConstructor : NSObject

+(NSString* _Nonnull)dictToString:(NSMutableDictionary* _Nonnull)input;
+(RGLMatchFacesRequest* _Nonnull)RGLMatchFacesRequestFromJSON:(NSDictionary* _Nonnull)input;
+(NSMutableDictionary* _Nonnull)generateRGLLivenessResponse:(RGLLivenessResponse* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateNSError:(NSError* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRGLFaceCaptureResponse:(RGLFaceCaptureResponse* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRGLImage:(RGLImage* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRGLMatchFacesResponse:(RGLMatchFacesResponse* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRGLComparedFacesPair:(RGLComparedFacesPair* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRGLComparedFace:(RGLComparedFace* _Nullable)input;

@end
#endif