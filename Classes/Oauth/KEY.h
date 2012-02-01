//
//  KEY.h
//  Oauth
//
//  Created by gao wei on 10-8-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#define APPKEY @"017682f3ce16adc0046388db6a440940" //你信这是真的么？
#define APPSECRET @"2c1510822433a17f"

//豆瓣
#define RequestURL @"http://www.douban.com/service/auth/request_token" //获取未授权request token
#define AuthorizeURL @"http://www.douban.com/service/auth/authorize"  //获取授权request token
#define AccessURL @"http://www.douban.com/service/auth/access_token"  //获取access token

//新浪
//#define RequestURL @"http://api.t.sina.com.cn/oauth/request_token" //获取未授权request token
//#define AuthorizeURL @"http://api.t.sina.com.cn/oauth/authorize"  //获取授权request token
//#define AccessURL @"http://api.t.sina.com.cn/oauth/access_token"  //获取access token

#define CallBackURL @"douban://minroad.com"  //回调url