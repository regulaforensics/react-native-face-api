#import "RFSWJSONConstructor.h"

@implementation RFSWJSONConstructor

+(NSString*)dictToString:(NSMutableDictionary*)input {
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:input options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
}

// From JSON

+(RFSMatchFacesRequest*)RFSMatchFacesRequestFromJSON:(NSDictionary*)input {
    RFSMatchFacesRequest* result = [[RFSMatchFacesRequest alloc] initWithImages:[RFSWJSONConstructor NSArrayRFSMatchFacesImageFromJSON:[input valueForKey:@"images"]]];

    if([input valueForKey:@"thumbnails"] != nil)
        result.thumbnails = [[input valueForKey:@"thumbnails"] boolValue];
    if([input valueForKey:@"metadata"] != nil)
        result.metadata = [NSJSONSerialization JSONObjectWithData: [[[input valueForKey:@"metadata"] stringValue] dataUsingEncoding:NSUTF8StringEncoding] options: 0 error: nil];

    return result;
}

+(RFSImage*)RFSImageFromJSON:(NSDictionary*)input {
    RFSImage* result = [[RFSImage alloc] initWithImage:[RFSWJSONConstructor UIImageFromJSON:[input valueForKey:@"bitmap"]] type:[[input valueForKey:@"imageType"] integerValue]];

    return result;
}

+(NSMutableDictionary*)generateCGRect:(CGRect)input {
    NSMutableDictionary *result = [NSMutableDictionary new];

    result[@"top"] = @(input.origin.y);
    result[@"left"] = @(input.origin.x);
    result[@"bottom"] = @(input.origin.y+input.size.height);
    result[@"right"] = @(input.origin.x+input.size.width);

    return result;
}

+(RFSMatchFacesImage*)RFSMatchFacesImageFromJSON:(NSDictionary*)input {
    UIImage* image = [RFSWJSONConstructor UIImageFromJSON:[input valueForKey:@"bitmap"]];
    bool hasDetectAll = false;
    bool detectAll = false;
    RFSImageType imageType = RFSImageTypePrinted;
    if([input valueForKey:@"detectAll"] != nil){
        hasDetectAll = true;
        detectAll = [input valueForKey:@"detectAll"];
    }
    if([input valueForKey:@"imageType"] != nil)
        imageType = [[input valueForKey:@"imageType"] integerValue];
    if(hasDetectAll)
        return [[RFSMatchFacesImage alloc] initWithImage:image imageType:imageType detectAll:detectAll];
    return [[RFSMatchFacesImage alloc] initWithImage:image imageType:imageType];
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

+(NSMutableArray<RFSMatchFacesImage*>*)NSArrayRFSMatchFacesImageFromJSON:(NSArray*)input {
    NSMutableArray<RFSMatchFacesImage*>* result = [[NSMutableArray alloc] init];
            for(NSDictionary* item in input)
                [result addObject:[RFSWJSONConstructor RFSMatchFacesImageFromJSON:item]];

    return result;
}

    // To JSON

+(NSMutableDictionary* _Nonnull)generateRFSLivenessResponse:(RFSLivenessResponse* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"bitmap"] = [UIImageJPEGRepresentation(input.image, 1.0) base64EncodedStringWithOptions:0];
    result[@"liveness"] = @(input.liveness);
    result[@"exception"] = [self generateNSError:input.error];
    result[@"guid"] = input.guid;

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSFaceCaptureResponse:(RFSFaceCaptureResponse* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"image"] = [self generateRFSImage:input.image];
    result[@"exception"] = [self generateNSError:input.error];

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSImage:(RFSImage* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"imageType"] = @(input.imageType);
    result[@"bitmap"] = [UIImageJPEGRepresentation(input.image, 1.0) base64EncodedStringWithOptions:0];

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesImage:(RFSMatchFacesImage* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"imageType"] = @(input.imageType);
    result[@"bitmap"] = [UIImageJPEGRepresentation(input.image, 1.0) base64EncodedStringWithOptions:0];
    result[@"detectAll"] = @(input.detectAll);
    result[@"identifier"] = input.identifier;

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesResponse:(RFSMatchFacesResponse* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"exception"] = [self generateNSError:input.error];
    if(input.results != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(RFSMatchFacesComparedFacesPair* item in input.results)
            if(item != nil)
                [array addObject:[self generateRFSMatchFacesComparedFacesPair:item]];
        result[@"results"] = array;
    }
    if(input.detections != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(RFSMatchFacesDetection* item in input.detections)
            if(item != nil)
                [array addObject:[self generateRFSMatchFacesDetection:item]];
        result[@"detections"] = array;
    }

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesComparedFacesPair:(RFSMatchFacesComparedFacesPair* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"first"] = [self generateRFSMatchFacesComparedFace:input.first];
    result[@"second"] = [self generateRFSMatchFacesComparedFace:input.second];
    result[@"score"] = input.score;
    result[@"similarity"] = input.similarity;
    result[@"exception"] = [self generateNSError:input.error];

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesComparedFace:(RFSMatchFacesComparedFace* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"imageIndex"] = input.imageIndex;
    result[@"faceIndex"] = input.faceIndex;
    result[@"image"] = [self generateRFSMatchFacesImage:input.image];
    result[@"face"] = [self generateRFSMatchFacesDetectionFace:input.face];

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesDetectionFace:(RFSMatchFacesDetectionFace* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"rotationAngle"] = input.rotationAngle;
    result[@"faceIndex"] = input.faceIndex;
    result[@"thumbnail"] = [UIImageJPEGRepresentation(input.thumbnailImage, 1.0) base64EncodedStringWithOptions:0];
    if(input.landmarks != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(RFSPoint* item in input.landmarks)
            if(item != nil)
                [array addObject:[self generateRFSPoint:item]];
        result[@"landmarks"] = array;
    }
    result[@"faceRect"] = [self generateCGRect:input.faceRect];

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSPoint:(RFSPoint* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"x"] = @(input.x);
    result[@"y"] = @(input.y);

    return result;
}

+(NSMutableDictionary* _Nonnull)generateNSError:(NSError* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"errorCode"] = @(input.code);
    result[@"message"] = input.localizedDescription;

    return result;
}

+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesDetection:(RFSMatchFacesDetection* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    result[@"image"] = [self generateRFSMatchFacesImage:input.image];
    result[@"imageIndex"] = input.imageIndex;
    if(input.faces != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(RFSMatchFacesDetectionFace* item in input.faces)
            if(item != nil)
                [array addObject:[self generateRFSMatchFacesDetectionFace:item]];
        result[@"faces"] = array;
    }
    result[@"exception"] = [self generateNSError:input.error];

    return result;
}

@end