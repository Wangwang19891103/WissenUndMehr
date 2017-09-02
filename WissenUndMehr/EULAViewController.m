//
//  EULAViewController.m
//  INHOUSESCHUELERHILFEDEFR
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "EULAViewController.h"
#import <MessageUI/MessageUI.h>

@interface EULAViewController () <UIWebViewDelegate,
UIActionSheetDelegate,
UIDocumentInteractionControllerDelegate,
MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *webViewBottomSpaceConstraint;
@property (weak, nonatomic) IBOutlet UIButton *btnAccept;
@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (nonatomic, strong) UIActionSheet *documentActionSheet;
@property (nonatomic, strong) UIBarButtonItem *actionsButton;
@property (nonatomic, strong) UIDocumentInteractionController *openInPopOver;
@end

@implementation EULAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"Datenschutzerklärung";
    [self.btnAccept setTitle:@"Ich nehme an" forState:UIControlStateNormal];
    
    
    //    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]
    //                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAction
    //                                  target:self
    //                                  action:@selector(showActions:)];
    //
    //    self.navigationItem.rightBarButtonItem = barButton;
    
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicator.hidesWhenStopped = YES;
    [self.view addSubview:self.indicator];
}

- (IBAction)btnAcceptDidTap:(UIButton *)sender
{
    if (NULL != _acceptActionBlock) {
        _acceptActionBlock();
    }
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.indicator.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.webView.loading) {
        [self.webView stopLoading];
    }
    
    self.webView.delegate = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.htmlString != nil && [self.htmlString length] > 0) {
        [self.webView loadHTMLString:self.htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
    } else if (self.loadRequest != nil) {
        [self.webView loadRequest:self.loadRequest];
    } else if (self.pdfFile != nil) {
        NSData *pdfData = [NSData dataWithContentsOfFile:self.pdfFile];
        [self.webView loadData:pdfData MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:nil];
    }
    
    if (self.isFromInfo) {
        self.webViewBottomSpaceConstraint.constant = 0;
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
    [self.indicator stopAnimating];
}

#pragma mark - Document Action Handlers
- (void)showActions:(id)sender
{
//    self.actionsButton = (UIBarButtonItem *)sender;
//    
//    if (self.documentActionSheet == nil) {
//        self.documentActionSheet = [[UIActionSheet alloc] initWithTitle:@"Was möchten Sie mit dem Dokument machen?"
//                                                               delegate:self
//                                                      cancelButtonTitle:nil
//                                                 destructiveButtonTitle:nil
//                                                      otherButtonTitles:nil];
//        [self.documentActionSheet addButtonWithTitle:@"Öffnen in..."];
//        
//        if ([MFMailComposeViewController canSendMail]) {
//            [self.documentActionSheet addButtonWithTitle:@"Email"];
//        }
//        
//        if ([UIPrintInteractionController isPrintingAvailable]) {
//            [self.documentActionSheet addButtonWithTitle:@"Drucken"];
//        }
//        
//        NSInteger cancelBtnIndex = [self.documentActionSheet addButtonWithTitle:ls(@"CANCEL")];
//        self.documentActionSheet.cancelButtonIndex = cancelBtnIndex;
//        
//        if ([Setup isDeviceIPad]) {
//            [self.documentActionSheet showFromBarButtonItem:self.actionsButton animated:YES];
//        } else {
//            [self.documentActionSheet showFromTabBar:self.tabBarController.tabBar];
//        }
//    } else {
//        [self.documentActionSheet dismissWithClickedButtonIndex:0 animated:YES];
//        self.documentActionSheet = nil;
//    }
//    
//    if (self.openInPopOver != nil) {
//        [self.openInPopOver dismissMenuAnimated:YES];
//        self.openInPopOver = nil;
//    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self showOpenInMenu];
            break;
        case 1:
            [self sendDocumentAsEmail];
            break;
        case 2:
            [self printDocument];
            break;
        default: {
            [self.documentActionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
            self.documentActionSheet = nil;
        }
            break;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    self.documentActionSheet = nil;
}

- (void)showOpenInMenu
{
//    //use the UIDocInteractionController API to get list of devices that support the file type
//    NSURL *pdfURL = self.webView.request.URL;// your pdf link.
//    
//    if (self.openInPopOver == nil) {
//        self.openInPopOver = [UIDocumentInteractionController interactionControllerWithURL:pdfURL];
//        self.openInPopOver.delegate = self;
//    }
//    
//    //present a drop down list of the apps that support the file type, click an item in the list will open that app while passing in the file.
//    
//    //    [self.documentActionSheet dismissWithClickedButtonIndex:0 animated:YES];
//    
//    bool didShow = NO;
//    if ([Setup isDeviceIPad]) {
//        didShow = [self.openInPopOver presentOpenInMenuFromBarButtonItem:self.actionsButton animated:YES];
//    } else {
//        didShow = [self.openInPopOver presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
//    }
//    
//    if (!didShow) {
//        NSLog(@"Open in Menu was not shown! No Applications found");
//    }
}

- (void)printDocument
{
//    UIPrintInteractionController *pc = [UIPrintInteractionController
//                                        sharedPrintController];
//    
//    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
//    printInfo.outputType = UIPrintInfoOutputGeneral;
//    printInfo.jobName = [self.webView.request.URL relativeString];
//    pc.printInfo = printInfo;
//    
//    UIPrintInteractionCompletionHandler completionHandler =
//    ^(UIPrintInteractionController *printController, BOOL completed,
//      NSError *error) {
//        if(!completed && error) {
//            NSLog(@"Print failed - domain: %@ error code %ld", error.domain,
//                  (long)error.code);
//        }
//    };
//    
//    UIViewPrintFormatter *formatter = [self.webView viewPrintFormatter];
//    pc.printFormatter = formatter;
//    
//    [self sendNotificationWithAction:@"print_action" andDocument:printInfo.jobName];
//    
//    if ([Setup isDeviceIPad]) {
//        [pc presentFromBarButtonItem:self.actionsButton animated:YES
//                   completionHandler:completionHandler];
//    } else {
//        [pc presentAnimated:YES completionHandler:completionHandler];
//    }
}

- (void)sendDocumentAsEmail
{
//    NSString *emailTitle = @"Schülerhilfe Lerngutschein";
//    NSString *messageBody = @"Hier ist ein Lerngutschein für dich!";
//    //    NSArray *toRecipents = [NSArray arrayWithObject:@"support@appcoda.com"];
//    
//    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
//    mc.mailComposeDelegate = self;
//    [mc setSubject:emailTitle];
//    [mc setMessageBody:messageBody isHTML:NO];
//    
//    // Determine the file name and extension
//    //    NSString *file = [self.webView.request.URL relativePath];
//    //    NSArray *filepart = [file componentsSeparatedByString:@"."];
//    NSString *filename = [[Config sharedInstance] helpInfoForKey:@"VOUCHER_FILENAME"];
//    NSString *extension = @"pdf";
//    
//    // Get the resource path and read the file using NSData
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:extension];
//    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
//    
//    // Determine the MIME type
//    NSString *mimeType = nil;
//    if ([extension isEqualToString:@"jpg"]) {
//        mimeType = @"image/jpeg";
//    } else if ([extension isEqualToString:@"png"]) {
//        mimeType = @"image/png";
//    } else if ([extension isEqualToString:@"doc"]) {
//        mimeType = @"application/msword";
//    } else if ([extension isEqualToString:@"ppt"]) {
//        mimeType = @"application/vnd.ms-powerpoint";
//    } else if ([extension isEqualToString:@"html"]) {
//        mimeType = @"text/html";
//    } else if ([extension isEqualToString:@"pdf"]) {
//        mimeType = @"application/pdf";
//    } else {
//        //default
//        mimeType = @"image/png";
//    }
//    
//    // Add attachment
//    [mc addAttachmentData:fileData mimeType:mimeType fileName:filename];
//    
//    // Present mail view controller on screen
//    
//    [self presentViewController:mc animated:YES completion:NULL];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultCancelled:
//            [self sendNotificationWithAction:@"email_action_cancelled" andDocument:[[Config sharedInstance] helpInfoForKey:@"VOUCHER_FILENAME"]];
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent: {
//            [self sendNotificationWithAction:@"email_action_successfull" andDocument:[[Config sharedInstance] helpInfoForKey:@"VOUCHER_FILENAME"]];
            NSLog(@"Mail sent");
            break;
        }
        case MFMailComposeResultFailed:
//            [self sendNotificationWithAction:@"email_action_failed" andDocument:[[Config sharedInstance] helpInfoForKey:@"VOUCHER_FILENAME"]];
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark -- Google Analytics
- (void)sendNotificationWithAction:(NSString *)actionName andDocument:(NSString *)documentName
{
    if (!actionName || !documentName) {
        return;
    }
//    
//    NSDictionary *options = @{@"action_name" : actionName,
//                              @"document_name" : documentName};
//
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_TYPE_DOCUMENT_INTERACTION object:nil userInfo:options];
}

//#pragma mark - UIDocumentInteractionControllerDelegate Methods
//
//- (void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller
//{
//    self.openInPopOver = nil;
//}
//
//- (void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application
//{
//    [self.openInPopOver dismissMenuAnimated:YES];
//    self.openInPopOver = nil;
//    
//    [self sendNotificationWithAction:@"open_in_application" andDocument:application];
//}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return YES;
//}
//
//- (void)didReceiveMemoryWarning
//{
//    // Releases the view if it doesn't have a superview.
//    [super didReceiveMemoryWarning];
//    
//    // Release any cached data, images, etc that aren't in use.
//}

@end
