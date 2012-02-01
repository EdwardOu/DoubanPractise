    //
//  CompleteReviewTableViewController.m
//  Douban
//
//  Created by ou on 11-12-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CompleteReviewTableViewController.h"
#import "TBXML.h"

typedef enum {  SectionDetail,SectionFooter } Sections;
typedef enum { SectionHeaderTitle, SectionHeaderDate, SectionHeaderURL } HeaderRows;
typedef enum { SectionDetailSummary } DetailRows;

@implementation CompleteReviewTableViewController

@synthesize item,reviewLink,completeReview;

- (id)initWithStyle:(UITableViewStyle)style {
 
	if ((self = [super initWithStyle:style])) {
		
		self.completeReview=[[NSMutableString alloc] initWithString:@" "];
		
		self.hidesBottomBarWhenPushed = YES;
	    }
    return self;
}


- (void)dealloc {
	
    [super dealloc];
	
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	if (item.link) {
		
		NSInteger start= [item.link rangeOfString:@"review"].location;
		
		
		NSString *reviewId=	[item.link substringWithRange:NSMakeRange(start+7, 8)];
					//根式为： wap的 http://m.douban.com/movie/review/5235564/
		self.reviewLink=[@"http://m.douban.com/movie/review/" stringByAppendingString:reviewId];
		
			//define the flag for the iter
		contentFinishFlag=0;
			//initialize the completeReview to store the desired inifomation (the completeReview)
		
		
		NSURL *reviewLinkURL=[NSURL URLWithString:reviewLink];
		TBXML *xmlSource=[TBXML tbxmlWithURL:reviewLinkURL];
		
		if (xmlSource.rootXMLElement)
			[self traverseElement:xmlSource.rootXMLElement];
		
		NSLog(@"%@",completeReview);
		
	}
	
}

-(void) traverseElement:(TBXMLElement *)element {
	NSString *rubish=@"&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;";
	NSString *content=nil;
	do {
			// Display the name of the element
		//NSLog(@"%@",[TBXML elementName:element]);
		
		if ([@"p" isEqual:[TBXML elementName:element]]) {
			
			content=[TBXML textForElement:element];
			
				//this is the form the xhtml......what could i say.....
				//<p>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;还是想说几句，关于《金陵十三钗》。 </p>
				//            <p>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</p>
				//            <p>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</p>
				//            <p>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;看的时候笑中有泪，泪中有恨，时而沉重，时而抑郁，时而幽默，时而感动。这绝对是张艺谋最好的作品。回家的路上跟某人说，要是《十三钗》都拿不了奥斯卡，我觉得中国人从此真没必要凑那个热闹了。就像诺贝尔文学奖一样，中国人没拿过，就能说中国没有特别优秀的文学作品吗？我们多数时候是自己要硬往西方价值观的套子里钻。 </p>
			if (![content isEqualToString:rubish]) {
				[completeReview appendString:content];
				
				if ([content hasPrefix:rubish]) {
					[completeReview deleteCharactersInRange:[completeReview rangeOfString:rubish]];
				}
				
				
			}				
			
			
			
	 	    			
			
			
			contentFinishFlag =1;
			
		}else{
			if (contentFinishFlag ==1) {
				break;
			}
			contentFinishFlag=0;
		}
		
		
			// Obtain first attribute from element
			//		TBXMLAttribute * attribute = element->firstAttribute;
			//		
			//			// if attribute is valid
			//		while (attribute) {
			//				// Display name and value of attribute to the log window
			//			NSLog(@"%@->%@ = %@",[TBXML elementName:element],[TBXML attributeName:attribute], [TBXML attributeValue:attribute]);
			//			
			//				// Obtain the next attribute
			//			attribute = attribute->next;
			//		}
		
			// if the element has child elements, process them
		if (element->firstChild) [self traverseElement:element->firstChild];
		
			// Obtain next sibling element
	} while ((element = element->nextSibling));  
	
	[self hideLoadingIndicator];

}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
		// Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
		// Return the number of rows in the section.
	switch (section) {
			
		default: return 1;
	}
}

	// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
		// Get cell
	static NSString *CellIdentifier = @"CellA";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
		// Display
	cell.textLabel.textColor = [UIColor blackColor];
	cell.textLabel.font = [UIFont systemFontOfSize:15];
	if (item) {
		
			// Item Info
	
		
			// Display
		
		
		switch (indexPath.section) {
//			case SectionHeader: {
//				
//				cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
//				
//				cell.textLabel.numberOfLines = 0;
//				
//				
//				
//				cell.textLabel.text= itemTitle;
//				
//					
//								
//			
//				
//				 
//				break;
//				
//			}
				
			case SectionDetail: {
					// Summary
				cell.textLabel.text = completeReview;
				cell.textLabel.numberOfLines = 0; // Multiline
		        break;
			}
			//case SectionFooter:{
//				
//				cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
//				cell.textLabel.text = @"查看完整评论";		
//				cell.textAlignment=1;
//				cell.selectionStyle=UITableViewCellSelectionStyleBlue;
//				break;
//			}
				
		}
	}
    
    return cell;
	
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
// if (indexPath.section==SectionFooter) {
//		
//		return 30;
//		
//	}else{

			// Get height of summary
		NSString *summary = @"[No Summary]";
		if (completeReview) summary = completeReview;
		summarySize = [summary sizeWithFont:[UIFont systemFontOfSize:15] 
						  constrainedToSize:CGSizeMake(self.view.bounds.size.width - 40, MAXFLOAT)  // - 40 For cell padding
							  lineBreakMode:UILineBreakModeWordWrap];
		
		return summarySize.height + 16; // Add padding
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
		// FOR DETAILCOMMAND PUSH the Nav
//	if (indexPath.section==SectionFooter) {
//		if (item.link) {
//			
//			NSLog(@"old%@",item.link);
//				//[item.link]
//			CompleteReviewTableViewController *completeReview = [[CompleteReviewTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
//			completeReview.item = self.item;
//			[self.navigationController pushViewController:completeReview animated:YES];
//			[completeReview release];
//		}
//	}
	
		// Deselect
	//[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)hideLoadingIndicator
{
	UIActivityIndicatorView *indicator =
	(UIActivityIndicatorView *)self.navigationItem.rightBarButtonItem;
	if ([indicator isKindOfClass:[UIActivityIndicatorView class]])
	{
		[indicator stopAnimating];
	}
	UIBarButtonItem *refreshButton =
	[[[UIBarButtonItem alloc]
	  initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
	  target:self
	  action:@selector(refresh:)]
	 autorelease];
	[self.navigationItem setRightBarButtonItem:refreshButton animated:YES];
}

- (void)showLoadingIndicator
{
	UIActivityIndicatorView *indicator =
	[[[UIActivityIndicatorView alloc]
	  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]
	 autorelease];
	indicator.frame = CGRectMake(0, 0, 24, 24);
	[indicator startAnimating];
	UIBarButtonItem *progress =
	[[[UIBarButtonItem alloc] initWithCustomView:indicator] autorelease];
	[self.navigationItem setRightBarButtonItem:progress animated:YES];
}



@end
