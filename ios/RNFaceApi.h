#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import "RFSWJSONConstructor.h"
#import "RFSWConfig.h"
@import UIKit;
@import FaceSDK;

typedef void (^RFSWCallback)(id _Nullable response);
typedef void (^RFSWEventSender)(NSString* _Nonnull event, id _Nullable data);

@interface RNFaceApi : RCTEventEmitter <RCTBridgeModule,
                                        RFSURLRequestInterceptingDelegate,
                                        RFSVideoUploadingDelegate,
                                        RFSCustomizationActionDelegate,
                                        RFSFaceCaptureDelegate,
                                        RFSLivenessDelegate>
@property NSDictionary* _Nullable headers;
@end

NSString* _Nonnull RFSWCameraSwitchEvent;
NSString* _Nonnull RFSWLivenessNotificationEvent;
NSString* _Nonnull RFSWVideoEncoderCompletionEvent;
NSString* _Nonnull RFSWOnCustomButtonTappedEvent;
