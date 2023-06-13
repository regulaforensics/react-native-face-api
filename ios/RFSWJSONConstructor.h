#ifndef RFSWJSONConstructor_h
#define RFSWJSONConstructor_h

@import UIKit;
@import FaceSDK;

@interface RFSWJSONConstructor : NSObject

+(NSString* _Nonnull)dictToString:(NSMutableDictionary* _Nonnull)input;
+(NSString* _Nonnull)arrayToString:(NSMutableArray* _Nonnull)input;
+(NSMutableDictionary* _Nonnull)generateNSError:(NSError* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateInitCompletion:(BOOL)success :(NSError* _Nullable)error;
+(NSMutableDictionary* _Nonnull)generateVideoEncoderCompletion:(NSString * _Nonnull)transactionId :(BOOL)success;
+(RFSMatchFacesRequest* _Nonnull)RFSMatchFacesRequestFromJSON:(NSDictionary* _Nonnull)input;
+(NSMutableArray<RFSMatchFacesComparedFacesPair*>*_Nonnull)NSArrayRFSMatchFacesComparedFacesPairFromJSON:(NSArray* _Nonnull)input;
+(RFSDetectFacesRequest* _Nonnull)RFSDetectFacesRequestFromJSON:(NSDictionary* _Nonnull)input;
+(NSMutableDictionary* _Nonnull)generateNSDataImage:(NSData*_Nullable)input;
+(RFSEditGroupPersonsRequest* _Nonnull)RFSEditGroupPersonsRequestFromJSON:(NSDictionary* _Nullable)input;
+(RFSSearchPersonRequest* _Nonnull)RFSSearchPersonRequestFromJSON:(NSDictionary* _Nullable)input;
+(RFSImageUpload* _Nonnull)RFSImageUploadFromJSON:(NSDictionary* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSPagePersonResponse:(RFSPageResponse<RFSPerson *>* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSPagePersonImageResponse:(RFSPageResponse<RFSPersonImage *>* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSPagePersonGroupResponse:(RFSPageResponse<RFSPersonGroup *>* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSFaceCaptureResponse:(RFSFaceCaptureResponse* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSLivenessResponse:(RFSLivenessResponse* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesResponse:(RFSMatchFacesResponse* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSImage:(RFSImage* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesImage:(RFSMatchFacesImage* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesComparedFacesPair:(RFSMatchFacesComparedFacesPair* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesComparedFace:(RFSMatchFacesComparedFace* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesDetectionFace:(RFSMatchFacesDetectionFace* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesDetection:(RFSMatchFacesDetection* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSPoint:(RFSPoint* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesSimilarityThresholdSplit:(RFSMatchFacesSimilarityThresholdSplit* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSImageQualityRange:(RFSImageQualityRange* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSDetectFacesResponse:(RFSDetectFacesResponse* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSDetectFaceResult:(RFSDetectFaceResult* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSImageQualityResult:(RFSImageQualityResult* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSDetectFacesAttributeResult:(RFSDetectFacesAttributeResult* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSPerson:(RFSPerson* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSPersonImage:(RFSPersonImage* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSPersonGroup:(RFSPersonGroup* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSSearchPerson:(RFSSearchPerson* _Nullable)input;
+(NSMutableDictionary* _Nonnull)generateRFSSearchPersonImage:(RFSSearchPersonImage* _Nullable)input;

@end
#endif