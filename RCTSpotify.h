//
//  RCTSpotify.h
//
//  Created by Focal55 on 1/28/2017.
//

#import <Foundation/Foundation.h>
#import <SpotifyAuthentication/SpotifyAuthentication.h>
#import <SpotifyAudioPlayback/SpotifyAudioPlayback.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTLog.h>
#import "RCTSpotifyLoginViewController.h"

@interface RCTSpotify : NSObject <RCTBridgeModule>
@property (nonatomic, strong) NSURL *redirectURL;
@property (strong, nonatomic) UIWindow *window;

- (void)urlCallback: (NSURL *)url;
+ (id)sharedManager;
@end
