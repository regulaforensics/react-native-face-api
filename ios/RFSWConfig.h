#ifndef RFSWConfig_h
#define RFSWConfig_h

#import <FaceSDK/FaceSDK.h>
#import "RFSWJSONConstructor.h"

@interface RFSWConfig : NSObject

+(RFSFaceCaptureConfiguration* _Nonnull)faceCaptureConfigFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateFaceCaptureConfig:(RFSFaceCaptureConfiguration* _Nonnull)input;

+(RFSLivenessConfiguration* _Nonnull)livenessConfigFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateLivenessConfig:(RFSLivenessConfiguration* _Nonnull)input;

+(RFSMatchFacesConfiguration* _Nonnull)matchFacesConfigFromJSON:(id _Nonnull)input;
+(NSDictionary<NSString*, id>* _Nonnull)generateMatchFacesConfig:(RFSMatchFacesConfiguration* _Nonnull)input;


+(void)setCustomization:(NSDictionary* _Nonnull)config :(RFSCustomization* _Nonnull)result;

+(RFSImageQualityCharacteristic* _Nonnull)imageQualityCharacteristicWithName:(NSString* _Nonnull)name
                                                            recommendedRange:(NSArray<NSNumber*>* _Nullable)recommendedRange
                                                                 customRange:(NSArray* _Nullable)customRange
                                                                       color:(UIColor* _Nullable)color;

@end
#endif
