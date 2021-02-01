@import UIKit;
#import "RNFaceApi.h"

@implementation RNFaceApi

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

typedef void (^Callback)(NSString* response);

- (void)result:(NSString*)message :(Callback)callback {
    callback(message);
}

RCT_EXPORT_METHOD(exec:(NSString*)moduleName:(NSString*)action:(NSArray*)args:(RCTResponseSenderBlock)sCallback:(RCTResponseSenderBlock)eCallback) {
    Callback successCallback = ^(NSString* response){
        sCallback(@[response]);
    };
    Callback errorCallback = ^(NSString* response){
        eCallback(@[response]);
    };

    [self sampleMethod :successCallback :errorCallback];

    // if([action isEqualToString:@"getAPIVersion"])
    //     [self getAPIVersion :successCallback :errorCallback];
    // else if([action isEqualToString:@"getAvailableScenarios"])
    //     [self getAvailableScenarios :successCallback :errorCallback];
    // else if([action isEqualToString:@"isRFIDAvailableForUse"])
    //     [self isRFIDAvailableForUse :successCallback :errorCallback];
    // else if([action isEqualToString:@"getCoreMode"])
    //     [self getCoreMode :successCallback :errorCallback];
    // else if([action isEqualToString:@"getCoreVersion"])
    //     [self getCoreVersion :successCallback :errorCallback];
    // else if([action isEqualToString:@"getDatabaseDate"])
    //     [self getDatabaseDate :successCallback :errorCallback];
    // else if([action isEqualToString:@"getDatabaseID"])
    //     [self getDatabaseID :successCallback :errorCallback];
    // else if([action isEqualToString:@"getDatabaseVersion"])
    //     [self getDatabaseVersion :successCallback :errorCallback];
    // else if([action isEqualToString:@"getDocumentReaderIsReady"])
    //     [self getDocumentReaderIsReady :successCallback :errorCallback];
    // else if([action isEqualToString:@"getDocumentReaderStatus"])
    //     [self getDocumentReaderStatus :successCallback :errorCallback];
    // else if([action isEqualToString:@"getDatabaseCountriesNumber"])
    //     [self getDatabaseCountriesNumber :successCallback :errorCallback];
    // else if([action isEqualToString:@"getDatabaseDocumentsNumber"])
    //     [self getDatabaseDocumentsNumber :successCallback :errorCallback];
    // else if([action isEqualToString:@"selectedScenario"])
    //     [self selectedScenario :successCallback :errorCallback];
    // else if([action isEqualToString:@"getSessionLogFolder"])
    //     [self getSessionLogFolder :successCallback :errorCallback];
    // else if([action isEqualToString:@"getDatabaseDescription"])
    //     [self getDatabaseDescription :successCallback :errorCallback];
    // else if([action isEqualToString:@"showScanner"])
    //     [self showScanner :successCallback :errorCallback];
    // else if([action isEqualToString:@"startNewPage"])
    //     [self startNewPage :successCallback :errorCallback];
    // else if([action isEqualToString:@"startNewSession"])
    //     [self startNewSession :successCallback :errorCallback];
    // else if([action isEqualToString:@"startRFIDReader"])
    //     [self startRFIDReader :successCallback :errorCallback];
    // else if([action isEqualToString:@"stopRFIDReader"])
    //     [self stopRFIDReader :successCallback :errorCallback];
    // else if([action isEqualToString:@"stopScanner"])
    //     [self stopScanner :successCallback :errorCallback];
    // else if([action isEqualToString:@"deinitializeReader"])
    //     [self deinitializeReader :successCallback :errorCallback];
    // else if([action isEqualToString:@"isAuthenticatorAvailableForUse"])
    //     [self isAuthenticatorAvailableForUse :successCallback :errorCallback];
    // else if([action isEqualToString:@"getConfig"])
    //     [self getConfig :successCallback :errorCallback];
    // else if([action isEqualToString:@"getRfidScenario"])
    //     [self getRfidScenario :successCallback :errorCallback];
    // else if([action isEqualToString:@"getLicenseExpiryDate"])
    //     [self getLicenseExpiryDate :successCallback :errorCallback];
    // else if([action isEqualToString:@"getLicenseCountryFilter"])
    //     [self getLicenseCountryFilter :successCallback :errorCallback];
    // else if([action isEqualToString:@"licenseIsRfidAvailable"])
    //     [self licenseIsRfidAvailable :successCallback :errorCallback];
    // else if([action isEqualToString:@"getCameraSessionIsPaused"])
    //     [self getCameraSessionIsPaused :successCallback :errorCallback];
    // else if([action isEqualToString:@"removeDatabase"])
    //     [self removeDatabase :successCallback :errorCallback];
    // else if([action isEqualToString:@"cancelDBUpdate"])
    //     [self cancelDBUpdate :successCallback :errorCallback];
    // else if([action isEqualToString:@"resetConfiguration"])
    //     [self resetConfiguration :successCallback :errorCallback];
    // else if([action isEqualToString:@"clearPKDCertificates"])
    //     [self clearPKDCertificates :successCallback :errorCallback];
    // else if([action isEqualToString:@"readRFID"])
    //     [self readRFID :successCallback :errorCallback];
    // else if([action isEqualToString:@"getRfidSessionStatus"])
    //     [self getRfidSessionStatus :successCallback :errorCallback];
    // else if([action isEqualToString:@"setEnableCoreLogs"])
    //     [self setEnableCoreLogs :[args objectAtIndex:0] :successCallback :errorCallback];
    // else if([action isEqualToString:@"addPKDCertificates"])
    //     [self addPKDCertificates :[args objectAtIndex:0] :successCallback :errorCallback];
    // else if([action isEqualToString:@"setCameraSessionIsPaused"])
    //     [self setCameraSessionIsPaused :[args objectAtIndex:0] :successCallback :errorCallback];
    // else if([action isEqualToString:@"getScenario"])
    //     [self getScenario :[args objectAtIndex:0] :successCallback :errorCallback];
    // else if([action isEqualToString:@"recognizeImages"])
    //     [self recognizeImages :[args objectAtIndex:0] :successCallback :errorCallback];
    // else if([action isEqualToString:@"showScannerWithCameraID"])
    //     [self showScannerWithCameraID :[args objectAtIndex:0] :successCallback :errorCallback];
    // else if([action isEqualToString:@"runAutoUpdate"])
    //     [self runAutoUpdate :[args objectAtIndex:0] :successCallback :errorCallback];
    // else if([action isEqualToString:@"setConfig"])
    //     [self setConfig :[args objectAtIndex:0] :successCallback :errorCallback];
    // else if([action isEqualToString:@"setRfidScenario"])
    //     [self setRfidScenario :[args objectAtIndex:0] :successCallback :errorCallback];
    // else if([action isEqualToString:@"initializeReader"])
    //     [self initializeReader :[args objectAtIndex:0] :successCallback :errorCallback];
    // else if([action isEqualToString:@"prepareDatabase"])
    //     [self prepareDatabase :[args objectAtIndex:0] :successCallback :errorCallback];
    // else if([action isEqualToString:@"recognizeImage"])
    //     [self recognizeImage :[args objectAtIndex:0] :successCallback :errorCallback];
    // else if([action isEqualToString:@"setRfidSessionStatus"])
    //     [self setRfidSessionStatus :[args objectAtIndex:0] :successCallback :errorCallback];
    // else if([action isEqualToString:@"initializeReaderWithDatabasePath"])
    //     [self initializeReaderWithDatabasePath :[args objectAtIndex:0] :[args objectAtIndex:1] :successCallback :errorCallback];
    // else if([action isEqualToString:@"recognizeImageFrame"])
    //     [self recognizeImageFrame :[args objectAtIndex:0] :[args objectAtIndex:1] :successCallback :errorCallback];
    // else if([action isEqualToString:@"recognizeImageWithOpts"])
    //     [self recognizeImageWithOpts :[args objectAtIndex:0] :[args objectAtIndex:1] :successCallback :errorCallback];
    // else if([action isEqualToString:@"recognizeVideoFrame"])
    //     [self recognizeVideoFrame :[args objectAtIndex:0] :[args objectAtIndex:1] :successCallback :errorCallback];
    // else if([action isEqualToString:@"showScannerWithCameraIDAndOpts"])
    //     [self showScannerWithCameraIDAndOpts :[args objectAtIndex:0] :[args objectAtIndex:1] :successCallback :errorCallback];
    // else if([action isEqualToString:@"recognizeImageWithImageInputParams"])
    //     [self recognizeImageWithImageInputParams :[args objectAtIndex:0] :[args objectAtIndex:1] :successCallback :errorCallback];
    // else if([action isEqualToString:@"recognizeImageWithCameraMode"])
    //     [self recognizeImageWithCameraMode :[args objectAtIndex:0] :[args objectAtIndex:1] :successCallback :errorCallback];
    // else
    //     [self result:[NSString stringWithFormat:@"%@/%@", @"method not implemented: ", action] :errorCallback];
}

- (void) sampleMethod:(Callback)successCallback :(Callback)errorCallback{
    [self result:@"sample" :errorCallback];
}

@end
