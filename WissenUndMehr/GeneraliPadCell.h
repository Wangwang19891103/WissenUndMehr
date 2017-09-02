//
//  GeneraliPadCell.h
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "GeneralCell.h"

@interface GeneraliPadCell : GeneralCell

-(void) setupWithNavigationElements:(NSArray *)elements;

@property (weak, nonatomic) IBOutlet ActionButton *oActionButtonTwo;
@property (weak, nonatomic) IBOutlet UILabel *oTitleTwo;
@property (weak, nonatomic) IBOutlet UIImageView *oImageTwo;
@property (weak, nonatomic) IBOutlet UIView *oContainerTwo;
@end
