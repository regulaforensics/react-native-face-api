
#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#else
#import <React/RCTBridgeModule.h>
#endif
#import "RFSWJSONConstructor.h"
@import UIKit;
@import FaceSDK;

@interface RNFaceApi : NSObject <RCTBridgeModule>

@end

