//
//  GeneralViewController.m
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "GeneralViewController.h"
#import "GeneralCell.h"
#import "ActionButton.h"
#import "DocumentViewController.h"
#import "AppStoreViewController.h"
#import "VideoViewController.h"

@interface GeneralViewController ()

@end

@implementation GeneralViewController

@synthesize aDataSource = _aDataSource;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.alwaysBounceVertical = NO;
    
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 20.0f, 0)];
}

-(void) viewWillLayoutSubviews {
    
    //setting the background image on the table view
    UIImage *background_img = [UIImage imageNamed:@"gradient_bg"];
    UIImageView  *bg_img_view = [[UIImageView alloc] initWithImage:background_img];
    bg_img_view.translatesAutoresizingMaskIntoConstraints = YES;
    self.tableView.backgroundView = bg_img_view;
    
    [super viewWillLayoutSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setADataSource:(NSArray *)aDataSource {
    if (_aDataSource != aDataSource) {
        //we sort our content by order id
        NSSortDescriptor *sortByOrderId = [NSSortDescriptor sortDescriptorWithKey:@"orderId" ascending:YES];
        _aDataSource = [aDataSource sortedArrayUsingDescriptors:@[sortByOrderId]];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.aDataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Navigation *element = [self.aDataSource objectAtIndex:indexPath.row];
    
    if (!element) {
        return nil;
    }
    
    static NSString *CellIdentifier = @"General Cell";
    
    GeneralCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setupWithNavigation:element];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

#pragma mark -- SKStoreProductViewController Delegate Method
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionButtonPressed:(id)sender {
    
    ActionButton *buttonClicked = (ActionButton *)sender;
    switch (buttonClicked.actionType) {
        case ActionTypeDocument: {
            DocumentViewController *docVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DocumentViewController"];
            docVC.aDocument = buttonClicked.aDocument;
            [self.navigationController pushViewController:docVC animated:YES];
            break;
        }
        case ActionTypeLink: {
            NSString *appStoreIdentifier;
            if ([buttonClicked.aLink.name isEqualToString:@"AppStoreIdentifier"]) {
                appStoreIdentifier = buttonClicked.aLink.fileURL;
            } else {
                return;
            }
            
            AppStoreViewController *showAppStoreLink = [[AppStoreViewController alloc] init];
            showAppStoreLink.delegate = self;
            showAppStoreLink.parameters = @{SKStoreProductParameterITunesItemIdentifier:appStoreIdentifier};
            [self.navigationController presentViewController:showAppStoreLink animated:YES completion:nil];
            
            break;
        }
        case ActionTypeVideo: {
            
            VideoViewController *targetVC = [self.storyboard instantiateViewControllerWithIdentifier:@"VideoViewController"];
            targetVC.video = buttonClicked.aVideo;
            [self.navigationController pushViewController:targetVC animated:YES];
            
            break;
        }
        default:
            break;
    }
}

-(BOOL) shouldAutorotate {
    return NO;
}

@end
