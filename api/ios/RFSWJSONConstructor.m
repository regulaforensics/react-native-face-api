#import "RFSWJSONConstructor.h"
@import FaceSDK.Private;

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

+(NSMutableArray<RFSMatchFacesComparedFacesPair*>*)NSArrayRFSMatchFacesComparedFacesPairFromJSON:(NSArray*)input {
    NSMutableArray<RFSMatchFacesComparedFacesPair*>* result = [[NSMutableArray alloc] init];
    for(NSDictionary* item in input)
        [result addObject:[RFSWJSONConstructor RFSMatchFacesComparedFacesPairFromJSON:item]];

    return result;
}

+(RFSMatchFacesComparedFacesPair*)RFSMatchFacesComparedFacesPairFromJSON:(NSDictionary*)input {
    RFSMatchFacesComparedFace *first = nil;
    if([input valueForKey:@"first"] != nil){
        first = [RFSWJSONConstructor RFSMatchFacesComparedFaceFromJSON:[input valueForKey:@"first"]];
    }
    RFSMatchFacesComparedFace *second = nil;
    if([input valueForKey:@"second"] != nil){
        second = [RFSWJSONConstructor RFSMatchFacesComparedFaceFromJSON:[input valueForKey:@"second"]];
    }
    NSError *exception = nil;
    if([input valueForKey:@"exception"] != nil){
        exception = [RFSWJSONConstructor NSErrorFromJSON:[input valueForKey:@"exception"]];
    }
    NSNumber *similarity = 0;
    if([input valueForKey:@"similarity"] != nil){
        similarity = [input valueForKey:@"similarity"];
    }
    NSNumber *score = 0;
    if([input valueForKey:@"score"] != nil){
        score = [input valueForKey:@"score"];
    }

    return [[RFSMatchFacesComparedFacesPair alloc] initWithFirst:first second:second score:score similarity:similarity error:exception];
}

+(NSError*)NSErrorFromJSON:(NSDictionary*)input {
    if([input valueForKey:@"errorCode"] != nil)
        return [NSError errorWithDomain:RFSMatchFacesErrorDomain code:[[input valueForKey:@"errorCode"] integerValue] userInfo:nil];
    return nil;
}

+(RFSMatchFacesComparedFace*)RFSMatchFacesComparedFaceFromJSON:(NSDictionary*)input {
    RFSMatchFacesImage *image = nil;
    if([input valueForKey:@"image"] != nil){
        image = [RFSWJSONConstructor RFSMatchFacesImageFromJSON:[input valueForKey:@"image"]];
    }
    RFSMatchFacesDetectionFace *face = nil;
    if([input valueForKey:@"face"] != nil){
        face = [RFSWJSONConstructor RFSMatchFacesDetectionFaceFromJSON:[input valueForKey:@"face"]];
    }
    NSNumber *imageIndex = 0;
    if([input valueForKey:@"imageIndex"] != nil){
        imageIndex = [input valueForKey:@"imageIndex"];
    }
    NSNumber *faceIndex = 0;
    if([input valueForKey:@"faceIndex"] != nil){
        faceIndex = [input valueForKey:@"faceIndex"];
    }

    return [[RFSMatchFacesComparedFace alloc] initWithImageIndex:imageIndex image:image faceIndex:faceIndex face:face];
}

+(RFSMatchFacesDetectionFace*)RFSMatchFacesDetectionFaceFromJSON:(NSDictionary*)input {
    CGRect faceRect = CGRectMake(0, 0, 0, 0);
    if([input valueForKey:@"faceRect"] != nil){
        faceRect = [RFSWJSONConstructor CGRectFromJSON:[input valueForKey:@"faceRect"]];
    }
    NSArray<RFSPoint*> *landmarks = [NSArray new];
    if([input valueForKey:@"landmarks"] != nil){
        landmarks = [RFSWJSONConstructor NSArrayRFSPointFromJSON:[input valueForKey:@"landmarks"]];
    }
    NSNumber *rotationAngle = 0;
    if([input valueForKey:@"rotationAngle"] != nil){
        rotationAngle = [input valueForKey:@"rotationAngle"];
    }
    NSNumber *faceIndex = 0;
    if([input valueForKey:@"faceIndex"] != nil){
        faceIndex = [input valueForKey:@"faceIndex"];
    }

    return [[RFSMatchFacesDetectionFace alloc] initWithFaceIndex:faceIndex landmarks:landmarks faceRect:faceRect rotationAngle:rotationAngle thumbnailImage:nil];
}

+(CGRect)CGRectFromJSON:(NSDictionary*)input {
    CGFloat bottom = 0;
    if([input valueForKey:@"bottom"] != nil){
        bottom = [[input valueForKey:@"bottom"] floatValue];
    }
    CGFloat top = 0;
    if([input valueForKey:@"top"] != nil){
        top = [[input valueForKey:@"top"] floatValue];
    }
    CGFloat left = 0;
    if([input valueForKey:@"left"] != nil){
        left = [[input valueForKey:@"left"] floatValue];
    }
    CGFloat right = 0;
    if([input valueForKey:@"right"] != nil){
        right = [[input valueForKey:@"right"] floatValue];
    }

    return CGRectMake(left, top, right - left, bottom - top);
}

+(NSMutableArray<RFSPoint*>*)NSArrayRFSPointFromJSON:(NSArray*)input {
    NSMutableArray<RFSPoint*>* result = [[NSMutableArray alloc] init];
    for(NSDictionary* item in input)
        [result addObject:[RFSWJSONConstructor RFSPointFromJSON:item]];

    return result;
}

+(RFSPoint*)RFSPointFromJSON:(NSDictionary*)input {
    CGFloat x = 0;
    if([input valueForKey:@"x"] != nil){
        x = [[input valueForKey:@"x"] floatValue];
    }
    CGFloat y = 0;
    if([input valueForKey:@"y"] != nil){
        y = [[input valueForKey:@"y"] floatValue];
    }

    return [[RFSPoint alloc] initWithX:x y:y];
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

+(NSMutableDictionary* _Nonnull)generateRFSMatchFacesSimilarityThresholdSplit:(RFSMatchFacesSimilarityThresholdSplit* _Nullable)input {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if(input == nil) return result;

    if(input.matchedFaces != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(RFSMatchFacesComparedFacesPair* item in input.matchedFaces)
            if(item != nil)
                [array addObject:[self generateRFSMatchFacesComparedFacesPair:item]];
        result[@"matchedFaces"] = array;
    }
    if(input.unmatchedFaces != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(RFSMatchFacesComparedFacesPair* item in input.unmatchedFaces)
            if(item != nil)
                [array addObject:[self generateRFSMatchFacesComparedFacesPair:item]];
        result[@"unmatchedFaces"] = array;
    }

    return result;
}

@end