//
//  EULAViewController.h
//  INHOUSESCHUELERHILFEDEFR
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EULAViewController : UIViewController

@property (nonatomic, assign) BOOL isFromInfo;
@property (nonatomic, strong) NSString *htmlString;
@property (nonatomic, strong) NSURLRequest *loadRequest;
@property (nonatomic, strong) NSString *pdfFile;
@property (nonatomic, copy) void (^acceptActionBlock)(void);

@end
