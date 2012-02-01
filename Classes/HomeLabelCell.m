	//
	//  NibLoadedCell.m
	//  TableDesignRevisited
	//
	//  Created by Paul Wong on 9/15/11.
	//  Copyright 2011 __MyCompanyName__. All rights reserved.

#import "HomeLabelCell.h"
#import "PageViewController.h"
#import "CommandsTableViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "TBXML.h"
#import "FriendBroadCastDetailViewController.h"

const int showDetailFlag=0;


@implementation HomeLabelCell

@synthesize broadCast,image,name,date,button,broadCastId,commentUser,commentString,checkBroadCastId,friend;

	//
	// nibName
	//
	// returns the name of the nib file from which the cell is loaded.
	//
+(NSString *)nibName
{
	if (showDetailFlag==1) {
		NSLog(@"ok");
		return @"HomeLabelCell4DetailBroadCast";
	}
	return @"HomeLabelCell";
}


-(IBAction)showFreindsInfo{
	
	NSLog(@"-(IBAction)showFreindsInfo;");
}
-(IBAction)showFreindsImage{
	
	NSLog(@"showFreindsImage");
}
	//
	// handleSelectionInTableView:
	//
	// Performs the appropriate action when the cell is selected
	//
- (void)handleSelectionInTableView:(UITableView *)aTableView 
{
	[super handleSelectionInTableView:aTableView];
	if ([[friend _broadCast] hasPrefix:@"推荐"]){
		
		
		//NSInteger rowIndex = [aTableView indexPathForCell:self].row;
		
		[((PageViewController *)aTableView.delegate).navigationController
		 pushViewController:[[FriendBroadCastDetailViewController alloc ] initWithFriend:self.friend ]animated:YES];
}
	
	
}

	//
	// configureForData:tableView:indexPath:
	//
	// Invoked when the cell is given data. All fields should be updated to reflect
	// the data.
	//
	// Parameters:
	//    dataObject - the dataObject (can be nil for data-less objects)
	//    aTableView - the tableView (passed in since the cell may not be in the
	//		hierarchy)
	//    anIndexPath - the indexPath of the 'cell
	//
- (void)configureForData:(id)dataObject
			   tableView:(UITableView *)aTableView
			   indexPath:(NSIndexPath *)anIndexPath
{
	
	[super configureForData:dataObject tableView:aTableView indexPath:anIndexPath];
	friend=dataObject;
	
	NSLog(@"da:%@",[friend _topicArray]);
	
	tableView=aTableView;
	indexPath=anIndexPath;
	
    commentString=[[NSMutableString alloc]init];
	
	commentsArray=[[NSMutableArray alloc] init];
	commentUsersArray=[[NSMutableArray alloc] init];
	
	
	self.broadCast.lineBreakMode=UILineBreakModeWordWrap;
	broadCast.numberOfLines=0;
	
	
	
		//NSLog(@"the dataObject:%@",dataObject);
	if (friend) {
		NSString *RecommandBrocast=nil;
		name.text = [friend  _friendsName];
		if ([[friend _broadCast] hasPrefix:@"推荐"]&&(![[friend _recommandComment] isEqualToString:@""])) {
			RecommandBrocast=[[NSString alloc]initWithFormat:@"%@%@",[friend _recommandComment] ,[friend _broadCast]];
			broadCast.text=RecommandBrocast;
			
		}else {
			broadCast.text = [friend _broadCast];
		}
		
		
		date.text=[friend _date];
		
			//设置layer
		CALayer *layer=[image layer];
			//是否设置边框以及是否可见
		[layer setMasksToBounds:YES];
			//设置边框圆角的弧度
		[layer setCornerRadius:14];
			//设置边框线的宽
			//
		[layer setBorderWidth:1];
			//设置边框线的颜色
		[layer setBorderColor:[[UIColor  grayColor] CGColor]];
		
		commentsCount=[[friend _commentsCount] intValue];
		
		if ([[friend _commentsCount] isEqualToString:@"0"]) {
			
			NSString *commentText=[[NSString alloc] initWithFormat:@"回 应"];
			
			
			[button setTitle:commentText forState:UIControlStateNormal];
			
			button.titleLabel.font=[UIFont systemFontOfSize:11.0];
			button.titleLabel.textColor=[UIColor grayColor];
			button.alpha=0.7;
			
		}else {
			NSString *commentText=[[NSString alloc] initWithFormat:@"回应:%@",[friend _commentsCount]];
			
			[button setTitle:commentText forState:UIControlStateNormal];
			
			
			button.alpha=1;
			
		}
		button.titleLabel.textColor=[UIColor colorWithRed:0.4 green:0.4 blue:0.8 alpha:1.00];
        button.titleLabel.font=[UIFont systemFontOfSize:11.0];
		NSURL *tempUrl=[NSURL URLWithString:[friend _iconUrl]];
		NSData *tempData=[[NSData alloc] initWithContentsOfURL:tempUrl];
		image.image = [[UIImage alloc] initWithData:tempData];
		
		
			//get the friendsId
		broadCastId=[friend _broadCastId];
		
		
	}
	
	
	
}

-(IBAction)showDetail{
	showDetailFlag=1;
	
	int rows=0;
	int i=0;
	for (i; i<[indexPath section]; i++) {
		rows+=[tableView numberOfRowsInSection:i];
		
	}
	
	
	NSLog(@"rows:%d",rows);
	
	broadCast.numberOfLines=1;
	
	[PageCell setRowHeightByContent:130 row:rows+[indexPath row]+1];
	
	NSLog(@"broadCast:%@",broadCast);
	
	//start from here...
	
	[tableView reloadRowsAtIndexPaths:[[NSArray alloc]initWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
//	[self performSelector:@selector(changLabel) withObject:nil afterDelay:2];

}
-(void)changLabel{
		
	
}


-(IBAction)showComments{
	
	if (commentsCount!=0) {
		
		if (checkBroadCastId==NULL||(![checkBroadCastId isEqualToString:broadCastId])||[commentString isEqualToString:@""]) {
			[checkBroadCastId release];
			checkBroadCastId=[broadCastId copy];
			
			commentFlag=0;
			NSString *broadCastURLString=[[NSString alloc] initWithFormat:@"http://m.douban.com/status/%@/",broadCastId];
			
			NSURL *broadCastRequestURL=[NSURL URLWithString:broadCastURLString];
			
			[broadCastURLString release];
			
			TBXML *broadCastCommentsSource=[TBXML tbxmlWithURL:broadCastRequestURL];
			
			if (broadCastCommentsSource.rootXMLElement)
				[self traverseElement:broadCastCommentsSource.rootXMLElement];
			
			commentsReply=[[UIAlertView alloc] initWithTitle:@"查看回应" message:nil delegate:self cancelButtonTitle:@"回应" otherButtonTitles:@"取消",nil];
			
			NSLog(@"commentsCount:%d",commentsCount);
			
			if (commentsCount>20) {
				int tempCount=commentsCount;
				while (tempCount>=0) {
					tempCount-=20;
					NSString *broadCastURLString=[[NSString alloc] initWithFormat:@"http://m.douban.com/status/%@/comments?page=%d",broadCastId,tempCount/20+1];
					
					NSURL *broadCastRequestURL=[NSURL URLWithString:broadCastURLString];
					
					[broadCastURLString release];
					
					TBXML *broadCastCommentsSource=[TBXML tbxmlWithURL:broadCastRequestURL];
					if (broadCastCommentsSource.rootXMLElement)
						[self traverseElement:broadCastCommentsSource.rootXMLElement];
					
				}
			}
			
			int i=0;
			for (i; i<commentsCount; i++) {
				
				NSLog(@"[commentsArray count]:%d",[commentsArray count]);
				NSLog(@"[commentUsersArray count]:%d",[commentUsersArray count]);
				[commentString appendFormat:@"%@回应： %@\n\n",[commentUsersArray objectAtIndex:i],[commentsArray objectAtIndex:i]];
				
			}
			
		}
		
		commentsReply.tag=@"comments";
		commentsReply.message=commentString;
		
		[commentsReply show];
		
			//[commentsReply release];
	}else {
		NSLog(@"commentsReply:%@",commentsReply);
		UIAlertView *replyAlerView=[[UIAlertView alloc] initWithTitle:@"回应广播\n\n\n" message:@"\n\n" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
		
		replyTextField=[[UITextField alloc]init];
		replyTextField.frame=CGRectMake(12, 55, 260, 40);
		
		CALayer *layer=[replyTextField layer];
			//是否设置边框以及是否可见
		[layer setMasksToBounds:YES];
			//设置边框圆角的弧度
		[layer setCornerRadius:9];
			//设置边框线的宽
			//
		[layer setBorderWidth:1];
			//设置边框线的颜色
		[layer setBorderColor:[[UIColor  grayColor] CGColor]];
		
		[replyTextField setBackgroundColor:[UIColor whiteColor]];
		
		[replyAlerView addSubview:replyTextField];
		
		CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0, 60);
		
		[replyAlerView setTransform:myTransform];
		[replyAlerView setTag:@"reply"];
		
		[replyAlerView show];
		
	}
	
	
}



- (void) traverseElement:(TBXMLElement *)element {
		// if ([commentsArray count]<_commentsCount) {
    
	
	do {
			// Display the name of the element
		NSLog(@"elementName:%@",[TBXML elementName:element]);
		NSLog(@"textForElement:%@",[TBXML textForElement:element]);
		if ([[TBXML elementName:element] isEqualToString:@"p"]) {
			
			NSString *comment=[TBXML textForElement:element];
			[comment stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
			if(![comment isEqualToString:@""]){
				[commentsArray addObject:comment];
			}
			
			
		}
		
			// Obtain first attribute from element
		TBXMLAttribute * attribute = element->firstAttribute;
		
		
			// if attribute is valid
		while (attribute) {
				// Display name and value of attribute to the log window
			NSLog(@"%@->%@ = %@",[TBXML elementName:element],[TBXML attributeName:attribute], [TBXML attributeValue:attribute]);
			
			if ([[TBXML elementName:element] isEqualToString:@"span"]&&[[TBXML attributeName:attribute] isEqualToString:@"class"]&&[[TBXML attributeValue:attribute] isEqualToString:@"info"]) {
				commentFlag++;
				
				if (commentFlag%2==0) {
					commentFlag=1;
				}
				
			}
			if ([[TBXML elementName:element] isEqualToString:@"a"]&&[[TBXML attributeName:attribute] isEqualToString:@"href"]&&[[TBXML attributeValue:attribute] hasPrefix:@"/people/"]) {
				commentFlag++;
				
				
				if (commentFlag%2==0&&commentFlag!=0) {
					
					commentUser=[TBXML textForElement:element];
					
					[commentUsersArray  addObject:commentUser];
					[commentUser release];
					
				}else {
					commentFlag=0;
				}
				
				
				
			}
			
			
				// Obtain the next attribute
			attribute = attribute->next;
		}
		
		
			// if the element has child elements, process them
		if (element->firstChild) [self traverseElement:element->firstChild];
		
			// Obtain next sibling element
	} while ((element = element->nextSibling));  
	
	
	
	
	
}
-(void)willPresentAlertView:(UIAlertView *)alertView{
    
	
	if (alertView.tag==@"reply") {
		alertView.frame=CGRectMake(24, 180, 280, 200);
	}
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	
	if (alertView.tag==@"comments") {
		if (buttonIndex == 0) {
			NSLog(@"commentsReply:%@",commentsReply);
			UIAlertView *replyAlerView=[[UIAlertView alloc] initWithTitle:@"回应广播\n\n\n" message:@"\n\n" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
			
			replyTextField=[[UITextField alloc]init];
			replyTextField.frame=CGRectMake(12, 55, 260, 40);
			
			CALayer *layer=[replyTextField layer];
				//是否设置边框以及是否可见
			[layer setMasksToBounds:YES];
				//设置边框圆角的弧度
			[layer setCornerRadius:9];
				//设置边框线的宽
				//
			[layer setBorderWidth:1];
				//设置边框线的颜色
			[layer setBorderColor:[[UIColor  grayColor] CGColor]];
			
			[replyTextField setBackgroundColor:[UIColor whiteColor]];
			
			[replyAlerView addSubview:replyTextField];
			
			CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0, 60);
			
			[replyAlerView setTransform:myTransform];
			[replyAlerView setTag:@"reply"];
			
			[replyAlerView show];
			
			
			
			
		}
	}
	
	if (alertView.tag==@"reply") {
		
			//NSUserDefaults *token=[NSUserDefaults standardUserDefaults];
			//		NSString *tokenKey=[token valueForKey:@"tokenKey"];
			//		NSString *tokenSecret=[token valueForKey:@"tokenSecret"];
			//		
			//		self.token=[[OAToken alloc] initWithKey:tokenKey secret:tokenSecret];
			//		
			//		[URLUtility requestWithToken:_token request:@"http://api.douban.com/people/@me"];
			//		
			//		NSString *responseContent=[URLUtility getResponseBody];
		
		
		NSLog(@"replyTextField.text:%@",[replyTextField text]);
	}
}



-(void)dealloc{
	
	
	[super dealloc];
	[replyTextField release];
	[commentString release];
	[commentsReply release];
	[commentsArray release];
	[commentUsersArray release];
	[broadCastId release];
	
}
@end
