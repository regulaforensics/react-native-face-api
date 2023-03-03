#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import "RFSWJSONConstructor.h"
@import UIKit;
@import FaceSDK;

@interface RNFaceApi : RCTEventEmitter <RCTBridgeModule, RFSURLRequestInterceptingDelegate, RFSVideoUploadingDelegate>
@property NSDictionary* headers;
@end
