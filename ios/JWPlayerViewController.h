//
//  JWPLayerViewController.h
//  HelloJWPlayer
//
//  Created by subhan on 11/30/17.
//  Copyright © 2017 subhan. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <JWPlayer-iOS-SDK/JWPlayerController.h>
#import <JWPlayer_iOS_SDK/JWPlayerController.h>

@protocol JWPlayerViewDelegate <NSObject>

- (void) onJWPlayerError:(NSString *) error;

@end

@interface JWPlayerViewController : UIViewController

@property (strong, nonatomic) NSString *streamUrl;
@property (assign, nonatomic) NSInteger *timePosition;

@property (nonatomic) JWPlayerController *player;

- (void) pausePlayer;

//@property (nonatomic) id<JWPlayer *> jwplayer;
@property (nonatomic, assign) id<JWPlayerViewDelegate> jwPlayerViewDelegate;
- (void) onJWPlayerError:(NSString *) error;

@end
