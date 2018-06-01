//
//  JWPLayerViewController.m
//  HelloJWPlayer
//
//  Created by subhan on 11/30/17.
//  Copyright © 2017 subhan. All rights reserved.
//

#import "JWPlayerViewController.h"
#import "AppDelegate.h"
#import "JWPlayer.h"
#import <MediaPlayer/MediaPlayer.h>

@interface JWPlayerViewController () <JWPlayerDelegate>

@property (nonatomic) UIButton *btnBack;
@property (nonatomic) UIView *v;

@property (nonatomic) JWPlayer *jwPlayer;
@property (nonatomic) MPVolumeView *airPlayView;

@end

@implementation JWPlayerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)setUpAirPlayButton
{
  CGFloat buttonWidth = 44;
  CGFloat buttonCoordinateX = self.player.view.frame.size.width - buttonWidth - 5;
  self.airPlayView =[[MPVolumeView alloc] initWithFrame:CGRectMake(buttonCoordinateX, 0, buttonWidth, buttonWidth)];
  [self.airPlayView setShowsVolumeSlider:NO];
  self.airPlayView.backgroundColor = [UIColor clearColor];
  self.airPlayView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
  [self.player.view addSubview:self.airPlayView];
}

- (void)viewWillAppear:(BOOL)animated
{
    //    [super viewWillAppear:animated];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pausePlayer) name:@"JWPlayerAppResign" object:nil];
    self.jwPlayer = [JWPlayer allocWithZone:nil];
    [self createPopulatePlayer:self.streamUrl];
    [self.view addSubview:self.player.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (IBAction)viewJWPlayerButton:(UIButton *)sender {
//    [self createPopulatePlayer:@"https://origin-supersoccer-b-01.vos360.video/Content/HLS/VOD/daf82114-e53e-4e52-9701-e61457f525ca/68fb97dc-8666-635a-5742-c1ccce4088de/index.m3u8" andTitle:@"VOD video sample"];
//    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



- (void)createPopulatePlayer:(NSString *)url
{
    JWConfig *config = [JWConfig new];
    config.sources = @[[JWSource sourceWithFile:url label:@"Streaming" isDefault:YES]];
//    config.file = url;
    config.controls = YES;
    config.repeat = NO;
//    config.premiumSkin = JWPremiumSkinRoundster;

    self.player = [[JWPlayerController alloc] initWithConfig:config];
    
    self.btnBack = [UIButton new];
    self.btnBack = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImage *closeImage = [UIImage imageNamed:@"ic_close_white.png"];
    [self.btnBack setBackgroundImage:closeImage forState:UIControlStateNormal];
    
    //    [self.btnBack setTitle:@" X Close " forState:UIControlStateNormal];
    CGRect buttonFrame = self.btnBack.frame;
    buttonFrame.size = CGSizeMake(45 ,45);
    self.btnBack.frame = buttonFrame;
    [self.btnBack.layer setFrame:CGRectMake(20, 0, 45, 45)];
    self.btnBack.backgroundColor = [UIColor clearColor];
    [self.btnBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnBack setTitleColor:[UIColor whiteColor] forState:UIControlStateFocused];
    [self.btnBack addTarget:self
                     action:@selector(fncBackTapped:)
           forControlEvents:UIControlEventTouchUpInside];
    
    self.v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, 44)];
    self.v.backgroundColor = [UIColor blackColor];
    self.v.alpha = 0.5;
    
    [self.v addSubview:self.btnBack];
  
    //add AirPlay
  
    [self.player.view addSubview:self.v];
  
    [self setUpAirPlayButton];
  
    self.player.delegate = self;
    
    CGRect frame = self.view.bounds;
    self.player.view.frame = frame;
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
    
    self.player.openSafariOnAdClick = YES;
    self.player.forceFullScreenOnLandscape = YES;
    self.player.forceLandscapeOnFullScreen = YES;
    self.player.enterFullScreen;
  
  
}

-(void) fncBackTapped:(UIButton*)sender
{
  [self.player pause];
  [self.player stop];
  [self.player exitFullScreen];
  
  [self.v removeFromSuperview];
  self.v = nil;
  [self.player.view removeFromSuperview];
  self.player = nil;

//  [self.player.view setHidden:true];
//  [self deinitJWPlayer];
  [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
  
  // Event emitter on close
  [self.jwPlayer onJWPlayerClose];
  
  AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  [delegate.rootViewController dismissViewControllerAnimated:YES completion:nil];
//  if(delegate.rootViewController.navigationController){
//    [delegate.rootViewController.navigationController popViewControllerAnimated:YES];
//  }else{
//    [delegate.rootViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
//  }

  
    
  
    }

- (void)deinitJWPlayer
{
    if (self.player != nil) {
        [self.v removeFromSuperview];
        self.v = nil;
        [self.player.view removeFromSuperview];
        self.player = nil;
    }
}

- (void)onControlBarVisible:(BOOL)isVisible
{
    if(isVisible){
      [self.v setHidden:false];
      [self.airPlayView setHidden:false];
//      if(self.player.isInFullscreen)
//        {
//          [self.btnBack.layer setFrame:CGRectMake(20, 0, 45, 45)];
////          [self.v setHidden:false];
//        }else{
//          [self.btnBack.layer setFrame:CGRectMake(20, 22, 45, 45)];
////          [self.v setHidden:true];
//          [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
//        }
    }else{
      [self.v setHidden:true];
      [self.airPlayView setHidden:true];
    }
}


- (void)onFullscreen:(BOOL)status
{
    if(status){
//        [self.v setHidden:false];
       [self.btnBack.layer setFrame:CGRectMake(10, 0, 45, 45)];
      self.v.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
      CGFloat buttonCoordinateX = self.view.frame.size.width - 49;
      self.airPlayView.frame = CGRectMake(buttonCoordinateX, 0, 44, 44);
      
    }else{
//        [self.v setHidden:true];
      [self.btnBack.layer setFrame:CGRectMake(10, 22, 45, 45)];
      self.v.frame = CGRectMake(0, 0, self.view.frame.size.width, 66);
      CGFloat buttonCoordinateX = self.view.frame.size.width - 49;
      self.airPlayView.frame = CGRectMake(buttonCoordinateX, 22, 44, 44);
      [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
    }
}

- (void)onReady {
  self.player.play;
}

- (void)onFirstFrame:(NSInteger *)loadTime {
  if (self.timePosition != 0){
    [self.player seek:self.timePosition];
  }
}

-(void)onPlay:(NSString *)oldState
{
  NSLog(@"onPLay");
  if(self.jwPlayer){
    self.jwPlayer = [JWPlayer allocWithZone:nil];
  }
  double duration = [self.player duration] * 1000;
  NSNumber *nativeDuration = [[NSNumber alloc] initWithDouble:duration];
  [self.jwPlayer onJWPlayerPlay:self.streamUrl videoDuration:nativeDuration];
}

-(void)onPause:(NSString *)oldState
{
  NSLog(@"onPause");
  if(self.jwPlayer){
    self.jwPlayer = [JWPlayer allocWithZone:nil];
  }
  NSNumber *savingTime = [self.player playbackPosition];
  int adjusted = [savingTime intValue];
  adjusted = adjusted * 1000;
  savingTime = [NSNumber numberWithInt:adjusted];
  NSLog(@"%@", savingTime.stringValue);
  [self.jwPlayer onJWPlayerPause:self.streamUrl timePosition:savingTime];
//   [self pausePlayer];
}

-(void)onTime:(double)position ofDuration:(double)duration
{
//  NSLog(@"onPLay");
//  if(self.jwPlayer){
//    self.jwPlayer = [JWPlayer allocWithZone:nil];
//  }
//  [self.jwPlayer onJWPlayerTime:self.streamUrl position:position duration:duration];
}

- (void)onComplete {
  if(self.jwPlayer){
    self.jwPlayer = [JWPlayer allocWithZone:nil];
  }
  // error-like force-close
  [self.player pause];
  [self.player stop];
  [self.player exitFullScreen];
  
  [self.v removeFromSuperview];
  self.v = nil;
  [self.player.view removeFromSuperview];
  self.player = nil;
  
  
  [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
  
  AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  [delegate.rootViewController dismissViewControllerAnimated:YES completion:nil];
  
  // Event emitter
  [self.jwPlayer onJWPlayerComplete];

}

@synthesize jwPlayerViewDelegate;

- (void)onError:(NSError *)error {
  
  
  NSString *errorMsg = [error localizedDescription];
  NSLog(@"%@",errorMsg);
  if(self.jwPlayer){
    self.jwPlayer = [JWPlayer allocWithZone:nil];
  }
  [self.jwPlayer onJWPlayerError:self.streamUrl errorMsg: errorMsg];//,[errors localizedDescription]];

  [self.player pause];
  [self.player stop];
  [self.player exitFullScreen];
  
  [self.v removeFromSuperview];
  self.v = nil;
  [self.player.view removeFromSuperview];
  self.player = nil;
  
  
  [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
  
  AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  [delegate.rootViewController dismissViewControllerAnimated:YES completion:nil];
  

}

- (void) pausePlayer
{
    NSLog(@"pausePlayer");
    [self.player pause];
    if(self.jwPlayer){
      self.jwPlayer = [JWPlayer allocWithZone:nil];
    }
    NSNumber *timePosition = [self.player playbackPosition];
    NSLog(@"%@", timePosition.stringValue);
    [self.jwPlayer onJWPlayerPause:self.streamUrl timePosition:timePosition];
  
}

@end
