//
//  ActionWebViewViewController.h
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "DocumentViewController.h"
#import <MessageUI/MessageUI.h>

@interface ActionWebViewViewController : DocumentViewController <UIActionSheetDelegate, UIDocumentInteractionControllerDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) UIActionSheet *documentActionSheet;
@property (nonatomic, strong) UIDocumentInteractionController *openInPopOver;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *oActionButton;
- (IBAction)actionButtonPressed:(id)sender;
@end
