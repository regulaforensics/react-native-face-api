#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import "RFSWJSONConstructor.h"
@import UIKit;
@import FaceSDK;

typedef void (^RFSWCallback)(NSString* _Nullable response);

@interface RNFaceApi : RCTEventEmitter <RCTBridgeModule,
                                        RFSURLRequestInterceptingDelegate,
                                        RFSVideoUploadingDelegate,
                                        RFSCustomizationActionDelegate>
@property NSDictionary* _Nullable headers;
@end
