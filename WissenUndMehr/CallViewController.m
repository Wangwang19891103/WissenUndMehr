//
//  CallViewController.m
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "CallViewController.h"
#import "Link.h"

@interface CallViewController ()

@property (nonatomic, strong) NSString *telNumber;
@property (weak, nonatomic) IBOutlet UILabel *oTitle;
@property (weak, nonatomic) IBOutlet UILabel *oSubTitle;
@property (weak, nonatomic) IBOutlet UIButton *oCallButton;

- (IBAction)callButtonPressed:(id)sender;
- (void) callNumber;

@end

@implementation CallViewController

@synthesize navigationElement = _navigationElement;
@synthesize telNumber;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (self.navigationElement) {
        if (self.navigationElement.link &&
            [self.navigationElement.link.name isEqualToString:@"CallNumber"]) {
            self.telNumber = self.navigationElement.link.fileURL;
            
            [self.oTitle setText:self.navigationElement.title];
            [self.oSubTitle setText:self.navigationElement.subtitle];
        }
    }
}

-(BOOL) shouldAutorotate {
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)callButtonPressed:(id)sender {
    
    [self callNumber];
}

- (void) callNumber {
    
    NSString *number = [NSString stringWithFormat:@"%@",[self.telNumber stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURL* callUrl=[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",number]];
    
    //check  Call Function available only in iphone
    if([[UIApplication sharedApplication] canOpenURL:callUrl])
    {
        [[UIApplication sharedApplication] openURL:callUrl];
    }
    
}

@end
