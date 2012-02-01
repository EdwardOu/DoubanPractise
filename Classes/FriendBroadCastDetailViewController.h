//
//  FriendBroadCastDetailViewController.h
//  Douban
//
//  Created by ou on 12-1-18.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"PageViewController.h"
#import "Friend.h"

@interface FriendBroadCastDetailViewController : PageViewController {

	Friend *_friend;
	NSString *_detailMode;
}
@property (nonatomic,retain) Friend *_friend;
@property (nonatomic,retain) NSString *_detailMode;

@end
