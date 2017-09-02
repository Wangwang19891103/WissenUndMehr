//
//  DocumentTableViewCell.m
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//
#import "GeneralCell.h"

@implementation GeneralCell


- (void) setupWithNavigation:(Navigation *)aNavigationElement {
    self.oTitle.text = aNavigationElement.title;
    self.oImage.image = [UIImage imageNamed:aNavigationElement.image.fileName];
    [self.oActionButton setTitle:[aNavigationElement.subtitle uppercaseString] forState:UIControlStateNormal];
    [self.oActionButton setImageEdgeInsets:UIEdgeInsetsMake(0, self.oActionButton.frame.size.width - 52.0f, 0, 0)];
    
    if (aNavigationElement.document) {
        self.oActionButton.aDocument = aNavigationElement.document;
        self.oActionButton.actionURL =aNavigationElement.document.fileName;
        self.oActionButton.actionType = ActionTypeDocument;
        [self.oActionButton setBackgroundImage:[UIImage imageNamed:@"general_document_btn_bg"] forState:UIControlStateNormal];
        [self.oActionButton setImage:[UIImage imageNamed:@"general_document_btn_image"] forState:UIControlStateNormal];
    } else if(aNavigationElement.video){
        self.oActionButton.aVideo = aNavigationElement.video;
        self.oActionButton.actionURL =aNavigationElement.video.url;
        self.oActionButton.actionType = ActionTypeVideo;
        [self.oActionButton setBackgroundImage:[UIImage imageNamed:@"general_document_btn_bg"] forState:UIControlStateNormal];
        [self.oActionButton setImage:[UIImage imageNamed:@"general_video_btn_image"] forState:UIControlStateNormal];
        
        
    } else if (aNavigationElement.link) {
        self.oActionButton.aLink = aNavigationElement.link;
        self.oActionButton.actionURL =aNavigationElement.link.fileURL;
        self.oActionButton.actionType = ActionTypeLink;
        [self.oActionButton setBackgroundImage:[UIImage imageNamed:@"general_link_btn_bg"] forState:UIControlStateNormal];
        [self.oActionButton setImage:[UIImage imageNamed:@"general_link_btn_image"] forState:UIControlStateNormal];

    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
