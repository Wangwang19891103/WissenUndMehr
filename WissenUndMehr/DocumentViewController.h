//
//  DocumentViewController.h
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Document.h"

@interface DocumentViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *oWebView;
@property (nonatomic, strong) Document *aDocument;
//@property (nonatomic, strong) NSString *aDocumentFilePath;
@property (nonatomic, strong) NSURL *aDocumentFileURL;

@end
