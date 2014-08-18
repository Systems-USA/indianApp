//
//  DetailsNewsTableViewController.h
//  indianApp
//
//  Created by SystemsUSA on 6/6/14.
//  Copyright (c) 2014 SystemsUSA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface DetailsNewsTableViewController : UITableViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>{
    NSMutableDictionary *dicInformation;
    UIImage *imgNews;
    NSString *urlNews;
}

@property(nonatomic, retain) NSMutableDictionary *dicInformation;
@property(nonatomic, retain) UIImage *imgNews;
@property(nonatomic, retain) NSString *urlNews;

-(void)goToWebSite;

@end
