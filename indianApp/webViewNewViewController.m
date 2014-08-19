//
//  webViewNewViewController.m
//  indianApp
//
//  Created by SystemsUSA on 6/8/14.
//  Copyright (c) 2014 SystemsUSA. All rights reserved.
//

#import "webViewNewViewController.h"

@interface webViewNewViewController ()

@end

@implementation webViewNewViewController

@synthesize urlWebSite;
@synthesize titleNews;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(dismiss)];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:18], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    
    [cancelButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    self.activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.activity];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIColor *backColor = [UIColor colorWithRed:250.0f/255.0f green:94.0f/255.0f blue:29.0f/255.0f alpha:1.0f];
    self.navigationController.navigationBar.barTintColor = backColor;
    
    [self.webView setDelegate:self];
    [self loadWebSite:urlWebSite];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [swipeRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    
    [self.view addGestureRecognizer:swipeRight];
    
}

-(void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadWebSite:(NSString *)urlParam{
    
    NSURL *url = [NSURL URLWithString:urlParam];
    NSURLRequest *requestObject = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObject];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)shareUrl:(id)sender {
    
    NSString *actionSheetTitle = self.urlWebSite;
    NSString *openSafari = @"Open in Safari";
    NSString *copyURL = @"Copy URL";
    NSString *cancelSheet = @"Cancel";
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:actionSheetTitle delegate:self cancelButtonTitle:cancelSheet destructiveButtonTitle:nil otherButtonTitles:openSafari, copyURL, nil];
    [actionSheet showInView:self.view];
    
}


-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    [self.activity startAnimating];
    CGRect frame = CGRectMake(0, 0, 70, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"Loading...";
    self.navigationItem.titleView = label;
    
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self.activity stopAnimating];
    CGRect frame = CGRectMake(0, 0, 70, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = self.titleNews;
    self.navigationItem.titleView = label;
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    switch (buttonIndex) {
        case 0:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.urlWebSite]];
            break;
        case 1:
            [pasteBoard setString:self.urlWebSite];
            break;
        default:
            break;
    }
    
}


@end
