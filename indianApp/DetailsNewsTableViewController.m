//
//  DetailsNewsTableViewController.m
//  indianApp
//
//  Created by SystemsUSA on 6/6/14.
//  Copyright (c) 2014 SystemsUSA. All rights reserved.
//

#import "DetailsNewsTableViewController.h"
#import "DetailFirstTableViewCell.h"
#import "DetailSecondTableViewCell.h"
#import "DetailThirdTableViewCell.h"
#import "NSString+htmlRemove.h"

#import "webViewNewViewController.h"
#import <Social/Social.h>


@interface DetailsNewsTableViewController ()

@end

@implementation DetailsNewsTableViewController

@synthesize dicInformation, imgNews, urlNews;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:18], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(dismiss)];
    
    UIBarButtonItem *actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
    
    actionButton.tintColor = [UIColor whiteColor];
    
    [cancelButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [actionButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.rightBarButtonItem = actionButton;
    
    UIColor *backColor = [UIColor colorWithRed:250.0f/255.0f green:94.0f/255.0f blue:29.0f/255.0f alpha:1.0f];
    self.navigationController.navigationBar.barTintColor = backColor;
    
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [swipeRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    
    [self.view addGestureRecognizer:swipeRight];
    
    
}

-(void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)goToWebSite{
    
    webViewNewViewController *webViewController = [[webViewNewViewController alloc]initWithNibName:nil bundle:nil];
    webViewController.urlWebSite = [dicInformation valueForKey:@"newsURL"];
    webViewController.titleNews = [[dicInformation valueForKey:@"newsTitle"]stringByStrippingHTML];
    [self.navigationController pushViewController:webViewController animated:YES];
    
}

-(void)share{
    
    NSString *actionSheetTitle = [[dicInformation valueForKey:@"newsTitle"]stringByStrippingHTML];
    
    NSString *email = @"Email";
    NSString *message = @"Message";
    NSString *twitter = @"Twitter";
    NSString *facebook = @"Facebook";
    NSString *cancelSheet = @"Cancel";
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:actionSheetTitle delegate:self cancelButtonTitle:cancelSheet destructiveButtonTitle:nil otherButtonTitles:email, message, twitter, facebook, nil];
    [actionSheet showInView:self.view];
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
#warning correct error with alerts
    //email
    NSArray *arrRecipents = [NSArray arrayWithObjects:@"", nil];
    MFMailComposeViewController *mailView = [[MFMailComposeViewController alloc]init];
    NSString *emailBody;
    
    //sms
    MFMessageComposeViewController *smsController = [[MFMessageComposeViewController alloc]init];
    
    //tweet
    SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    NSString *tweet;
    
    //facebook
    SLComposeViewController *faceSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    NSString *face;
    
    //Alert..
    UIAlertView *alert;
    
    switch (buttonIndex) {
        case 0:
            //Send email...
            mailView.mailComposeDelegate = self;
            [mailView setSubject:[[dicInformation valueForKey:@"newsTitle"]stringByStrippingHTML]];
            
            emailBody = [NSString stringWithFormat:@"\n%@\n\n%@\n\n%@", [[dicInformation valueForKey:@"newsTitle"]stringByStrippingHTML], [[dicInformation valueForKey:@"newsContent"]stringByStrippingHTML], [dicInformation valueForKey:@"newsURL"]];
            
            [mailView setMessageBody:emailBody isHTML:NO];
            [mailView setToRecipients:arrRecipents];
            [self presentViewController:mailView animated:YES completion:nil];
            break;
        case 1:
            //Send message...
            if ([MFMessageComposeViewController canSendText]) {
                smsController.body = [NSString stringWithFormat:@"%@,%@", [[dicInformation valueForKey:@"newsTitle"]stringByStrippingHTML], [dicInformation valueForKey:@"newsURL"]];
                smsController.recipients = [NSArray arrayWithObjects:nil, nil];
                smsController.messageComposeDelegate = self;
                [self presentViewController:smsController animated:YES completion:nil];
            }
            break;
        case 2:
            //Share in twitter..
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
                tweet = [NSString stringWithFormat:@"Indian App - %@", [[dicInformation valueForKey:@"newsTitle"]stringByStrippingHTML]];
                [tweetSheet setInitialText:tweet];
                [tweetSheet addImage:imgNews];
                [self presentViewController:tweetSheet animated:YES completion:nil];
            }
            else{
                alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please configure an account for you device" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
            }
            break;
        case 3:
            //Post in facebook...
            if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
                face = [NSString stringWithFormat:@"Indian App - %@", [[dicInformation valueForKey:@"newsTitle"]stringByStrippingHTML]];
                [faceSheet setInitialText:face];
                [faceSheet addURL:[NSURL URLWithString:urlNews]];
                [faceSheet addImage:imgNews];
                [self presentViewController:faceSheet animated:YES completion:nil];
            }
            else{
                alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please configure an account for you device" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
            }
            break;
        default:
            break;
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Identifiers
    static NSString *firstCell = @"firstCell";
    static NSString *secondCell = @"secondCell";
    static NSString *thirdCell = @"thirdCell";
    
    //Default Cell...
    UITableViewCell *cell = (DetailFirstTableViewCell *)[tableView dequeueReusableCellWithIdentifier:firstCell];
    
    DetailFirstTableViewCell *cellFirst = (DetailFirstTableViewCell *)[tableView dequeueReusableCellWithIdentifier:firstCell];
    DetailSecondTableViewCell *cellSecond = (DetailSecondTableViewCell *)[tableView dequeueReusableCellWithIdentifier:secondCell];
    DetailThirdTableViewCell *cellThird = (DetailThirdTableViewCell *)[tableView dequeueReusableCellWithIdentifier:thirdCell];
    
    switch (indexPath.row) {
        case 0:
            //First cell, setup the way you want
            if (cellFirst == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailFirstTableViewCell" owner:self options:nil];
                cellFirst = [nib objectAtIndex:0];
                
                cellFirst.lblNewsTitle.text = [[dicInformation valueForKey:@"newsTitle"]stringByStrippingHTML];
                cellFirst.lblPublisher.text = [dicInformation valueForKey:@"newsPublisher"];
                cellFirst.lblDate.text = [dicInformation valueForKey:@"newsDate"];
                
                cell = cellFirst;
            }
            [cell setUserInteractionEnabled:NO];
            return cell;
            break;
        case 1:
            //Second cell, setup the way you want
            if (cellSecond == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailSecondTableViewCell" owner:self options:nil];
                cellSecond = [nib objectAtIndex:0];
                
                cellSecond.lblFilterDetails =
                
                cell = cellSecond;
            }
            [cell setUserInteractionEnabled:NO];
            return cell;
            break;
        case 2:
            //Third cell, setup the way you want
            if (cellThird == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailThirdTableViewCell" owner:self options:nil];
                cellThird = [nib objectAtIndex:0];
                [cellThird.btnUrl setTitle:[dicInformation valueForKey:@"newsURL"] forState:UIControlStateNormal];
                cellThird.lblContent.text = [[dicInformation valueForKey:@"newsContent"]stringByStrippingHTML];
                [cellThird.btnUrl addTarget:self action:@selector(goToWebSite) forControlEvents:UIControlEventTouchUpInside];
                cell = cellThird;
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
            break;
        default:
            break;
    }
    [cell setUserInteractionEnabled:NO];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int cellSize = 34;
    
    switch (indexPath.row) {
        case 0:
            cellSize = 153;
            break;
        case 1:
            cellSize = 41;
            break;
        case 2:
            cellSize = 287;
            break;
        default:
            break;
    }
    
    return cellSize;
    
}

@end
