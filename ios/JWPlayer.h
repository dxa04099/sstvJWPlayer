//
//  JWPlayer.h
//  sstvdemo
//
//  Created by subhan on 12/5/17.
//  Copyright © 2017 Facebook. All rights reserved.
//
//
#import <Foundation/Foundation.h>

//#if __has_include(<React/RCTBridgeModule.h>)
#import <React/RCTBridgeModule.h>
//#else
//#import "RCTBridgeModule.h"
//#endif
#import <RCTEventEmitter.h>
#import "JWPlayerViewController.h"

@interface JWPlayer : RCTEventEmitter <RCTBridgeModule>

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) NSString *streamUrl;
// @property (nonatomic,retain,readonly) NSNumber *times;

- (void) onJWPlayerError:(NSString *)streamUrl errorMsg:(NSString *)error;
- (void) onJWPlayerPlay:(NSString *)streamUrl videoDuration:(NSNumber *)nativeDuration;
- (void) onJWPlayerPause:(NSString *)streamUrl timePosition:(NSNumber *)timePosition;
- (void) onJWPlayerTime:(NSString *)streamUrl position:(double)position duration:(double)duration;
- (void) onJWPlayerComplete;
- (void) onJWPlayerClose;

@end
