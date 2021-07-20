#import "RFSWJSONConstructor.h"

@implementation RFSWJSONConstructor

+(NSString*)dictToString:(NSMutableDictionary*)input {
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:input options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
}

// From JSON

+(RFSMatchFacesRequest*)RFSMatchFacesRequestFromJSON:(NSDictionary*)input {
    RFSMatchFacesRequest* result = [[RFSMatchFacesRequest alloc] initWithImages:[RFSWJSONConstructor NSArrayRFSImageFromJSON:[input valueForKey:@"images"]]];

    if([input valueForKey:@"customMetadata"] != nil)
        result.customMetadata = [input valueForKey:@"customMetadata"];
    if([input valueForKey:@"similarityThreshold"] != nil)
        result.similarityThreshold = [input valueForKey:@"similarityThreshold"];

    return result;
}

+(RFSImage*)RFSImageFromJSON:(NSDictionary*)input {
    RFSImage* result = [[RFSImage alloc] initWithImage:[RFSWJSONConstructor UIImageFromJSON:[input valueForKey:@"bitmap"]] type:[[input valueForKey:@"imageType"] integerValue]];

    if([input valueForKey:@"tag"] != nil)
        result.tag = [input valueForKey:@"tag"];

    return result;
}

+(UIImage*)UIImageFromJSON:(NSString*)input {
    return [UIImage imageWithData:[[NSData alloc]initWithBase64EncodedString:input options:NSDataBase64DecodingIgnoreUnknownCharacters]];
}

+(NSMutableArray<RFSImage*>*)NSArrayRFSImageFromJSON:(NSArray*)input {
    NSMutableArray<RFSImage*>* result = [[NSMutableArray alloc] init];
            for(NSDictionary* item in input)
                [result addObject:[RFSWJSONConstructor RFSImageFromJSON:item]];

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSLivenessError:(NSError* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"errorCode"] = [NSNumber numberWithInteger:[self NSIntegerWithRFSLivenessError:input.code]];
    result[@"message"] = input.localizedDescription;

    return result;
}

+(NSInteger)NSIntegerWithRFSLivenessError:(RFSLivenessError)value {
    if(value == RFSLivenessErrorCancelled)
        return (NSInteger)5;
    else if(value == RFSLivenessErrorProcessingTimeout)
        return (NSInteger)6;
    else if(value == RFSLivenessErrorProcessingFailed)
        return (NSInteger)8;
    else if(value == RFSLivenessErrorAPICallFailed)
        return (NSInteger)7;
    else if(value == RFSLivenessErrorProcessingAttemptsEnded)
        return (NSInteger)9;
    else if(value == RFSLivenessErrorNoLicense)
        return (NSInteger)4;

    return 0;
}

+(NSMutableDictionary* _Nonnull)generateRFSFaceCaptureError:(NSError* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"errorCode"] = [NSNumber numberWithInteger:[self NSIntegerWithRFSFaceCaptureError:input.code]];
    result[@"message"] = input.localizedDescription;

    return result;
}

+(NSInteger)NSIntegerWithRFSFaceCaptureError:(RFSFaceCaptureError)value {
    if(value == RFSFaceCaptureErrorCancelled)
        return (NSInteger)1;

    return 0;
}

+(NSMutableDictionary* _Nonnull)generateRFSComparedFacesPairError:(NSError* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"errorCode"] = [NSNumber numberWithInteger:[self NSIntegerWithRFSComparedFacesPairError:input.code]];
    result[@"message"] = input.localizedDescription;

    return result;
}

+(NSInteger)NSIntegerWithRFSComparedFacesPairError:(RFSComparedFacesPairError)value {
    if(value == RFSComparedFacesPairErrorImageEmpty)
        return (NSInteger)1;
    else if(value == RFSComparedFacesPairErrorFaceNotDetected)
        return (NSInteger)2;
    else if(value == RFSComparedFacesPairErrorLandmarksNotDetected)
        return (NSInteger)3;
    else if(value == RFSComparedFacesPairErrorFaceAlignerFailed)
        return (NSInteger)4;
    else if(value == RFSComparedFacesPairErrorDescriptorExtractorError)
        return (NSInteger)5;
    else if(value == RFSComparedFacesPairErrorAPICallFailed)
        return (NSInteger)6;

    return 0;
}

+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesError:(NSError* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"errorCode"] = [NSNumber numberWithInteger:[self NSIntegerWithRFSMatchFacesError:input.code]];
    result[@"message"] = input.localizedDescription;

    return result;
}

+(NSInteger)NSIntegerWithRFSMatchFacesError:(RFSMatchFacesError)value {
    if(value == RFSComparedFacesPairErrorImageEmpty)
        return (NSInteger)1;
    else if(value == RFSMatchFacesErrorFaceNotDetected)
        return (NSInteger)2;
    else if(value == RFSMatchFacesErrorLandmarksNotDetected)
        return (NSInteger)3;
    else if(value == RFSMatchFacesErrorFaceAlignerFailed)
        return (NSInteger)4;
    else if(value == RFSMatchFacesErrorDescriptorExtractorError)
        return (NSInteger)5;
    else if(value == RFSMatchFacesErrorNoLicense)
        return (NSInteger)6;
    else if(value == RFSMatchFacesErrorNotInitialized)
        return (NSInteger)7;
    else if(value == RFSMatchFacesErrorCommandNotSupported)
        return (NSInteger)8;
    else if(value == RFSMatchFacesErrorCommandParamsReadError)
        return (NSInteger)9;
    else if(value == RFSMatchFacesErrorAPICallFailed)
        return (NSInteger)10;
    else if(value == RFSMatchFacesErrorProcessingFailed)
        return (NSInteger)11;

    return 0;
}

    // To JSON

+(NSMutableDictionary* _Nonnull)generateRFSLivenessResponse:(RFSLivenessResponse* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"bitmap"] = [UIImageJPEGRepresentation(input.image, 1.0) base64EncodedStringWithOptions:0];
    result[@"liveness"] = @(input.liveness);
    result[@"exception"] = [self generateRFSLivenessError:input.error];

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSFaceCaptureResponse:(RFSFaceCaptureResponse* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"image"] = [self generateRFSImage:input.image];
    result[@"exception"] = [self generateRFSFaceCaptureError:input.error];

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSImage:(RFSImage* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"identifier"] = input.identifier;
    result[@"tag"] = input.tag;
    result[@"imageType"] = @(input.imageType);
    result[@"bitmap"] = [UIImageJPEGRepresentation(input.image, 1.0) base64EncodedStringWithOptions:0];

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesResponse:(RFSMatchFacesResponse* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"exception"] = [self generateRFSMatchFacesError:input.error];
    if(input.matchedFaces != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(RFSComparedFacesPair* item in input.matchedFaces)
            if(item != nil)
                [array addObject:[self generateRFSComparedFacesPair:item]];
        result[@"matchedFaces"] = array;
    }
    if(input.unmatchedFaces != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(RFSComparedFacesPair* item in input.unmatchedFaces)
            if(item != nil)
                [array addObject:[self generateRFSComparedFacesPair:item]];
        result[@"unmatchedFaces"] = array;
    }

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSComparedFacesPair:(RFSComparedFacesPair* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"first"] = [self generateRFSComparedFace:input.first];
    result[@"second"] = [self generateRFSComparedFace:input.second];
    result[@"similarity"] = input.similarity;
    result[@"exception"] = [self generateRFSComparedFacesPairError:input.error];

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSComparedFace:(RFSComparedFace* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"tag"] = input.tag;
    result[@"imageType"] = @(input.imageType);
    result[@"position"] = input.position;

    return result;
}

@end