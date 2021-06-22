#ifndef JSONConstructor_h
#define JSONConstructor_h

@import UIKit;
@import FaceSDK;

@interface JSONConstructor : NSObject

+(NSString* _Nonnull)dictToString:(NSMutableDictionary* _Nonnull)input;
+(RGLMatchFacesRequest* _Nonnull)RGLMatchFacesRequestFromJSON:(NSDictionary* _Nonnull)input;
+(NSMutableDictionary* _Nonnull)generateRFSLivenessResponse:(RFSLivenessResponse* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateNSError:(NSError* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSFaceCaptureResponse:(RFSFaceCaptureResponse* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSImage:(RFSImage* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesResponse:(RFSMatchFacesResponse* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSComparedFacesPair:(RFSComparedFacesPair* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSComparedFace:(RFSComparedFace* _Nullable)input;

@end
#endif