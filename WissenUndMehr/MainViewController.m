//
//  MainViewController.m
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "MainViewController.h"
#import "DataManager.h"
#import "Navigation+Create.h"
#import "PocketGuideViewController.h"
#import "GeneralViewController.h"
#import "VideoViewController.h"
#import "VoucherViewController.h"
#import "CallViewController.h"
#import "DocumentViewController.h"
#import "AppDelegate.h"

@interface MainViewController ()
@property (strong, nonatomic)  NSArray *cBookImageVertSpace;
@property (strong, nonatomic) NSArray *verticalContraintBetweenButtonAndMainContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cButtonWidth;
- (IBAction)generalViewControllerButtonPressed:(id)sender;
- (IBAction)voucherHeaderButtonPressed:(id)sender;

- (void) _setupOrientationLandscapeConstraints;
- (void) _setupOrientationPortraitConstraints;
@end

@implementation MainViewController

@synthesize contentData = _contentData;
@synthesize dataSource = _dataSource;
@synthesize oBottomMostButton, oMainContainer;
@synthesize verticalContraintBetweenButtonAndMainContainer, cBookImageVertSpace;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"Schülerhilfe";
    
    if (!self.contentData) {  // for demo purposes, we'll create a default database if none is set
        
        //we are performing io operations on a background thread
        dispatch_queue_t fetchQ = dispatch_queue_create("Data importer", NULL);
        dispatch_async(fetchQ, ^{
            
            //first we check if we have a preshipped database in our bundle
            NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *bundlePathToPreshippedDB = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[DataManager getDatabaseName]];
            NSString *documentsFolderPath = [documentsDirectory stringByAppendingPathComponent:[DataManager getDatabaseName]];
            
            if (![[NSFileManager defaultManager] fileExistsAtPath:documentsFolderPath] &&
                [[NSFileManager defaultManager] fileExistsAtPath:bundlePathToPreshippedDB]) {
                NSError *error = nil;
                if (![DataManager atomicCopyItemAtURL:[NSURL fileURLWithPath:bundlePathToPreshippedDB] toURL:[NSURL fileURLWithPath:documentsFolderPath] error:&error]) {
                    NSLog(@"Error copying file: %@",error.localizedDescription);
                }
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //we set our content data on the main queue
                self.contentData = [DataManager getManagedDocument];
            });
        });
        
    }
}

- (void) viewWillAppear:(BOOL)animated {
    
    if (!self.dataSource) {
        //show us some waiting screen
        [self.oMainContainer setHidden:YES];
    } else {
        [self refreshUI];
    }
    
    [self _hideNavigationBar:YES];
    
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        [self _setupOrientationLandscapeConstraints];
    } else {
        [self _setupOrientationPortraitConstraints];
    }
    
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated {
    
    [self _hideNavigationBar:NO];
    
    [super viewWillDisappear:animated];
}


- (IBAction)generalViewControllerButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"openGeneralVC" sender:sender];
}

- (IBAction)voucherHeaderButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"openVoucherVC" sender:sender];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UIButton *clickedButton = (UIButton *)sender;
    Navigation *navItem = [self.dataSource objectAtIndex:clickedButton.tag];
    if (!navItem) {
        return;
    }
    
    if ([segue.identifier isEqualToString:@"openGuideVC"]) {
        PocketGuideViewController *navigationController = segue.destinationViewController;
        navigationController.dataSource = [NSArray arrayWithArray:[navItem.children allObjects]];
        navigationController.aTitle = navItem.title;
    } else if ([segue.identifier isEqualToString:@"openGeneralVC"]) {
        GeneralViewController *targetVC = segue.destinationViewController;
        targetVC.aDataSource = [NSArray arrayWithArray:[navItem.children allObjects]];
        targetVC.title = navItem.title;
    } else if ([segue.identifier isEqualToString:@"openVoucherVC"]) {
        VoucherViewController *targetVC = segue.destinationViewController;
        targetVC.navigation = [navItem.children anyObject];
        targetVC.title = navItem.title;
    } else if ([segue.identifier isEqualToString:@"openCallVC"]){
        CallViewController *targetVC = segue.destinationViewController;
        targetVC.navigationElement = [navItem.children anyObject];
        targetVC.title = navItem.title;
    } else if ([segue.identifier isEqualToString:@"openHTML"]) {
        DocumentViewController *targetVC = segue.destinationViewController;
        targetVC.aDocument = navItem.document;
        targetVC.title = navItem.title;
    } else if ([segue.identifier isEqualToString:@"openMapSearch"]) {
        
    }
}

#pragma mark -- Handle Rotations

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
    
    if (self.cBookImageVertSpace != nil) {
        [self.oMainContainer removeConstraints:self.cBookImageVertSpace];
    }
    
    if (self.verticalContraintBetweenButtonAndMainContainer == nil) {
        //setting up constraint for synamic layout changes
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(oBottomMostButton);
        
        self.verticalContraintBetweenButtonAndMainContainer = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[oBottomMostButton]-(20)-|"
                                                                                                      options:0 metrics:nil views:viewsDictionary];
    }
    [self.oMainContainer addConstraints:self.verticalContraintBetweenButtonAndMainContainer];
    
    self.cButtonWidth.constant = 280.0;
    [self.otitleImageView setImage:[UIImage imageNamed:@"start_header-landscape"]];
    [self.otitleImageView invalidateIntrinsicContentSize];
}

- (void) _setupOrientationPortraitConstraints {
    
    //only perform this on ipad
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (!appDelegate.isDeviceIPad) {
        return;
    }
    
    self.cButtonWidth.constant = 328.0;
    
    if (self.verticalContraintBetweenButtonAndMainContainer != nil) {
        [self.oMainContainer removeConstraints:self.verticalContraintBetweenButtonAndMainContainer];
    }
    
    if (self.cBookImageVertSpace == nil) {
        NSDictionary *viewDict = @{@"bookImage": self.oBookImage,
                                   @"headerImage": self.otitleImageView};
        self.cBookImageVertSpace = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[headerImage]-344-[bookImage]"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:viewDict];
        
    }
    [self.oMainContainer addConstraints:self.cBookImageVertSpace];
    [self.otitleImageView setImage:[UIImage imageNamed:@"start_header"]];
    [self.otitleImageView invalidateIntrinsicContentSize];

}

#pragma mark -- Init Helper Methods

- (void)setupContentDataIntoDocument:(UIManagedDocument *)document
{
    dispatch_queue_t fetchQ = dispatch_queue_create("Data fetcher", NULL);
    dispatch_async(fetchQ, ^{
        NSArray *contentData = [DataManager importDataFromFile:@"ContentFile"];
        [document.managedObjectContext performBlock:^{ // perform in the NSMOC's safe thread (main thread)
            
            NSFetchRequest *fetchAllNavigation = [NSFetchRequest fetchRequestWithEntityName:@"Navigation"];
            NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
            fetchAllNavigation.sortDescriptors = @[sortByName];
            NSError *error = nil;
            NSArray *resultBeforeImport = [document.managedObjectContext executeFetchRequest:fetchAllNavigation error:&error];
            
            NSMutableArray *resultFromImport = [NSMutableArray arrayWithCapacity:[contentData count]];
            
            for (NSDictionary *contentInfo in contentData) {
                //we create one navigation link in the database
                Navigation *navElement = [Navigation navigationFromInfoDict:contentInfo inManagedObjectContext:document.managedObjectContext];
                [resultFromImport addObject:navElement];
            }
            
            //we find any orphaned elements that need to be deleted
            NSArray *orphanedElements = [DataManager determineOrphanedElements:resultFromImport oldImport:resultBeforeImport];
            
            //we delete orphaned navigation elements
            for (Navigation *navElementToDelete in orphanedElements) {
                [document.managedObjectContext deleteObject:navElementToDelete];
            }
            
            [document saveToURL:document.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success){
                [self refreshDataSource];
            }];
            
        }];
    });
}

- (void) refreshUI {
    [self setupViewElements];
}

- (void) refreshDataSource {
    
    //we do our fetching from the database and set our datasource with the data
    NSArray *resultingData = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Navigation"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"orderId" ascending:YES]];
    request.predicate = [NSPredicate predicateWithFormat:@"parent == nil"];
    
    //do fetching and save into resultingData
    NSError *error;
    resultingData = [self.contentData.managedObjectContext executeFetchRequest:request error:&error];
    
    if (!resultingData) {
        //we encountered an error
        NSLog(@"Error fetching elements: %@",[error localizedDescription]);
    } else {
        self.dataSource = resultingData;
    }
}

- (void)useDocument
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.contentData.fileURL path]]) {
        // does not exist on disk, so create it
        [self.contentData saveToURL:self.contentData.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            //            [self setupFetchedResultsController];
            [self setupContentDataIntoDocument:self.contentData];
            [DataManager addSkipBackupAttributeToItemAtURL:self.contentData.fileURL];
        }];
    } else if (self.contentData.documentState == UIDocumentStateClosed) {
        // exists on disk, but we need to open it
        [self.contentData openWithCompletionHandler:^(BOOL success) {
            //            [self setupFetchedResultsController];
            if ([DataManager updateNeeded]) {
                [self setupContentDataIntoDocument:self.contentData];
            } else {
                [self refreshDataSource];
            }
        }];
    } else if (self.contentData.documentState == UIDocumentStateNormal) {
        // already open and ready to use
        //        [self setupFetchedResultsController];
        if ([DataManager updateNeeded]) {
            [self setupContentDataIntoDocument:self.contentData];
        } else {
            [self refreshDataSource];
        }
    }
}

// 2. Make the photoDatabase's setter start using it

- (void)setContentData:(UIManagedDocument *)contentDatabase
{
    if (_contentData != contentDatabase) {
        _contentData = contentDatabase;
        [self useDocument];
    }
}

/*! Sets the data source for this view controller and refreshes the UI
 
 \param An array with data
 */
- (void) setDataSource:(NSArray *)dataSource {
    if (_dataSource != dataSource) {
        _dataSource = dataSource;
        [self refreshUI];
    }
}

#pragma mark -- View Helper Methods

- (void) _hideNavigationBar:(BOOL)hide {

    [self.navigationController setNavigationBarHidden:hide animated:YES];

    if (hide) {
        //we zero the content inset that is normaly added by a navigation bar
        [self.oScrollview setContentInset:UIEdgeInsetsZero];
    }

}

- (void) setupViewElements {
    
    NSAssert([self.dataSource count] == [self.oButtons count],
             @"Number of elements in content file %lu does not match number of Buttons in View %lu",
             (unsigned long)[self.dataSource count],
             (unsigned long)[self.oButtons count]);
    
    for (UIButton *aButton in self.oButtons) {
        
        Navigation *navigationElement = [self.dataSource objectAtIndex:aButton.tag];
        
        [aButton setTitle:navigationElement.title forState:UIControlStateNormal];
        
    }
    
    if (self.oMainContainer.isHidden) {
        [self.oMainContainer setHidden:NO];
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

@end
