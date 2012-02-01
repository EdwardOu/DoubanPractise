//
//  User.m
//  Douban
//
//  Created by ou on 11-12-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "User.h"
#import "DataBase.h"

@implementation User

+(id) find:(NSInteger)ID{
	PLSqliteDatabase *database=[DataBase setup];
	
	id<PLResultSet> rs;
	
	NSString *sql=[NSString stringWithFormat:@"select * from user where id=%d",ID];
	
	rs=[database executeQuery: sql];
	
	User *user=nil;
	
	if ([rs next]) {
		NSInteger UID=[rs intForColumn:@"id"];
		NSString *name=[rs objectForColumn:@"name"];
		NSString *password=[rs objectForColumn:@"password"];
		NSString *oauthTokenKey=[rs objectForColumn:@"oauthTokenKey"];
		NSString *oauthTokenSecret=[rs objectForColumn:@"oauthTokenSecret"];
		
		
		
		user=[[User alloc] initWithId:UID name:name password:password oauthTokenKey:oauthTokenKey oauthTokenSecret:oauthTokenSecret];
		
	}
	[rs close];
	 

	return user;
}

+(int)setToken:(NSInteger)ID  oauthTokenKey:(NSString *)oauthTokenKey oauthTokenSecret:(NSString *)oauthTokenSecret{
	
	PLSqliteDatabase *dataBase=[DataBase setup];
	
	
	NSString *sql=[[NSString alloc] initWithFormat:@"update user set oauthTokenKey='%@',oauthTokenSecret='%@' where id=%d",oauthTokenKey,oauthTokenSecret,ID];
	BOOL bResult = [dataBase executeUpdate:sql];
	
	return bResult;
	
	
}


-(id)initWithId:(NSInteger)ID name:(NSString *)name password:(NSString *)password oauthTokenKey:(NSString *)oauthTokenKey oauthTokenSecret:(NSString *)oauthTokenSecret{
	
	if (self=[super init]) {
		_id=ID;
		_name=[name retain];
		_password=[password retain];
		_oauthTokenKey=[oauthTokenKey retain];
		_oauthTokenSecret=[oauthTokenSecret retain];
	}
	return self;
}



-(NSString *) getOauthTokenSecret{
	
	return _oauthTokenSecret;
}



-(NSString *) getOauthTokenKey{
	if (_oauthTokenKey !=[NSNull null]) {
				_oauthTokenKey=[_oauthTokenKey stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	}
	return _oauthTokenKey;
}

@end
