//
//  NibLoadedCell.h
//  TableDesignRevisited
//
//  Created by Paul Wong on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

#import "PageCell.h"

@interface NibLoadedCell : PageCell
{
	IBOutlet UILabel *label;
	IBOutlet UIImageView *image;
	IBOutlet UILabel *broadcast;	
	 IBOutlet UIButton *button;
	
}
@property (nonatomic, assign) UILabel *broadcast;
@property (nonatomic, assign) UILabel *label;
@property (nonatomic, assign) UIImageView *image;
@property (nonatomic, assign)IBOutlet UIButton *button;
+(void)setBroadCast:(NSString *)BroadCast;

@end
