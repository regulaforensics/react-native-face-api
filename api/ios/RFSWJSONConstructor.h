#ifndef RFSWJSONConstructor_h
#define RFSWJSONConstructor_h

@import UIKit;
@import FaceSDK;

@interface RFSWJSONConstructor : NSObject

+(NSString* _Nonnull)dictToString:(NSMutableDictionary* _Nonnull)input;
+(RFSMatchFacesRequest* _Nonnull)RFSMatchFacesRequestFromJSON:(NSDictionary* _Nonnull)input;
+(NSMutableDictionary* _Nonnull)generateRFSLivenessResponse:(RFSLivenessResponse* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSFaceCaptureResponse:(RFSFaceCaptureResponse* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSImage:(RFSImage* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesImage:(RFSMatchFacesImage* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesResponse:(RFSMatchFacesResponse* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesComparedFacesPair:(RFSMatchFacesComparedFacesPair* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesComparedFace:(RFSMatchFacesComparedFace* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesDetectionFace:(RFSMatchFacesDetectionFace* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSPoint:(RFSPoint* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateNSError:(NSError* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesDetection:(RFSMatchFacesDetection* _Nullable)input;

@end
#endif