//
//  GeneraliPadViewController.m
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "GeneraliPadViewController.h"
#import "GeneraliPadCell.h"
#import "AppDelegate.h"

@interface GeneraliPadViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *oMainHeader; 
@end

@implementation GeneraliPadViewController

@synthesize aDataSource = _aDataSource;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

//-(void) viewWillLayoutSubviews {
//    
////    self.bg_img_view.translatesAutoresizingMaskIntoConstraints = NO;
//    NSDictionary *viewsDict = @{@"bgImage": self.bg_img_view,
//                                @"headerView" : self.oHeaderView };
//    
//    NSArray *bgConstraintTop = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[headerView][bgImage]"
//                                                                    options:0
//                                                                    metrics:nil
//                                                                      views:viewsDict];
//    NSArray *bgConstraintLeading = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bgImage]|"
//                                                                       options:0
//                                                                       metrics:nil
//                                                                         views:viewsDict];
//
//    [self.tableView addConstraints:bgConstraintTop];
//    [self.tableView addConstraints:bgConstraintLeading];
//    
//    [super viewWillLayoutSubviews];
//}

- (void) setADataSource:(NSArray *)aDataSource {
    if (_aDataSource != aDataSource) {
        //we sort our content by order id
        NSSortDescriptor *sortByOrderId = [NSSortDescriptor sortDescriptorWithKey:@"orderId" ascending:YES];
        NSArray *orderedDataSource = [aDataSource sortedArrayUsingDescriptors:@[sortByOrderId]];
        //new result can have a max capacity of [orderedDataSource count] elements
        NSMutableArray *tempResultDataSource = [NSMutableArray arrayWithCapacity:[orderedDataSource count]];
        
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:2];
        int maxElements = 2;
        int numElementsReached = maxElements;
        for (Navigation *oneElement in orderedDataSource) {
            
            if (numElementsReached > 0) {
                [tempArray addObject:oneElement];
                numElementsReached--;
            }
            
            if([tempArray count] == maxElements || //we have reached maximum of 2 elements
               [tempArray count] == [orderedDataSource count]) { //we have put all elements from source array into this one
                [tempResultDataSource addObject:[tempArray copy]];
                numElementsReached = maxElements; //reset
                [tempArray removeAllObjects]; //reset
            }
            
        }
        
        //the for-loop has been ended but not all elements have been added yet
        if ([tempArray count]!= 0) {
            [tempResultDataSource addObject:tempArray];
        }
        
        _aDataSource = tempResultDataSource;
    }
}

#pragma mark -- Helper Method
- (NSArray *) _navigationElementsForIndexPath:(NSIndexPath *)indexPath {
    
    //we can have only two result per row
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:2];
    
    
    
    return [result copy];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        [self _setupOrientationLandscapeConstraints];
    } else {
        [self _setupOrientationPortraitConstraints];
    }
}

#pragma mark -. Handling rotation and orientation
-(void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        
        [self _setupOrientationLandscapeConstraints];
        
    } else {
        
        [self _setupOrientationPortraitConstraints];
    }
}

- (void) _setupOrientationLandscapeConstraints {
    
    //only perform this on ipad
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (!appDelegate.isDeviceIPad) {
        return;
    }
    
    [self.oMainHeader setImage:[UIImage imageNamed:@"start_header-landscape"]];
    [self.oMainHeader invalidateIntrinsicContentSize];
}

- (void) _setupOrientationPortraitConstraints {
    
    //only perform this on ipad
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (!appDelegate.isDeviceIPad) {
        return;
    }
    
    [self.oMainHeader setImage:[UIImage imageNamed:@"start_header"]];
    [self.oMainHeader invalidateIntrinsicContentSize];
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.aDataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"General iPad Cell";
    NSArray *elements = [self.aDataSource objectAtIndex:indexPath.row];
    GeneraliPadCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (elements) {
        [cell setupWithNavigationElements:elements];;
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
