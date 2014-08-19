//
//  indianNewsTableViewController.m
//  indianApp
//
//  Created by SystemsUSA on 6/6/14.
//  Copyright (c) 2014 SystemsUSA. All rights reserved.
//

#import "indianNewsTableViewController.h"
#import "NewsTableViewCell.h"
#import "NSString+htmlRemove.h"
#import "DetailsNewsTableViewController.h"
#import "Singleton.h"

@interface indianNewsTableViewController ()

@end

@implementation indianNewsTableViewController{
    
    NSMutableArray *newsArray;
    NSMutableArray *arrImages;
    NSMutableArray *arrUrls;
    
}
@synthesize activityIndicator, paintView;
@synthesize modelArrayImages;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect frame = CGRectMake(0, 0, 70, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"Indian news";
    self.navigationItem.titleView = label;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(dismiss)];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:18], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    
    [cancelButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIColor *backColor = [UIColor colorWithRed:250.0f/255.0f green:94.0f/255.0f blue:29.0f/255.0f alpha:1.0f];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self.activityIndicator startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.activityIndicator];
    self.navigationController.navigationBar.barTintColor = backColor;
    
    arrImages = [[NSMutableArray alloc]init];
    arrUrls = [[NSMutableArray alloc]init];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self consumeWebService];
}

-(void)consumeWebService{
    
    int x = self.tableView.frame.size.width / 4;
    int y = self.tableView.frame.size.height / 4;
    int wiNew = x * 2;
    int heNew = wiNew;
    
    paintView=[[UIView alloc]initWithFrame:CGRectMake(x, y, wiNew, heNew)];
    [paintView setBackgroundColor:[UIColor blackColor]];
    [paintView setAlpha:1.0];
    
    int xpos = (paintView.frame.size.width / 3) - 5;
    int ypos = (paintView.frame.size.width / 4) + 8;
    
    UIActivityIndicatorView *progress= [[UIActivityIndicatorView alloc] initWithFrame: CGRectMake(xpos, ypos, 60, 60)];
    progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [progress startAnimating];
    
    paintView.layer.cornerRadius = 5;
    [paintView addSubview:progress];
    [self.view addSubview:paintView];
    
#warning Append url with the search... (New Delhi)
    NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
    
    dicc = [[Singleton sharedCenter]returnUserInfo];
    
    NSLog(@"The dictionary is: %@", dicc);
    
    NSString *cityFilter = [dicc valueForKey:@"originalCity"];
    
    cityFilter = [cityFilter stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    //NSString *stringConnection = @"https://ajax.googleapis.com/ajax/services/search/news?v=1.0&rsz=8&q=New%20Delhi";
    
    NSString *stringConnection = @"https://ajax.googleapis.com/ajax/services/search/news?v=1.0&rsz=8&q=";
    
    NSString *connection = [NSString stringWithFormat:@"%@%@",stringConnection, cityFilter];
    
    NSMutableURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:connection]];
    
    NSURLConnection *cnn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (cnn) {
        serviceData = [NSMutableData data];
    }
    else{
        NSLog(@"Error");
    }
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [serviceData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [serviceData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    [self.activityIndicator stopAnimating];
    [paintView removeFromSuperview];
    
    UIView *viewTmp = [[UIView alloc]initWithFrame:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.x, self.tableView.frame.size.width, self.tableView.frame.size.height)];
    
    [viewTmp setBackgroundColor:[UIColor whiteColor]];
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"exclamation.png"]];
    
    imgView.frame = CGRectMake(142, 150, 36, 36);
    
    UILabel *lblMessage = [[UILabel alloc]initWithFrame:CGRectMake(15, 200, 291, 69)];
    UIColor *colorGray = [UIColor colorWithRed:139.0f/255.0 green:139.0f/255.0 blue:139.0f/255.0 alpha:1.0];
    lblMessage.textColor = colorGray;
    [lblMessage setFont:[UIFont fontWithName:@"HelveticaNeue-medium" size:17]];
    lblMessage.backgroundColor = [UIColor clearColor];
    lblMessage.textAlignment = NSTextAlignmentCenter;
    lblMessage.numberOfLines = 3;
    lblMessage.text = @"Unable to load. Please try again or contact support@indianapp.com if the issue persists.";
    
    [viewTmp addSubview:imgView];
    [viewTmp addSubview:lblMessage];
    
    [self.tableView addSubview:viewTmp];
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    [self.activityIndicator stopAnimating];
    [paintView removeFromSuperview];
    
    NSMutableDictionary *dictionaryContent = [NSMutableDictionary dictionary];
    id JSON = [NSJSONSerialization JSONObjectWithData:serviceData options:0 error:nil];
    dictionaryContent = JSON;
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *dictionaryResults = [NSMutableDictionary dictionary];
    
    dictionary = [JSON objectForKey:@"responseData"];
    dictionaryResults = [dictionary objectForKey:@"results"];
    
    NSString *title, *publisher, *content, *urlImage, *date, *url;
    NSMutableDictionary *dicDetails = [NSMutableDictionary dictionary];
    NSMutableArray *arrTable = [[NSMutableArray alloc]init];
    
    for (id element in dictionaryResults) {
        
        title = [element valueForKey:@"titleNoFormatting"];
        publisher = [element valueForKey:@"publisher"];
        content = [element valueForKey:@"content"];
        
        if ([[element valueForKey:@"publishedDate"] length] > 17) {
            date = [[element valueForKey:@"publishedDate"] substringToIndex:17];
        }
        else{
            date = [element valueForKey:@"publishedDate"];
        }
        
        url = [element valueForKey:@"unescapedUrl"];
        
        if ([element objectForKey:@"image"]) {
            urlImage = [[element objectForKey:@"image"]objectForKey:@"url"];
        }
        else{
            urlImage = @"";
        }
        
        [arrUrls addObject:url];
        
        [dicDetails setValue:title forKey:@"newsTitle"];
        [dicDetails setValue:publisher forKey:@"newsPublisher"];
        [dicDetails setValue:content forKey:@"newsContent"];
        [dicDetails setValue:urlImage forKey:@"newsImage"];
        [dicDetails setValue:date forKey:@"newsDate"];
        [dicDetails setValue:url forKey:@"newsURL"];
        [arrTable addObject:[dicDetails copy]];
        [dicDetails removeAllObjects];
        
    }
    
    newsArray = [arrTable copy];
    [arrTable removeAllObjects];
    [self.tableView reloadData];
    
}

-(void)dismiss{
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
    return [newsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *newsCellIdentifier = @"cellNews";
    
    NewsTableViewCell *cell = (NewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:newsCellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NewsTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    
    NSDictionary *dicTmp = [newsArray objectAtIndex:indexPath.row];
    NSString *titleTmp = [[dicTmp valueForKey:@"newsTitle"] stringByStrippingHTML];
    NSString *contentTmp = [[dicTmp valueForKey:@"newsContent"] stringByStrippingHTML];
    
    if ([titleTmp length] > 20) {cell.lblTitleNews.text = [titleTmp substringToIndex:20];}
    else{cell.lblTitleNews.text = titleTmp;}
    
    if ([contentTmp length]>94) {cell.lblContentNews.text = [contentTmp substringToIndex:94];}
    else{cell.lblContentNews.text = contentTmp;}
    
    
    //Store images in the array...
    [arrImages addObject:cell.imgNews.image];
    
    if ([[dicTmp valueForKey:@"newsImage"] length] > 0) {
        //Consume webservice with image...
        [cell.activityIndicator startAnimating];
        
        //Creation of the queue...
        dispatch_queue_t imageQueue = dispatch_queue_create("Image Queue", NULL);
        
        dispatch_async(imageQueue, ^{
            
            NSURL *url = [NSURL URLWithString:[dicTmp valueForKey:@"newsImage"]];
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:imageData];
            
            //Update the view with the main queue
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [cell.imgNews setImage:image];
                [cell.imgNews setAlpha:1.0];
                
                //UIImage rounded
                cell.imgNews.layer.cornerRadius = cell.imgNews.frame.size.height / 2;
                cell.imgNews.layer.masksToBounds = YES;
                cell.imgNews.layer.borderWidth = 1;
                
                //Store images in the array...
                [arrImages replaceObjectAtIndex:indexPath.row withObject:cell.imgNews.image];
                
                [cell.activityIndicator stopAnimating];
                [cell.activityIndicator setHidden:YES];
                
            });
        });
    }
    else{
        //no action required...
        cell.imgNews.image = [UIImage imageNamed:@"newsImage.png"];
        cell.imgNews.layer.borderWidth = 0;
        
        [cell.activityIndicator setHidden:YES];
        [cell.imgNews setAlpha:1.0];
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailsNewsTableViewController *nextViewDetail = [[DetailsNewsTableViewController alloc] initWithNibName:nil bundle:nil];
    nextViewDetail.dicInformation = [newsArray objectAtIndex:indexPath.row];
    nextViewDetail.imgNews = [arrImages objectAtIndex:indexPath.row];
    nextViewDetail.urlNews = [arrUrls objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:nextViewDetail animated:YES];
    
}

@end
