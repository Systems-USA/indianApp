//
//  webViewNewViewController.h
//  indianApp
//
//  Created by SystemsUSA on 6/8/14.
//  Copyright (c) 2014 SystemsUSA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface webViewNewViewController : UIViewController <UIWebViewDelegate, UIActionSheetDelegate>{
    NSString *urlWebSite;
    NSString *titleNews;
}

@property(nonatomic, retain) NSString *urlWebSite;
@property(nonatomic, retain) NSString *titleNews;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;

- (IBAction)shareUrl:(id)sender;

@end
