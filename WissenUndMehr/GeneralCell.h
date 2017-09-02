//
//  DocumentTableViewCell.h
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Navigation.h"
#import "ActionButton.h"
#import "Document.h"
#import "Link.h"
#import "Image.h"
#import "Video.h"

@interface GeneralCell : UITableViewCell

@property (weak, nonatomic) IBOutlet ActionButton *oActionButton;
@property (weak, nonatomic) IBOutlet UIImageView *oImage;
@property (weak, nonatomic) IBOutlet UILabel *oTitle;

- (void) setupWithNavigation:(Navigation *)aDocument;
@end
