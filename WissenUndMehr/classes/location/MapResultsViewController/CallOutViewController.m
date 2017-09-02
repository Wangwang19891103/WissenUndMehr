//
//  CallOutViewController.m
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//
#import "CallOutViewController.h"
#import "Location.h"
#import "LocationManager.h"
@interface CallOutViewController ()

@end

@implementation CallOutViewController

@synthesize annotation = _annotation;

- (id) initWithAnnotation:(Annotation *)anAnnotation {
    
    self = [super initWithNibName:@"CallOutViewController" bundle:nil];
    
    if (self) {
        self.annotation = anAnnotation;
    }
    
    return self;
}

- (IBAction)callButtonPressed:(id)sender {
    [self callNumber];
}

- (IBAction)routeButtonPressed:(id)sender {
    MKMapItem *mapItem = [[LocationManager instance] mapItemFromLocation:self.annotation.location];
    [MKMapItem openMapsWithItems:@[mapItem] launchOptions:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CalloutView *myView = (CalloutView *)self.view;
    [myView.oTitle setText:self.annotation.location.name];
    [myView.oAdress setText:[NSString stringWithFormat:@"%@ %@",self.annotation.location.strasse,self.annotation.location.hausnr]];
    [myView.oCity setText:self.annotation.location.ort];
    [myView.oPLZ setText:self.annotation.location.plz];
    [myView.oTel setText:[NSString stringWithFormat:@"%@-%@",self.annotation.location.vorwahl,self.annotation.location.rufnr]];
    
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]]) {
        [myView.oCallBtn removeFromSuperview];
        [myView setNeedsLayout];
    }
}

- (void) callNumber {
    NSString *telNumber = [NSString stringWithFormat:@"%@ %@",self.annotation.location.vorwahl,self.annotation.location.rufnr];
    NSString *number = [telNumber stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* callUrl=[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",number]];
    
    //check  Call Function available only in iphone
    if([[UIApplication sharedApplication] canOpenURL:callUrl])
    {
        [[UIApplication sharedApplication] openURL:callUrl];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
