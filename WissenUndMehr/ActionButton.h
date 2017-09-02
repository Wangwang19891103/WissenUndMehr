//
//  ActionButton.h
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Document.h"
#import "Link.h"
#import "Video.h"

typedef enum {
    ActionTypeDocument = 0,
    ActionTypeLink = 1,
    ActionTypeVideo = 2
} ActionType;

@interface ActionButton : UIButton

@property (nonatomic, strong) Document *aDocument;
@property (nonatomic, strong) Link *aLink;
@property (nonatomic, strong) Video *aVideo;

@property (nonatomic, strong) NSString *actionURL;
@property (nonatomic) ActionType actionType;

@end
