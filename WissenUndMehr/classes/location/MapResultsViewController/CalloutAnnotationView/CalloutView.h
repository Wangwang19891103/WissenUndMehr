//
//  CalloutView.h
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalloutView : UIView

@property (weak, nonatomic) IBOutlet UILabel *oTitle;
@property (weak, nonatomic) IBOutlet UILabel *oPLZ;
@property (weak, nonatomic) IBOutlet UILabel *oCity;
@property (weak, nonatomic) IBOutlet UILabel *oTel;
@property (weak, nonatomic) IBOutlet UILabel *oAdress;
@property (weak, nonatomic) IBOutlet UIButton *oCallBtn;
@property (weak, nonatomic) IBOutlet UIButton *oRouteBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cRouteBtnHorizontalToCallButton;
@end
