//
//  PocketGuideViewController.m
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "PocketGuideViewController.h"
#import "Navigation.h"
#import "DocumentViewController.h"

@interface PocketGuideViewController ()
- (IBAction)openPDFButtonPressed:(id)sender;

//- (void) _setupOrientationLandscapeConstraints;
//- (void) _setupOrientationPortraitConstraints;

@end

@implementation PocketGuideViewController

@synthesize dataSource = _dataSource;
@synthesize aTitle = _aTitle;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.aTitle;
    
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self _setupContent];
}

-(void) setDataSource:(NSArray *)dataSource {
    if (_dataSource != dataSource) {
        NSSortDescriptor *sortById = [NSSortDescriptor sortDescriptorWithKey:@"orderId" ascending:YES];
        _dataSource = [dataSource sortedArrayUsingDescriptors:@[sortById]];
    }
}

-(void) _setupContent {
    // Do any additional setup after loading the view.
    if (self.dataSource) {
        if ([self.dataSource count] == [self.oButtons count]) {
            
            NSSortDescriptor *sortByTag = [NSSortDescriptor sortDescriptorWithKey:@"tag" ascending:YES];
            self.oButtonTitles = [self.oButtonTitles sortedArrayUsingDescriptors:@[sortByTag]];
            self.oButtonSubtitles = [self.oButtonSubtitles sortedArrayUsingDescriptors:@[sortByTag]];
            
            for (UIButton *aButton in self.oButtons) {
                
                Navigation *navigationElement = [self.dataSource objectAtIndex:aButton.tag];

                UILabel *titleLabel = [self.oButtonTitles objectAtIndex:aButton.tag];
                [titleLabel setText:navigationElement.title];
                
                UILabel *subTitleLabel = [self.oButtonSubtitles objectAtIndex:aButton.tag];
                [subTitleLabel setText:navigationElement.subtitle];
                [subTitleLabel invalidateIntrinsicContentSize];
                //[aButton setTitle:navigationElement.title forState:UIControlStateNormal];
            }
            
        }
    }
}

- (IBAction)openPDFButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"openPDF" sender:sender];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UIButton *clickedButton = (UIButton *)sender;
    Navigation *navigationElement = [self.dataSource objectAtIndex:clickedButton.tag];
    
    if ([segue.identifier isEqualToString:@"openPDF"]) {
        if (navigationElement.document) {
            DocumentViewController *targetVC = segue.destinationViewController;
            targetVC.aDocument = navigationElement.document;
        }
    }
    
}

//#pragma mark -. Handling rotation and orientation
//- (void) _setupOrientationLandscapeConstraints {
//    
//    //only perform this on ipad
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    if (!appDelegate.isDeviceIPad) {
//        return;
//    }
//    
//    [self.oHeaderImage setImage:[UIImage imageNamed:@"start_header-landscape"]];
//    [self.oHeaderImage invalidateIntrinsicContentSize];
//}
//
//- (void) _setupOrientationPortraitConstraints {
//    
//    //only perform this on ipad
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    if (!appDelegate.isDeviceIPad) {
//        return;
//    }
//    
//    [self.oHeaderImage setImage:[UIImage imageNamed:@"start_header"]];
//    [self.oHeaderImage invalidateIntrinsicContentSize];
//    
//}

-(BOOL) shouldAutorotate {
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
