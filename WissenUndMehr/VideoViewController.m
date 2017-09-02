//
//  VideoViewController.m
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "VideoViewController.h"
#import "AppDelegate.h"

@interface VideoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *oTitle;
@property (weak, nonatomic) IBOutlet UILabel *oSummary;
@property (strong, nonatomic) IBOutlet UIImageView *oBookImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cBodyVSpaceToContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cTitleVSpaceToContainer;
@end

@implementation VideoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.oWebView.scrollView.alwaysBounceVertical = NO;
    
    if (self.video) {
        [self.oTitle setText:self.video.title];
        [self.oSummary setText:self.video.summary];
        self.title = self.video.title;
    }
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if (self.video) {
        // HTML to embed YouTube video
        NSString *youTubeVideoHTML = @""
        "<html><head>"
        "<meta name=\"viewport\" content=\"width = device-width\">"
        "<style type=\"text/css\">"
        "body {"
        "background-color: transparent;"
        "color: white;"
        "}"
        "</style>"
        "</head><body style=\"margin:0\">"
        "<iframe width=\"%0.0f\" height=\"%0.0f\" src=\"%@\" frameborder=\"0\" allowfullscreen></iframe>"
//        "<object width=\"%0.0f\" height=auto><param name=\"movie\" value=\"%@&autoplay=1\">"
//        "</param><embed src=\"%@&autoplay=1\" type=\"application/x-shockwave-flash\" width=\"%0.0f\" height=\"%0.0f\"></embed></object>"
        "</body></html>";
        // Populate HTML with the URL and requested frame size
        NSString *html = [NSString stringWithFormat:youTubeVideoHTML,
                          self.oWebView.frame.size.width,
                          self.oWebView.frame.size.height,
                          self.video.url];
        
        // Load the html into the webview
        [self.oWebView loadHTMLString:html baseURL:nil];
    }
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        [self _setupOrientationLandscapeConstraints];
    } else {
        [self _setupOrientationPortraitConstraints];
    }
}

#pragma mark -. Handling rotation and orientation
-(void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    [UIView animateWithDuration:duration animations:^{
        [self updateViewConstraints];
        [self.view layoutIfNeeded];
    }];
    
}

- (void) _setupOrientationLandscapeConstraints {
    
    //only perform this on ipad
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (!appDelegate.isDeviceIPad) {
        return;
    }
    
//    [self.oBookImage removeFromSuperview];
    self.oBookImage.hidden = YES;
    self.cTitleVSpaceToContainer.constant = 20.0f;
    self.cBodyVSpaceToContainer.constant = 20.0f;
}

- (void) _setupOrientationPortraitConstraints {
    
    //only perform this on ipad
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (!appDelegate.isDeviceIPad) {
        return;
    }
    
//    if (self.oBookImage.superview == nil) {
//        [self.oContainerView addSubview:self.oBookImage];
//    }
    self.oBookImage.hidden = NO;
    self.cTitleVSpaceToContainer.constant = 310.0f;
    self.cBodyVSpaceToContainer.constant = 310.0f;
}

-(BOOL) shouldAutorotate {
    return NO;
}

-(NSUInteger) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UIWebview Delegate Methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
//    NSLog(@"Should start loading URL: %@", request.URL.absoluteString);
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
//    NSLog(@"Loading of video started.");
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"Loading of video %@ finished.", webView.request.URL.absoluteString);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"Loading of video failed: %@",error.localizedDescription);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
