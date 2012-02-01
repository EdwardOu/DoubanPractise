//
//  DoubanAppDelegate.h
//  Douban
//
//  Created by ou on 11-12-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MinroadOauth.h"
@interface DoubanAppDelegate : NSObject <UIApplicationDelegate,OauthToken> {
    UIWindow *window;
	MinroadOauth *minroad;
	NSString *_authFlg;
	UIApplication *_application;
	NSDictionary *_launchOptions;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) NSString *_authFlg;
@property (nonatomic, retain)UIApplication *_application;
@property (nonatomic, retain) NSDictionary *_launchOptions;

@end

