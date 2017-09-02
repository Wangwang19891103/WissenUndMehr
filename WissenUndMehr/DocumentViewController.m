//
//  DocumentViewController.m
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "DocumentViewController.h"

@interface DocumentViewController ()

@property (nonatomic, strong) UIBarButtonItem *backButton;

@end

@implementation DocumentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Calling -loadDocument:inView:
    if (self.aDocument) {
        [self loadDocument:self.aDocument.fileName inView:self.oWebView];
        self.title = self.aDocument.name;
    }    
}

-(void)loadDocument:(NSString*)documentName inView:(UIWebView*)webView
{
    if (!documentName && [documentName length] == 0) {
        return;
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:nil];
    self.aDocumentFileURL = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:self.aDocumentFileURL];
    [webView loadRequest:request];
}

//- (void) setADocument:(Document *)aDocument {
//    if (_aDocument != aDocument) {
//        _aDocument = aDocument;
//        
//        //we set the filepath
//        if (_aDocument.filePath && [_aDocument.filePath length] > 0) {
//            NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
//            _aDocumentFilePath = [bundlePath stringByAppendingString:_aDocument.filePath];
//        }
//    }
//}

#pragma mark - UIWebviewDelegate Methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    NSURL *mainDocumentURL = request.mainDocumentURL;
    return YES;
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"Loading request for file: %@ has started.",self.aDocumentFileURL.description);
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"Loading request for file: %@ has finished.",self.aDocumentFileURL.description);
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"Loading request for file: %@ did fail with error: %@.",self.aDocumentFileURL.description,error.localizedFailureReason);
}

-(BOOL) shouldAutorotate {
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
