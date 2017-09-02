//
//  GeneraliPadCell.m
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//
#import "GeneraliPadCell.h"

@implementation GeneraliPadCell


-(void) setupWithNavigationElements:(NSArray *)elements {
    
    if ([elements count] > 2 || [elements count] == 0) {
        return; //this should not happen
    }
    
    [elements enumerateObjectsUsingBlock:^(id object, NSUInteger index,BOOL *stop){
        if (index == 0) {
            [self _setupContentForTitle:self.oTitle image:self.oImage button:self.oActionButton withNavigation:[elements objectAtIndex:0]];
            
        } else if (index == 1) {
            [self _setupContentForTitle:self.oTitleTwo image:self.oImageTwo button:self.oActionButtonTwo withNavigation:[elements objectAtIndex:1]];
        }
    }];
    
    //if we have only element we hade the second box
    [self.oContainerTwo setHidden:([elements count] == 1)];
    [self.oActionButtonTwo setHidden:([elements count] == 1)];
}

- (void) _setupContentForTitle:(UILabel *)titleLabel image:(UIImageView *)image button:(ActionButton *)button  withNavigation:(Navigation *)navElement {
    
    titleLabel.text = navElement.title;
    image.image = [UIImage imageNamed:navElement.image.fileName];
    [button setTitle:[navElement.subtitle uppercaseString] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, self.oActionButton.frame.size.width - 52.0f, 0, 0)];
    
    if (navElement.document) {
        button.aDocument = navElement.document;
        button.actionURL =navElement.document.fileName;
        button.actionType = ActionTypeDocument;
        [button setBackgroundImage:[UIImage imageNamed:@"general_document_btn_bg"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"general_document_btn_image"] forState:UIControlStateNormal];
    } else if(navElement.video){
        button.aVideo = navElement.video;
        button.actionURL =navElement.video.url;
        button.actionType = ActionTypeVideo;
        [button setBackgroundImage:[UIImage imageNamed:@"general_document_btn_bg"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"general_video_btn_image"] forState:UIControlStateNormal];
        
        
    } else if (navElement.link) {
        button.aLink = navElement.link;
        button.actionURL =navElement.link.fileURL;
        button.actionType = ActionTypeLink;
        [button setBackgroundImage:[UIImage imageNamed:@"general_link_btn_bg"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"general_link_btn_image"] forState:UIControlStateNormal];
        
    }
}

@end
