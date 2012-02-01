//
//  NibLoadedCell.h
//  TableDesignRevisited
//
//  Created by Paul Wong on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

#import "PageCell.h"

@interface NibLoadedCell2 : PageCell
{
	IBOutlet UILabel *label;
	IBOutlet UIImageView *image;
	IBOutlet UILabel *broadcast;	
}
@property (nonatomic, assign) UILabel *broadcast;
@property (nonatomic, assign) UILabel *label;
@property (nonatomic, assign) UIImageView *image;


@end
