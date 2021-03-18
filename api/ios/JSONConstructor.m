#import "JSONConstructor.h"

@implementation JSONConstructor

+(NSString*)dictToString:(NSMutableDictionary*)input {
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:input options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
}

// From JSON

+(RGLMatchFacesRequest*)RGLMatchFacesRequestFromJSON:(NSDictionary*)input {
    RGLMatchFacesRequest* result = [[RGLMatchFacesRequest alloc] initWithImages:[JSONConstructor NSArrayRGLImageFromJSON:[input valueForKey:@"images"]]];

    if([input valueForKey:@"customMetadata"] != nil)
        result.customMetadata = [input valueForKey:@"customMetadata"];
    if([input valueForKey:@"similarityThreshold"] != nil)
        result.similarityThreshold = [[input valueForKey:@"similarityThreshold"] numberValue];

    return result;
}

+(RGLImage*)RGLImageFromJSON:(NSDictionary*)input {
    RGLImage* result = [[RGLImage alloc]initWithImage:[JSONConstructor UIImageFromJSON:[input valueForKey:@"bitmap"]]];

    if([input valueForKey:@"tag"] != nil)
        result.tag = [input valueForKey:@"tag"];
    if([input valueForKey:@"imageType"] != nil)
        result.imageType = [[input valueForKey:@"imageType"] integerValue];

    return result;
}

+(UIImage*)UIImageFromJSON:(NSString*)input {
    return [UIImage imageWithData:[[NSData alloc]initWithBase64EncodedString:input options:NSDataBase64DecodingIgnoreUnknownCharacters]];
}

+(NSMutableArray<RGLImage*>*)NSArrayRGLImageFromJSON:(NSArray*)input {
    NSMutableArray<RGLImage*>* result = [[NSMutableArray alloc] init];
            for(NSDictionary* item in input)
                [result addObject:[JSONConstructor RGLImageFromJSON:item]];

    return result;
}

    // To JSON

+(NSMutableDictionary* _Nonnull)generateRGLLivenessParams:(RGLLivenessParams* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"attemptsCount"] = @(input.attemptsCount);

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRGLLivenessResponse:(RGLLivenessResponse* _Nullable)input {
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

+(NSMutableDictionary* _Nonnull)generateRGLFaceCaptureResponse:(RGLFaceCaptureResponse* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"image"] = [self generateRGLImage:input.image];
    result[@"error"] = [self generateNSError:input.error];

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRGLImage:(RGLImage* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"identifier"] = input.identifier;
    result[@"tag"] = input.tag;
    result[@"imageType"] = @(input.imageType);
    result[@"bitmap"] = [UIImageJPEGRepresentation(input.image, 1.0) base64EncodedStringWithOptions:0];

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRGLMatchFacesResponse:(RGLMatchFacesResponse* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"error"] = [self generateNSError:input.error];
    if(input.matchedFaces != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(RGLComparedFacesPair* item in input.matchedFaces)
            if(item != nil)
                [array addObject:[self generateRGLComparedFacesPair:item]];
        result[@"matchedFaces"] = array;
    }
    if(input.unmatchedFaces != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(RGLComparedFacesPair* item in input.unmatchedFaces)
            if(item != nil)
                [array addObject:[self generateRGLComparedFacesPair:item]];
        result[@"unmatchedFaces"] = array;
    }

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRGLComparedFacesPair:(RGLComparedFacesPair* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"first"] = [self generateRGLComparedFace:input.first];
    result[@"second"] = [self generateRGLComparedFace:input.second];
    result[@"similarity"] = input.similarity;
    result[@"error"] = [self generateNSError:input.error];

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRGLComparedFace:(RGLComparedFace* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"tag"] = input.tag;
    result[@"imageType"] = @(input.imageType);
    result[@"position"] = input.position;

    return result;
}

@end