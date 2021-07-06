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

    // To JSON

+(NSMutableDictionary* _Nonnull)generateRFSLivenessResponse:(RFSLivenessResponse* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"bitmap"] = [UIImageJPEGRepresentation(input.image, 1.0) base64EncodedStringWithOptions:0];
    result[@"liveness"] = @(input.liveness);
    result[@"error"] = [self generateNSError:input.error];

    return result;
}

+(NSMutableDictionary* _Nonnull)generateNSError:(NSError* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"code"] = @(input.code);
    result[@"localizedDescription"] = input.localizedDescription;

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSFaceCaptureResponse:(RFSFaceCaptureResponse* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"image"] = [self generateRFSImage:input.image];
    result[@"error"] = [self generateNSError:input.error];

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

    result[@"error"] = [self generateNSError:input.error];
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
    result[@"error"] = [self generateNSError:input.error];

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