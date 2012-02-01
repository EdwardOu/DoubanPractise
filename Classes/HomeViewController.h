	//
	//  HomeViewController.h
	//  Douban
	//
	//  Created by ou on 11-12-21.
	//  Copyright 2011 __MyCompanyName__. All rights reserved.
	//

#import <UIKit/UIKit.h>
#import "PageViewController.h"
#import "Friend.h"
#import "OAToken.h"
@interface HomeViewController : PageViewController {
@private
	NSString *_titleString;
@private
	NSString *_imageUrl;
@private
	NSString *_content;
@private
	NSString *_userId;
@private
	int _userFlag;
@private
	NSString * _userName;
@private
	NSString * _friendsName;
@private
	NSString * _iconURl;
@private
	NSString * _broadCast;
@private
	NSMutableArray *_friendsInfo;
@private
	Friend *_friend;
@private
	OAToken *_token;
@private
	NSString *_userBrocast;
@private
	NSString *_commentsCount;
@private
	NSString *_formatedDate;
@private
	NSString *_broadCastId;
@private
	NSString *_recommandComment;
@private
	int _friendsBroadCastPage;
@private
	int _recommandFlag;
@private
	NSArray *_groupArray;
@private
	NSArray *_topicArray;
@private 
	UIAlertView *_wait;
	
}
@property (nonatomic,retain) NSString * _userBrocast;
@property (nonatomic,retain) NSString * _formatedDate;
@property (nonatomic,retain) NSString * _commentsCount;
@property (nonatomic,retain) NSString * _titleString;
@property (nonatomic,retain) NSString * _imageUrl;
@property (nonatomic,retain) NSString * _content;
@property (nonatomic,retain) NSString * _userId;
@property (nonatomic,retain) NSString * _userName;
@property (nonatomic,retain) NSString * _friendsName;
@property (nonatomic,retain) NSString * _broadCast;
@property (nonatomic,retain) NSString * _iconURl;
@property (nonatomic,retain) NSMutableArray * _friendsInfo;
@property (nonatomic,assign) int _userFlag;
@property (nonatomic,assign) Friend *_friend;
@property (nonatomic,assign) OAToken *_token;
@property (nonatomic,retain) NSString *_broadCastId;
@property (nonatomic,retain) NSString *_recommandComment;
@property (nonatomic,assign) int _friendsBroadCastPage;
@property (nonatomic,assign) int _recommandFlag;
@property (nonatomic,retain) NSArray * _groupArray;
@property (nonatomic,retain) NSArray * _topicArray;
@property (nonatomic,retain) UIAlertView *_wait;

-(void)makeRowslater;
-(void)showWaiting;
-(void)hideWaiting;
@end
