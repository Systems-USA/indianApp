//
//  indianNewsTableViewController.h
//  indianApp
//
//  Created by SystemsUSA on 6/6/14.
//  Copyright (c) 2014 SystemsUSA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface indianNewsTableViewController : UITableViewController <NSURLConnectionDataDelegate>{
    NSMutableData *serviceData;
    UIView *paintView;
    UIActivityIndicatorView *activityIndicator;
    NSMutableArray *modelArrayImages;
}

@property (strong, nonatomic) IBOutlet UIView *paintView;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (strong, nonatomic) NSMutableArray *modelArrayImages;

@end
