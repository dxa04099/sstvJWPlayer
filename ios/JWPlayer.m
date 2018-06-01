//
//  JWPlayer.m
//  sstvdemo
//
//  Created by subhan on 12/5/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "JWPlayer.h"
#import "AppDelegate.h"

@implementation JWPlayer

BOOL isPlaying = NO;

- (void) createInstance
{
  JWPlayerViewController *jwPlayerVC = [[JWPlayerViewController alloc] init];
  jwPlayerVC.jwPlayerViewDelegate = self;
}

+ (id)allocWithZone:(NSZone *)zone {
  static JWPlayer *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [super allocWithZone:zone];
  });
  return sharedInstance;
}

RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents
{
  return @[@"jwOnError", @"jwOnTime", @"jwOnPause", @"jwOnPlay", @"jwOnComplete",@"jwOnClose"];
}

RCT_EXPORT_METHOD(closeJWPlayer)
{
//  [self sendEventWithName:@"EventReminder" body:@{@"name":error} ];
  [self.timer invalidate]; // stop timer on pause
  [self sendEventWithName:@"jwOnPause" body:@{@"eventName": @"onPause"} ];
  AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  [delegate.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

RCT_EXPORT_METHOD(PlayStream:(NSString *) streamUrl Seek:(nullable NSInteger *) times)
{
  JWPlayerViewController * jwPlayer = [[JWPlayerViewController alloc] init];
  jwPlayer.streamUrl = streamUrl;
  jwPlayer.timePosition = times;
  AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  [delegate.rootViewController presentViewController:jwPlayer animated:FALSE completion:nil];
}

- (void) onJWPlayerPlay:(NSString *) streamUrl videoDuration:(NSNumber *) nativeDuration
{
  if(!isPlaying){
    isPlaying = YES;
    [self sendEventWithName:@"jwOnPlay" body:@{@"eventName": @"onPlay", @"streamUrl" : streamUrl, @"nativeDuration": nativeDuration } ];
    [self.timer invalidate]; // stop timer if its running
    self.streamUrl = streamUrl;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:60.0
                                                target:self
                                              selector:@selector(onJWPlayerTime)
                                              userInfo:nil
                                               repeats:YES];
  }
}

- (void) onJWPlayerPause:(NSString *) streamUrl timePosition:(NSNumber *) timePosition
{
  NSLog(@"pause");
  
  isPlaying = NO;
  
  [self.timer invalidate]; // stop timer on pause

  [self sendEventWithName:@"jwOnPause" body:@{@"eventName": @"onPause", @"streamUrl": streamUrl, @"timePosition": timePosition }  ];
}

- (void) onJWPlayerTime//:(NSString *)streamUrl //position:(double)position duration:(double)duration
{
  
  NSLog(@"onTime");
  [self sendEventWithName:@"jwOnTime" body:@{@"eventName": @"onTime",
                                             @"streamUrl" : self.streamUrl,
//                                             @"position": [[NSNumber numberWithDouble:position] stringValue],
//                                             @"duration": [[NSNumber numberWithDouble:duration] stringValue]
                                             } ];
}

- (void) onJWPlayerError:(NSString *)streamUrl errorMsg:(NSString *)error
{
  isPlaying = NO;
  
  [self.timer invalidate]; //stop timer onError

  [self sendEventWithName:@"jwOnError" body:@{@"eventName": @"onError", @"streamUrl" : streamUrl, @"error" : error} ];
}

- (void) onJWPlayerComplete
{
  isPlaying = NO;
  
  [self.timer invalidate];

  [self sendEventWithName:@"jwOnComplete" body:@{@"eventName": @"onComplete"} ];
}

- (void) onJWPlayerClose
{
  isPlaying = NO;
  
  [self.timer invalidate];
  
  [self sendEventWithName:@"jwOnClose" body:@{@"eventName": @"onClose"} ];
}

@end
