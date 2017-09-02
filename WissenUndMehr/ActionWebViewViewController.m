//
//  ActionWebViewViewController.m
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "ActionWebViewViewController.h"
#import "AppDelegate.h"

@interface ActionWebViewViewController ()

@end

@implementation ActionWebViewViewController

@synthesize documentActionSheet = _documentActionSheet;
@synthesize openInPopOver;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark - UIWebviewDelegate Methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //    NSURL *mainDocumentURL = request.mainDocumentURL;
    return YES;
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"Loading request for file: %@ has started.",webView.request.mainDocumentURL.description);
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"Loading request for file: %@ has finished.",webView.request.mainDocumentURL.description);
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"Loading request for file: %@ did fail with error: %@.",webView.request.mainDocumentURL.description,error.localizedFailureReason);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UIActionButton Methods

- (IBAction)actionButtonPressed:(id)sender {
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    if (self.documentActionSheet == nil) {
        self.documentActionSheet = [[UIActionSheet alloc] initWithTitle:@"Lerngutschein Aktion"
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                 destructiveButtonTitle:nil
                                                      otherButtonTitles:nil];
        
        [self.documentActionSheet addButtonWithTitle:@"Öffnen in..."];
        
        if ([MFMailComposeViewController canSendMail]) {
            [self.documentActionSheet addButtonWithTitle:@"Email"];
        }
        
        if ([UIPrintInteractionController isPrintingAvailable]) {
            [self.documentActionSheet addButtonWithTitle:@"Drucken"];
        }
        
        NSInteger cancelBtnIndex = [self.documentActionSheet addButtonWithTitle:@"Abbrechen"];
        self.documentActionSheet.cancelButtonIndex = cancelBtnIndex;
        
        if ([appDelegate isDeviceIPad]) {
            [self.documentActionSheet showFromBarButtonItem:self.oActionButton animated:YES];
        } else {
            [self.documentActionSheet showInView:self.view];
        }
        
    } else {
        [self.documentActionSheet dismissWithClickedButtonIndex:0 animated:YES];
        self.documentActionSheet = nil;
    }
    
    if (self.openInPopOver != nil) {
        [self.openInPopOver dismissMenuAnimated:YES];
        self.openInPopOver = nil;
    }
    
}

- (void) showOpenInMenu {
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    //use the UIDocInteractionController API to get list of devices that support the file type
    NSURL *pdfURL = self.aDocumentFileURL;// the pdf link.
    
    if (self.openInPopOver == nil) {
        self.openInPopOver = [UIDocumentInteractionController interactionControllerWithURL:pdfURL];
        self.openInPopOver.delegate = self;
    }
    
    bool didShow = NO;
    if ([appDelegate isDeviceIPad]) {
        
        didShow = [self.openInPopOver presentOpenInMenuFromBarButtonItem:self.oActionButton animated:YES];
    } else {
        didShow = [self.openInPopOver presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
    }
    
    if (!didShow) {
        NSLog(@"Open in Menu was not shown! No Applications found");
    }
    
}

- (void)printDocument {
    
    UIPrintInteractionController *pc = [UIPrintInteractionController
                                        sharedPrintController];
    
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    printInfo.jobName = [self.aDocumentFileURL relativeString];
    pc.printInfo = printInfo;
    
    UIPrintInteractionCompletionHandler completionHandler =
    ^(UIPrintInteractionController *printController, BOOL completed,
      NSError *error) {
        if(!completed && error){
            NSLog(@"Print failed - domain: %@ error code %ld", error.domain,
                  (long)error.code);
        }
    };
    
    UIViewPrintFormatter *formatter = [self.oWebView viewPrintFormatter];
    pc.printFormatter = formatter;
    
//    [self sendNotificationWithAction:@"print_action" andDocument:printInfo.jobName];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    if ([appDelegate isDeviceIPad]) {
        [pc presentFromBarButtonItem:self.oActionButton animated:YES
                   completionHandler:completionHandler];
    } else {
        [pc presentAnimated:YES completionHandler:completionHandler];
    }
    
}

- (void) sendDocumentAsEmail {
    NSString *emailTitle = @"Schülerhilfe Lerngutschein";
    NSString *messageBody = @"Hier ist ein Lerngutschein für dich!";
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    
    // Determine the file name and extension
    NSString *filename = self.aDocument.fileName;
    NSString *extension =  @"pdf";
    
    // Get the resource path and read the file using NSData
    NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    // Determine the MIME type
    NSString *mimeType;
    if ([extension isEqualToString:@"jpg"]) {
        mimeType = @"image/jpeg";
    } else if ([extension isEqualToString:@"png"]) {
        mimeType = @"image/png";
    } else if ([extension isEqualToString:@"doc"]) {
        mimeType = @"application/msword";
    } else if ([extension isEqualToString:@"ppt"]) {
        mimeType = @"application/vnd.ms-powerpoint";
    } else if ([extension isEqualToString:@"html"]) {
        mimeType = @"text/html";
    } else if ([extension isEqualToString:@"pdf"]) {
        mimeType = @"application/pdf";
    }
    
    // Add attachment
    [mc addAttachmentData:fileData mimeType:mimeType fileName:filename];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
//            [self sendNotificationWithAction:@"email_action_cancelled" andDocument:VOUCHER_FILENAME];
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent: {
//            [self sendNotificationWithAction:@"email_action_successfull" andDocument:VOUCHER_FILENAME];
            NSLog(@"Mail sent");
            break;
        }
        case MFMailComposeResultFailed:
//            [self sendNotificationWithAction:@"email_action_failed" andDocument:VOUCHER_FILENAME];
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark -- UIActionSheetDelegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    self.documentActionSheet = nil;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
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
        default:{
            [self.documentActionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
            self.documentActionSheet = nil;
            break;
        }
    }
    
}

#pragma mark - UIDocumentInteractionControllerDelegate Methods

- (void) documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller {
    
    self.openInPopOver = nil;
}

- (void) documentInteractionController: (UIDocumentInteractionController *) controller didEndSendingToApplication: (NSString *) application {
    [self.openInPopOver dismissMenuAnimated:YES];
    self.openInPopOver = nil;
    
//    [self sendNotificationWithAction:@"open_in_application" andDocument:application];
}

-(BOOL) shouldAutorotate {
    return NO;
}

@end
