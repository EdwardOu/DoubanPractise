//
//  User.h
//  Douban
//
//  Created by ou on 11-12-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface User : NSObject {
	NSInteger _id;
	NSString *_name;
	NSString *_password;
	NSString *_oauthTokenKey;
	NSString *_oauthTokenSecret;
	NSString *_commandCount;
}
+(id)find:(NSInteger)ID;

+(int)setToken:(NSInteger)ID oauthTokenKey:(NSString *) oauthTokenKey oauthTokenSecret:(NSString *) oauthTokenSecret;

-(id)initWithId:(NSInteger)ID name:(NSString *)name password:(NSString *)password oauthTokenKey:(NSString *) oauthTokenKey oauthTokenSecret:(NSString *) oauthTokenSecret;	

-(NSString *) getOauthTokenKey;

-(NSString *) getOauthTokenSecret;

@end
