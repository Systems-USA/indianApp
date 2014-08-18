//
//  templesMapViewController.m
//  indianApp
//
//  Created by SystemsUSA on 5/12/14.
//  Copyright (c) 2014 SystemsUSA. All rights reserved.
//

#import "templesMapViewController.h"

@interface templesMapViewController ()

@end

@implementation templesMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
    CLLocationCoordinate2D noLocation;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 500, 500);
    MKCoordinateRegion adjustRegion = [self.mapView regionThatFits:viewRegion];
    
    [self.mapView setRegion:adjustRegion animated:YES];
    */
    
    self.mapView.showsUserLocation = YES;
    
    
    [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];
    
    
    CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(13.747266, 100.526804);

    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 800, 800)];

    adjustedRegion.span.longitudeDelta = 0.005;
    adjustedRegion.span.latitudeDelta = 0.005;
    
    [self.mapView setRegion:adjustedRegion];
    
    
    
    
        
    
        
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
