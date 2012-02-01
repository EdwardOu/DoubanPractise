    //
	//  LastestMeidaViewController.m
	//  Douban
	//
	//  Created by ou on 11-12-22.
	//  Copyright 2011 __MyCompanyName__. All rights reserved.
	//

#import "LastestCommandViewController.h"

#import "NibLoadedCell.h"
#import "NibLoadedCell2.h"
#import "GradientBackgroundTable.h"

@implementation LastestCommandViewController




-(id)init{
	
	if (self=[super init]) {
		self.title=@"最新评论";
		self.navigationItem.title=@"豆瓣";
		
		self.tabBarItem.image=[UIImage imageNamed:@"home.png"];
		
		tableViewArray=[[NSArray alloc] initWithObjects:@"音乐评论",@"电影评论",@"书籍评论",nil];
		
		
	}
	return self;
}



- (void)viewDidLoad {
	[super viewDidLoad];
	
	
	self.useCustomHeaders = YES;
	[self refresh:nil];	
	
	
	
	
}

- (void)refresh:(id)sender
{
	
	[self removeAllSectionsWithAnimation:UITableViewRowAnimationFade];
	[self performSelector:@selector(createRows) withObject:nil afterDelay:0.5];
	[self showLoadingIndicator];
    
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
	//
	// 
	//
	// create Rows & config them		
    //
- (void)createRows
{
	
	[self addSectionAtIndex:0 withAnimation:UITableViewRowAnimationFade];
	
	[self
	 appendRowToSection:0
	 cellClass:[NibLoadedCell2 class]
	 
	 cellData:@"Book Reviews"  
	 
	 withAnimation:
	 UITableViewRowAnimationLeft ];
	
	
	
	[self addSectionAtIndex:1 withAnimation:UITableViewRowAnimationFade];
	
	[self
	 appendRowToSection:0
	 cellClass:[NibLoadedCell2 class]
	 cellData:@"Moive Reviews" 
	 
	 withAnimation:
	 UITableViewRowAnimationLeft];
	
	
	
	
	[self addSectionAtIndex:2 withAnimation:UITableViewRowAnimationFade];
	
	[self
	 appendRowToSection:0
	 cellClass:[NibLoadedCell2 class]
	 cellData:@"Music Reviews"  
	 
	 withAnimation:
	 UITableViewRowAnimationLeft];
	
	[self hideLoadingIndicator];
}




- (void)didReceiveMemoryWarning {
		// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
		// Release any cached data, images, etc. that aren't in use.
}







- (void)dealloc {
	[super dealloc];
}


@end
