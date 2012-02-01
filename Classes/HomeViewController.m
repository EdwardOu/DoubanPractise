	//
	//  HomeViewController.m
	//  Douban
	//
	//  Created by ou on 11-12-21.
	//  Copyright 2011 __MyCompanyName__. All rights reserved.
	//

#import "HomeViewController.h"
#import "OAToken.h"
#import "URLUtility.h"
#import "TBXML.h"
#import "NibLoadedCell.h"
#import "TextFieldCell.h"
#import "GradientBackgroundTable.h"
#import "HomeLabelCell.h"
#import "Friend.h"
#import "LabelCell.h"
#import "HomeMoreBroadCastLabelCell.h"

@implementation HomeViewController

@synthesize _titleString,_imageUrl,_content,_userId,_userFlag,_userName,_friendsInfo,_friend,_token,_iconURl,_userBrocast,_friendsName,_commentsCount,_formatedDate,_broadCastId,_recommandComment,_friendsBroadCastPage,_recommandFlag,_wait,_groupArray,_topicArray;

- (id)init {
    
	
    if (self=[super init]) {
		
		self.title=@"社区";
	    self.navigationItem.title=@"豆瓣";
		self.tabBarItem.image=[UIImage imageNamed:@"home.png"];
		
        _friendsInfo=[[NSMutableArray alloc]init];
		_friendsBroadCastPage=1;
			//self.hidesBottomBarWhenPushed=YES;
		_recommandFlag=0;
		_topicArray=nil;
		_groupArray=nil;
	}
    return self;
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code.
 }
 */

-(void)viewDidLoad{
	[super viewDidLoad];
		//self.navigationController.navigationBarHidden=YES;
	
	[self refresh:nil];	
	
	
}


- (void)refresh:(id)sender
{
	
	_friendsBroadCastPage=1;
		//clear the container for the frendsInfo when everytime refresh
	
	
		//usersInfo
	
		//setting the token into userDefault
	NSUserDefaults *token=[NSUserDefaults standardUserDefaults];
	NSString *tokenKey=[token valueForKey:@"tokenKey"];
	NSString *tokenSecret=[token valueForKey:@"tokenSecret"];
	
	self._token=[[OAToken alloc] initWithKey:tokenKey secret:tokenSecret];
	
		
	
	
	
	[self fetchUsersInfo];
	
	
	
	
	[self performSelector:@selector(fetchFriendsInfo) withObject:nil afterDelay:1];
	
		//friendsBroadCast
	
	
	[self removeAllSectionsWithAnimation:UITableViewRowAnimationFade];
	
	[self performSelector:@selector(createRows) withObject:nil afterDelay:0.5];
	
	
	
	[self showLoadingIndicator];
	
	
	
	
    
}

- (void)createRows
{
	
	
		[self performSelector:@selector(makeRowslater) withObject:nil afterDelay:3];
		
}


-(void)makeRowslater{
	
	
	//[self addSectionAtIndex:2 withAnimation:UITableViewRowAnimationFade];
	
	[self
	 appendRowToSection:_friendsBroadCastPage
	 cellClass:[HomeMoreBroadCastLabelCell class]
	 cellData:self
	 
	 withAnimation:
	 UITableViewRowAnimationBottom];
	
	[self hideLoadingIndicator];
	
}

- (void)loadView
{
	GradientBackgroundTable *aTableView =
	[[[GradientBackgroundTable alloc]
	  initWithFrame:CGRectZero
	  style:UITableViewStyleGrouped]
	 autorelease];
	
	self.view = aTableView;
	self.tableView = aTableView;
}



-(void)fetchUsersInfo{
	
	
	dispatch_async(dispatch_get_global_queue(0, 0), ^{ 
	
	
			//request for the info about the user&parse it
		[URLUtility requestWithToken:_token request:@"http://api.douban.com/people/@me"];
		NSString *responseContent=[URLUtility getResponseBody];
		
		
		
		TBXML *xmlSource=[[TBXML alloc] initWithXMLString:responseContent];
		
		TBXMLElement *contentEl=[TBXML childElementNamed:@"content" parentElement:[xmlSource rootXMLElement]];
		
		_content=[[TBXML textForElement:contentEl] retain];
		
		TBXMLElement *titleEl=[TBXML childElementNamed:@"title" parentElement:[xmlSource rootXMLElement]];
		
		NSString * titleString=[TBXML textForElement:titleEl];
		NSString * userId=nil;
			//迭代处理兄弟树 fetch image
		while ((titleEl = titleEl->nextSibling)){
			NSString *imageLink=[TBXML valueOfAttributeNamed:@"href" forElement:titleEl];
			
			NSString * imageLinkCheck=[imageLink substringWithRange:NSMakeRange([imageLink length]-3, 3)];
			if ([imageLinkCheck isEqualToString:@"jpg"]) {
				NSMutableString *imageUrl=[[NSMutableString alloc] initWithString:imageLink];
				
				userId=[[imageUrl substringWithRange:NSMakeRange(29, 8)] retain];
				
					//the fetched iamge is too small so i gt change the url the fetch the bigger one
				[imageUrl insertString:@"l" atIndex:29];
				
				self._imageUrl=imageUrl;
				[imageUrl release];
				break;
			}
			
		}
	
		
			//fetch the usersBroadCast
		
		
		NSString *userBroadCastRequest=[[NSString alloc] initWithFormat:@"http://api.douban.com/people/%@/miniblog?max-results=1",userId];
		
				
		NSURL *userBroadCastRequestURl=[NSURL URLWithString:userBroadCastRequest];
		
		TBXML *userBroadCastResouce=[[TBXML alloc] initWithURL:userBroadCastRequestURl];
		
		TBXMLElement *userBroadCastFirstEl=[TBXML childElementNamed:@"entry" parentElement:[userBroadCastResouce rootXMLElement]];
		
		TBXMLElement *userBroadCastEl=[TBXML childElementNamed:@"title" parentElement:userBroadCastFirstEl];
	
		
		NSString * userBrocast=[[TBXML textForElement:userBroadCastEl] retain];
		
	
	     dispatch_async(dispatch_get_main_queue(), ^{ 
			 
			 self._userId=userId;
			 self._titleString=titleString;
			 self._userBrocast=userBrocast;
			 [NibLoadedCell setImageUrl:_imageUrl];
			 [self addSectionAtIndex:0 withAnimation:UITableViewRowAnimationFade];
			 [NibLoadedCell setBroadCast:_userBrocast];
			 
			 [self
			  appendRowToSection:0
			  cellClass:[NibLoadedCell class]
			  
			  cellData:_content
			  withAnimation:
			  UITableViewRowAnimationLeft ];
			 
			 
			 [self
			  appendRowToSection:0
			  cellClass:[TextFieldCell class]
			  cellData:
			  [NSMutableDictionary dictionaryWithObjectsAndKeys:
			   @"分享此刻心情",
			   @"label",
			   @"", @"value", 
			   NSLocalizedString(@"    大爷写一条新的广播呗", @""),
			   @"placeholder",
			   nil]
			  withAnimation:UITableViewRowAnimationLeft];	
			 
	     });
		});
}




-(void)fetchFriendsInfo{
		NSString *requestUrl=[[NSString alloc] initWithFormat:@"http://api.douban.com/people/%@/miniblog/contacts?max-results=25",_userId];
	NSLog(@"requestUrl:%@",requestUrl);

	[URLUtility requestWithToken:_token request:requestUrl];
	NSString *responseContent=[URLUtility getResponseBody];
	NSLog(@"responseContent:%@",responseContent);
	
	
	dispatch_async(dispatch_get_global_queue(0, 0), ^{  
		
		
		[_friendsInfo removeAllObjects];
		
		
		
		
		NSString *requestUrl=[[NSString alloc] initWithFormat:@"http://api.douban.com/people/%@/miniblog/contacts?start-index=%d&max-results=25",_userId,_friendsBroadCastPage==1? 1 :_friendsBroadCastPage*25];
		NSLog(@"requestUrl:%@",requestUrl);
		
	  		
		
		
		NSURL *friendsBroadCastURl=[NSURL URLWithString:requestUrl];
		
		TBXML *friendsXmlSource =[[TBXML alloc]initWithURL:friendsBroadCastURl];
		
		
			//TBXMLElement *nameEl=[TBXML childElementNamed:@"name" parentElement:[friendsXmlSource rootXMLElement]];
		_userFlag=0;
		[self traverseElement:[friendsXmlSource rootXMLElement]];
		
					
		
		
		
		
		dispatch_async(dispatch_get_main_queue(), ^{ 
				//membery the page;(section)
		
			
			if (_friendsBroadCastPage==1) {
				[self addSectionAtIndex:1 withAnimation:UITableViewRowAnimationFade];
				
				for (Friend *friend in _friendsInfo) {
					
					[self
					 appendRowToSection:1
					 cellClass:[HomeLabelCell class]
					 cellData:friend
					 
					 withAnimation:
					 UITableViewRowAnimationLeft];
					
				}	
			}else {
				[self addSectionAtIndex:_friendsBroadCastPage withAnimation:UITableViewRowAnimationFade];
				
				for (Friend *friend in _friendsInfo) {
					
					[self
					 appendRowToSection:_friendsBroadCastPage
					 cellClass:[HomeLabelCell class]
					 cellData:friend
					 
					 withAnimation:
					 UITableViewRowAnimationLeft];
					
			}
			}

				
			
		}); 
	});
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
	
	
	
	
	
	if (![textField.text isEqualToString:@""]) {
		
		
		NSString *entry=[[NSString alloc]initWithFormat:@"<?xml version='1.0' encoding='UTF-8'?><entry xmlns:ns0=\"http://www.w3.org/2005/Atom\" xmlns:db=\"http://www.douban.com/xmlns/\"><content>%@</content></entry>", textField.text];
		
		
		[URLUtility postWithToken:_token request:@"http://api.douban.com/miniblog/saying" postBody:entry];
		
		NSString *responseXml=[URLUtility getResponseBody];
		NSLog(@"!!!!!!!%@",responseXml);
		
		[NibLoadedCell setBroadCast:textField.text];
		
		[self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:0]withRowAnimation:UITableViewRowAnimationLeft];
		
	}
	
	
}

- (NSString *)tableView:(UITableView *)aTableView
titleForHeaderInSection:(NSInteger)section
{
	if (section == 0)
	{
		NSString *desc=[[NSString alloc] initWithFormat:@"个人信息：%@",_titleString];
		return NSLocalizedString(desc, nil);
	}
	else if (section == 1)
	{
		return NSLocalizedString(@"友邻广播", nil);
	}
	int i=2;
	
	do {
		
		if (section ==i) {
			NSString *sectionTitle=[[NSString alloc]initWithFormat:@"第%d组友邻广播",i];
			
			return NSLocalizedString(sectionTitle, nil);
		}
		
		i++;
		
		
	} while (1)	;
		
	return nil;
}

	//parse all friendsInfo
-(void) traverseElement:(TBXMLElement *)element {
	
		//NSLog(@"start the loop");
	
	NSString *name=nil;
	
	NSString *tagName=nil;
	
	
	do {
			// Display the name of the element
		
			//NSLog(@"%@",[TBXML elementName:element]);
		tagName=[TBXML elementName:element];
		
		
		NSLog(@"tagText%@",[TBXML textForElement:element]);
		
		
		
		if ([tagName isEqualToString:@"title"]) {
			_broadCast=[TBXML textForElement:element];
			if ([_broadCast hasPrefix:@"推荐"]) {
				_recommandFlag=1;
			}else {
				_recommandFlag=0;
			}

			
			continue;
		}
		
		
		
			// Obtain first attribute from element
		TBXMLAttribute * attribute = element->firstAttribute;		
			//if attribute is valid
		while (attribute) {
				//Display name and value of attribute to the log window
			NSLog(@"%@->%@ = %@",[TBXML elementName:element],[TBXML attributeName:attribute], [TBXML attributeValue:attribute]);
			if (_recommandFlag==1) {
				
				
				if ([[TBXML elementName:element] isEqualToString:@"content"]&&[[TBXML attributeName:attribute] isEqualToString:@"type"]&&[[TBXML attributeValue:attribute] isEqualToString:@"html"]) {
					NSString *recommandSource=[TBXML textForElement:element];
					
					NSArray *recommandSourceArray=[recommandSource componentsSeparatedByString:@"</a>"];
					
					int groupStart=[[recommandSourceArray objectAtIndex:0] rangeOfString:@"href=\""].location;
					
					NSString *group=[[recommandSourceArray objectAtIndex:0] substringFromIndex:groupStart+6];
					
					_groupArray=[group componentsSeparatedByString:@"\">"];
					
			
					if ([recommandSourceArray count]>2) {
						int topicStart=[[recommandSourceArray objectAtIndex:1] rangeOfString:@"href=\""].location;
												
						NSString *topic=[[recommandSourceArray objectAtIndex:1] substringFromIndex:topicStart+6];
						
						_topicArray=[topic componentsSeparatedByString:@"\">"];
						
					}
						//					NSArray *topicArray=[topic componentsSeparatedByString:@"\">"];
//					
//					NSLog(@"topicArray:%@",topicArray);
				}
			}
			
				//parse the image of friends
			if ([[TBXML attributeValue:attribute] hasPrefix:@"http://img3.douban.com/icon/"]) {
				_iconURl=[TBXML attributeValue:attribute];
				
			}
			if ([[TBXML attributeValue:attribute] isEqualToString:@"comment"]) {
			    _recommandComment=[[NSString alloc] initWithString:[TBXML textForElement:element]];
				
				
			}
			
			
			//parse the commentsCount of friend
			if ([[TBXML attributeValue:attribute] isEqualToString:@"comments_count"]) {
				_commentsCount=[[NSString alloc] initWithString:[TBXML textForElement:element]];
				
				if (_recommandFlag==0) {
					_topicArray=nil;
					_groupArray=nil;
				}
					_friend=[[Friend alloc] initWithProperties:_friendsName broadCast:_broadCast iconUrl:_iconURl date:_formatedDate commentsCount:_commentsCount broadCastId:_broadCastId recommandComment:_recommandComment topicArray:_topicArray groupArray:_groupArray];
				
				
				
					//NSLog(@"friendsName:%@  -----broadCast:%@ -----iconURl:%@ -----%@-----friend:%@",_friendsName,_broadCast,_iconURl,[_friend date],[_friend friendsName]);
				[_friendsInfo addObject:_friend];
				[_friend release];
				
 			}
			
							//Obtain the next attribute
			attribute = attribute->next;
		}
			
			//parse the name
		if ([tagName isEqualToString:@"name"]) {
			
			if (_userFlag==0) {
				_userName=[TBXML textForElement:element];
				
					//NSLog(@"~~~~~~got the userName:%@",_userName);
			    _userFlag++;
					//NSLog(@"frind the user or not userFlag==%d",_userFlag);
				
			}
			name=[TBXML textForElement:element];
			
				//name is the content of the tag "name"  username is for throwing out the info of user;
			
			
			_friendsName=[TBXML textForElement:element];
			
				//NSLog(@"now the friendsName ==%@",_friendsName);
			
		}
		
			//parset the broadCastId;
		if ([tagName isEqualToString:@"id"]) {
			NSString *tempIdString=[TBXML textForElement:element];
		    _broadCastId=[tempIdString substringWithRange:NSMakeRange([tempIdString length]-9, 9)];
			NSLog(@"_broadCastId:%@",_broadCastId);
		}
		
		    //parse the date
		if ([tagName isEqualToString:@"published"]&&![_friendsName isEqualToString:_userName]) {
			
			NSString *dateString=[TBXML textForElement:element];
			NSDate *date=[NSDate dateFromRFC3339String:dateString];
			NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
			[formatter setDateStyle:NSDateFormatterMediumStyle];
			[formatter setTimeStyle:NSDateFormatterMediumStyle];
			[formatter setDateFormat:@"MM月dd号 aKK:mm"];
			_formatedDate=[formatter stringFromDate:date];
			
			
			
			
		}
		
		
		
		
			//if the element has child elements, process them
		if (element->firstChild) [self traverseElement:element->firstChild];
		
			// Obtain next sibling element
	} while ((element = element->nextSibling)); 
	
	
		//NSLog(@"the loop finish");
}


-(void)showWaiting{
	_wait=[[UIAlertView alloc]initWithTitle:@"LOADING...." message:@"PLZ WAITING" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
	[_wait show];
	
}

-(void)hideWaiting{
	
	[_wait dismissWithClickedButtonIndex:0 animated:YES];
}


- (void)dealloc {
	[_wait release];
	[_topicArray release];
	[_groupArray release];
	[_recommandComment release];
	[_broadCastId release];
	[_formatedDate release];
	[_commentsCount release];
	[_userBrocast release];
	[_content release];
	[_userId release];
	[_userName release];
	[_friendsInfo release];
	[_friend release];
	[_token release];
	
	[_titleString release];
	[_imageUrl release];
	[_content release];
	[_titleString release];
    [super dealloc];
}


@end
