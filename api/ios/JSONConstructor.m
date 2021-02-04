#import "JSONConstructor.h"

@implementation JSONConstructor

+(NSMutableDictionary*)generateRGLLivenessParams:(RGLLivenessParams*)input {
    NSMutableDictionary *output = [[NSMutableDictionary alloc] init];

    output[@"attemptsCount"] = @(input.attemptsCount);

    return output;
}

+(NSString*)dictToString:(NSMutableDictionary*)input {
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:input options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
}

+(NSMutableDictionary*)generateRGLLivenessResponse:(RGLLivenessResponse*)input {
    NSMutableDictionary *output = [[NSMutableDictionary alloc] init];

    output[@"bitmap"] = [JSONConstructor generateUIImage:input.image];
    output[@"liveness"] = @(input.liveness);
    output[@"error"] = [JSONConstructor generateNSError:input.error];

    return output;
}

+(NSMutableDictionary*)generateNSError:(NSError*)input {
    NSMutableDictionary *output = [[NSMutableDictionary alloc] init];

    output[@"errorCode"] = @(input.code);
    output[@"message"] = input.localizedDescription;

    return output;
}

+(NSString*)generateUIImage:(UIImage*)input {
    NSData *imageData = UIImageJPEGRepresentation(input, 1.0);
    return [imageData base64EncodedStringWithOptions:0];
}

+(NSMutableDictionary*)generateRGLFaceCaptureResponse:(RGLFaceCaptureResponse*)input {
    NSMutableDictionary *output = [[NSMutableDictionary alloc] init];

    output[@"image"] = [JSONConstructor generateRGLImage:input.image];
    output[@"error"] = [JSONConstructor generateNSError:input.error];

    return output;
}

+(NSMutableDictionary*)generateRGLImage:(RGLImage*)input {
    NSMutableDictionary *output = [[NSMutableDictionary alloc] init];

    output[@"errorCode"] = @(input.imageType);
    output[@"tag"] = input.tag;
    output[@"bitmap"] = [JSONConstructor generateUIImage:input.image];

    return output;
}

+(NSMutableDictionary*)generateRGLMatchFacesResponse:(RGLMatchFacesResponse*)input {
    NSMutableDictionary *output = [[NSMutableDictionary alloc] init];

    output[@"error"] = [JSONConstructor generateNSError:input.error];
    output[@"matchedFaces"] = [JSONConstructor generateNSArrayRGLComparedFacesPair:input.matchedFaces];
    output[@"unmatchedFaces"] = [JSONConstructor generateNSArrayRGLComparedFacesPair:input.unmatchedFaces];

    return output;
}

+(NSMutableDictionary*)generateRGLComparedFacesPair:(RGLComparedFacesPair*)input {
    NSMutableDictionary *output = [[NSMutableDictionary alloc] init];

    output[@"first"] = [JSONConstructor generateRGLComparedFace:input.first];
    output[@"second"] = [JSONConstructor generateRGLComparedFace:input.second];
    output[@"similarity"] = input.similarity;
    output[@"error"] = [JSONConstructor generateNSError:input.error];

    return output;
}

+(NSMutableDictionary*)generateRGLComparedFace:(RGLComparedFace*)input {
    NSMutableDictionary *output = [[NSMutableDictionary alloc] init];

    output[@"errorCode"] = @(input.imageType);
    output[@"tag"] = input.tag;
    output[@"bitmap"] = input.position;

    return output;
}

+(NSMutableArray*)generateNSArrayRGLComparedFacesPair:(NSArray<RGLComparedFacesPair*>* _Nonnull)array {
    NSMutableArray *output = [[NSMutableArray alloc] init];
    for(RGLComparedFacesPair* item in array)
        if(item != nil)
            [output addObject:[self generateRGLComparedFacesPair:item]];
    return output;
}

// To JSON

+(RGLMatchFacesRequest*)RGLMatchFacesRequestFromJSON:(NSDictionary*)input {
    NSNumber* similarityThreshold = [[input valueForKey:@"similarityThreshold"] numberValue];
    NSDictionary* customMetadata = [input valueForKey:@"customMetadata"];
    NSArray* images =[input valueForKey:@"images"];
    
    return [[RGLMatchFacesRequest alloc] initWithImages:[JSONConstructor NSArrayRGLImageFromJSON:images] similarityThreshold:similarityThreshold customMetadata:customMetadata];
}

+(RGLImage*)RGLImageFromJSON:(NSDictionary*)input {
    RGLImage* result = [[RGLImage alloc]initWithImage:[JSONConstructor UIImageFromJSON:[input valueForKey:@"bitmap"]]];
    
    result.tag = [input valueForKey:@"tag"];
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

@end
