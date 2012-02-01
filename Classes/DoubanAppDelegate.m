	//
	//  DoubanAppDelegate.m
	//  Douban
	//
	//  Created by ou on 11-12-21.
	//  Copyright 2011 __MyCompanyName__. All rights reserved.
	//

#import "DoubanAppDelegate.h"
#import "HomeViewController.h"
#import "LastestCommandViewController.h"
#import "FavViewController.h"
#import "User.h"
#import "OAToken.h"


@implementation DoubanAppDelegate

@synthesize window,_authFlg,_launchOptions,_application;


#pragma mark url回调
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
	NSLog(@"获得已授权的key:%@",[url query]);
	
	NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
	
	NSString *string = [[url query] substringWithRange:NSMakeRange([[url query] length]-6, 6)];
	NSLog(@"%@",string);
	
	[info setValue:string forKey:@"oauth_verifier"];
	[info synchronize];
	
	[minroad startAccessOauth];
	return YES;
}

#pragma mark token delegate
- (void)OauthDidFinish:(OAToken *)token
{
	NSLog(@"start setting the tokenKey to the local db&UserDefault");
	
	
	if ([User setToken:1 oauthTokenKey:token.key oauthTokenSecret:token.secret]) {
		NSLog(@"settings going soomthly,check the db");
		NSString *key=[token key];
		NSString *secret=[token secret];
		NSUserDefaults *token=[NSUserDefaults standardUserDefaults];
		[token setValue:key forKey:@"tokenKey"];
		[token setValue:secret forKey:@"tokenSecret"];
		[token synchronize];
		_authFlg=@"yes";
		[self application:_application didFinishLaunchingWithOptions:_launchOptions];
		
	}else {
		NSLog(@"error");
	}
	
	
}

#pragma mark -
#pragma mark Application lifecycle



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	_application=application;
	_launchOptions=launchOptions;
	
	if (self._authFlg==NULL) {
		
		User *user=[User find:1];
		
		if (user) {
			
			
			if ([user getOauthTokenKey]==[NSNull null]) {
				NSLog(@"key is null,get the oauthToken");
				
				minroad = [[MinroadOauth alloc] init];
				[minroad startOauth];
				minroad.delegate = self;
			}else  if ([[user getOauthTokenKey] isEqualToString:@""]) {
				minroad = [[MinroadOauth alloc] init];
				[minroad startOauth];
				minroad.delegate = self;
				
			}else {
				NSLog(@"already authorised,and we got the key: %@  and secret:  %@",[user getOauthTokenKey],[user getOauthTokenSecret]);
				
				NSString *key=[user getOauthTokenKey];
				NSString *secret=[user getOauthTokenSecret];
				NSUserDefaults *token=[NSUserDefaults standardUserDefaults];
				[token setValue:key forKey:@"tokenKey"];
				[token setValue:secret forKey:@"tokenSecret"];
				[token synchronize];
				_authFlg=@"yes";
				[self application:_application didFinishLaunchingWithOptions:_launchOptions];
			}
			
		}
	
	}else {
		[application setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
		
		window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
		
		NSMutableArray *controllerArray=[[[NSMutableArray alloc] init] autorelease];
		
		
			//HOMEVIEWCONTROLLER
		HomeViewController *homeViewController=[[HomeViewController alloc] init];
		
		UINavigationController *homeNavController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
		
		homeNavController.navigationBar.barStyle=UIBarStyleBlackTranslucent;
		
		[controllerArray addObject:homeNavController];
		[homeNavController release];
		
			//Lateset Meida(include Lat//eset books,Lateset movies,Lateset music)(最新评论)
		LastestCommandViewController *lastestCommandViewController=[[LastestCommandViewController alloc] init];
		
		UINavigationController *commandNavController = [[UINavigationController alloc] initWithRootViewController:lastestCommandViewController];
		
		
		commandNavController.navigationBar.barStyle=UIBarStyleBlackTranslucent;
		
		[controllerArray addObject:commandNavController];
		[commandNavController release];
		
			//Favour
		
		FavViewController *favViewController=[[FavViewController alloc] init];
		
		UINavigationController *favNavController = [[UINavigationController alloc] initWithRootViewController:favViewController];
		
		
		favNavController.navigationBar.barStyle=UIBarStyleBlackTranslucent;
		
		[controllerArray addObject:favNavController];
		[favNavController release];
		
		UITabBarController *tabBarController=[[UITabBarController alloc] init];
		
		[tabBarController setViewControllers:controllerArray];
		
		
		[self.window makeKeyAndVisible];
		
		[window addSubview:tabBarController.view];
		
	}

	     	
	
    return YES;
	
	
}



- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	
    [window release];
    [super dealloc];
}



@end
