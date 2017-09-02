//
//  CalloutView.m
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "CalloutView.h"

@implementation CalloutView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) layoutSubviews {
    
    if (self.oCallBtn.superview == nil) { //if button has been removed
        [self removeConstraint:self.cRouteBtnHorizontalToCallButton];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[routeBtn]" options:0 metrics:nil views:@{@"routeBtn": self.oRouteBtn}]];
    }
    
    [super layoutSubviews];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
