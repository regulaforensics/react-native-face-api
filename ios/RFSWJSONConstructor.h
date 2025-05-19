#ifndef RFSWJSONConstructor_h
#define RFSWJSONConstructor_h

#import <FaceSDK/FaceSDK.h>
#import "RFSWConfig.h"

@interface RFSWJSONConstructor : NSObject

+(NSString* _Nullable)toSendable:(id _Nullable)input;
+(id _Nonnull)generateArray:(NSArray* _Nullable)input :(SEL _Nonnull)toJson;
+(id _Nullable)arrayFromJSON:(NSArray* _Nullable)input :(SEL _Nonnull)fromJson;
+(id _Nullable)base64Encode:(NSData* _Nullable)input;
+(id _Nullable)imageWithBase64:(NSString* _Nullable)input;

+(UIFont* _Nonnull)fontFromJSON:(NSDictionary* _Nonnull)input;
+(RFSLivenessStepSkip)livenessStepSkipFromJSON:(NSArray<NSNumber*>* _Nonnull)input;
+(NSArray<NSNumber*>* _Nonnull)generateLivenessStepSkip:(RFSLivenessStepSkip)input;
+(RFSScreenOrientation)screenOrienrationFromJSON:(NSArray<NSNumber*>* _Nonnull)input;
+(NSArray<NSNumber*>* _Nonnull)generateScreenOrienration:(RFSScreenOrientation)input;
+(UIColor* _Nonnull)colorWithInt:(NSNumber* _Nonnull)input;

+(id _Nonnull)generateInitCompletion:(BOOL)success :(NSError* _Nullable)error;
+(id _Nonnull)generateVideoEncoderCompletion:(NSString* _Nonnull)transactionId :(BOOL)success;
+(id _Nonnull)generateComparedFacesSplit:(RFSMatchFacesSimilarityThresholdSplit* _Nonnull)input;
+(id _Nonnull)generatePersonDBResponse:(id _Nullable)data :(NSError* _Nullable)error;
+(id _Nonnull)idFromJSON:(NSDictionary* _Nonnull)input;
+(id _Nonnull)updatePersonFromJSON:(RFSPerson* _Nonnull)result :(NSDictionary* _Nonnull)json;
+(id _Nonnull)updatePersonGroupFromJSON:(RFSPersonGroup* _Nonnull)result :(NSDictionary* _Nonnull)json;


+(RFSPoint* _Nonnull)pointFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generatePoint:(RFSPoint* _Nonnull)input;

+(CGRect)rectFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateRect:(CGRect)input;

+(CGSize)sizeFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateSize:(CGSize)input;

+(RFSOutputImageCrop* _Nonnull)outputImageCropFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateOutputImageCrop:(RFSOutputImageCrop* _Nonnull)input;

+(RFSOutputImageParams* _Nonnull)outputImageParamsFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateOutputImageParams:(RFSOutputImageParams* _Nonnull)input;

+(RFSImageQualityRange* _Nonnull)imageQualityRangeFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateImageQualityRange:(RFSImageQualityRange* _Nonnull)input;

+(RFSImageQualityResult* _Nonnull)imageQualityResultFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateImageQualityResult:(RFSImageQualityResult* _Nonnull)input;

+(RFSImageQualityCharacteristic* _Nonnull)imageQualityCharacteristicFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateImageQualityCharacteristic:(RFSImageQualityCharacteristic* _Nonnull)input;

+(RFSFaceSDKVersion* _Nonnull)faceSDKVersionFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateFaceSDKVersion:(RFSFaceSDKVersion* _Nonnull)input;

+(RFSInitializationConfiguration* _Nonnull)initConfigFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateInitConfig:(RFSInitializationConfiguration* _Nonnull)input;

+(RFSDetectFacesAttributeResult* _Nonnull)detectFacesAttributeResultFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateDetectFacesAttributeResult:(RFSDetectFacesAttributeResult* _Nonnull)input;

+(RFSDetectFaceResult* _Nonnull)detectFaceResultFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateDetectFaceResult:(RFSDetectFaceResult* _Nonnull)input;

+(RFSDetectFacesConfiguration* _Nonnull)detectFacesConfigFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateDetectFacesConfig:(RFSDetectFacesConfiguration* _Nonnull)input;

+(RFSDetectFacesRequest* _Nonnull)detectFacesRequestFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateDetectFacesRequest:(RFSDetectFacesRequest* _Nonnull)input;

+(RFSDetectFacesResponse* _Nonnull)detectFacesResponseFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateDetectFacesResponse:(RFSDetectFacesResponse* _Nonnull)input;

+(RFSImage* _Nonnull)faceCaptureImageFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateFaceCaptureImage:(RFSImage* _Nonnull)input;

+(RFSFaceCaptureResponse* _Nonnull)faceCaptureResponseFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateFaceCaptureResponse:(RFSFaceCaptureResponse* _Nonnull)input;

+(RFSLivenessResponse* _Nonnull)livenessResponseFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateLivenessResponse:(RFSLivenessResponse* _Nonnull)input;

+(id _Nonnull)generateLivenessNotification:(RFSLivenessProcessStatus)status result:(RFSLivenessResponse* _Nullable)response;

+(RFSMatchFacesImage* _Nonnull)matchFacesImageFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateMatchFacesImage:(RFSMatchFacesImage* _Nonnull)input;

+(RFSMatchFacesRequest* _Nonnull)matchFacesRequestFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateMatchFacesRequest:(RFSMatchFacesRequest* _Nonnull)input;

+(RFSMatchFacesDetectionFace* _Nonnull)matchFacesDetectionFaceFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateMatchFacesDetectionFace:(RFSMatchFacesDetectionFace* _Nonnull)input;

+(RFSMatchFacesDetection* _Nonnull)matchFacesDetectionFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateMatchFacesDetection:(RFSMatchFacesDetection* _Nonnull)input;

+(RFSMatchFacesComparedFace* _Nonnull)comparedFaceFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateComparedFace:(RFSMatchFacesComparedFace* _Nonnull)input;

+(RFSMatchFacesComparedFacesPair* _Nonnull)comparedFacesPairFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateComparedFacesPair:(RFSMatchFacesComparedFacesPair* _Nonnull)input;

+(RFSMatchFacesResponse* _Nonnull)matchFacesResponseFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateMatchFacesResponse:(RFSMatchFacesResponse* _Nonnull)input;

+(RFSEditGroupPersonsRequest* _Nonnull)editGroupPersonsRequestFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateEditGroupPersonsRequest:(RFSEditGroupPersonsRequest* _Nonnull)input;

+(RFSImageUpload* _Nonnull)imageUploadFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateImageUpload:(RFSImageUpload* _Nonnull)input;

+(RFSPerson* _Nonnull)personFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generatePerson:(RFSPerson* _Nonnull)input;

+(RFSPersonGroup* _Nonnull)personGroupFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generatePersonGroup:(RFSPersonGroup* _Nonnull)input;

+(RFSPersonImage* _Nonnull)personImageFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generatePersonImage:(RFSPersonImage* _Nonnull)input;

+(RFSSearchPersonDetection* _Nonnull)searchPersonDetectionFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateSearchPersonDetection:(RFSSearchPersonDetection* _Nonnull)input;

+(RFSSearchPersonImage* _Nonnull)searchPersonImageFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateSearchPersonImage:(RFSSearchPersonImage* _Nonnull)input;

+(RFSSearchPerson* _Nonnull)searchPersonFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateSearchPerson:(RFSSearchPerson* _Nonnull)input;

+(RFSSearchPersonRequest* _Nonnull)searchPersonRequestFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateSearchPersonRequest:(RFSSearchPersonRequest* _Nonnull)input;

@end
#endif
