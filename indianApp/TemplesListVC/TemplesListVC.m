//
//  TemplesListVC.m
//  indianApp
//
//  Created by victor alejandro reza rodriguez on 18/08/14.
//  Copyright (c) 2014 SystemsUSA. All rights reserved.
//

#import "TemplesListVC.h"
#import "ServiceSearchTemples.h"
#import "TemplesCell.h"

#import <MapKit/MapKit.h>
#import "PinAnnotation.h"


#import "ConstantsFoursquareKeys.h"


#define k_NAME_IMAGE_GEO_IMAGE                              @"geo_icon"
#define k_NAME_IMAGE_CURRENT_POSITION_IMAGE                 @"pin_current_location"
#define k_BESTO_ZOOM                                        60000.0

#define k_MAP_ORIGINAL_HEIGHT                               362


enum {
    k_Position_PlacesTV_Show = 0,
    k_Position_PlacesTV_Hidden = 1
};

typedef NSUInteger k_Position_PlacesTV;




@interface TemplesListVC () <ServiceSearchTemplesDelegate, CLLocationManagerDelegate, MKMapViewDelegate> {
    
    NSArray *placesArr;
    
    CLLocationManager *locationManager;
    CLLocationCoordinate2D lastUserLocation;
    PinAnnotation *currentLocationPA;
    BOOL firstActualLocation;
    NSInteger positionPlaces;
    
}

@property (nonatomic, strong) ServiceSearchTemples *serviceSearch;
@property (weak, nonatomic) IBOutlet UIView *contentPlacesVew;
@property (weak, nonatomic) IBOutlet UIView *contentMainVew;
@property (weak, nonatomic) IBOutlet UIButton *tabBtn;



-(IBAction)pressTabButton:(id)sender;



@end




@implementation TemplesListVC



#pragma mark - IBActions Methods

-(IBAction)pressTabButton:(id)sender{
    
    [self changePositionPlacesTV:positionPlaces];
    
}

-(IBAction)pressCurrentLocationButton:(id)sender{
    
    [self setRegionToMap:lastUserLocation withSecondaryPoint:CLLocationCoordinate2DMake(0, 0)];

}


#pragma mark - Private Methods

-(void)consumeServiceSearch{
    
    [self.activityIndicator startAnimating];
    
    _serviceSearch = [[ServiceSearchTemples alloc] init];
    [_serviceSearch setDelegate:self];
    [_serviceSearch getServiceSearchTemples:@""];
    
}

-(void)starLocattionFromUser{
    
    
    if (locationManager == nil) {
        
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setDelegate:self];
        
    }
    
    
    [locationManager stopUpdatingLocation];
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBestForNavigation];
    [locationManager startUpdatingLocation];
    
    
}

-(void)createPinAnnotation:(NSDictionary *)pinData{




}

-(void)setRegionToMap:(CLLocationCoordinate2D)locationMain withSecondaryPoint:(CLLocationCoordinate2D)secondaryLocation{

    MKCoordinateSpan span;
    
    if (secondaryLocation.latitude != 0 && secondaryLocation.longitude != 0) {
        
        CLLocation *locationMainCL = [[CLLocation alloc] initWithLatitude:locationMain.latitude
                                                                longitude:locationMain.longitude];
        CLLocation *locationSecondaryCL = [[CLLocation alloc] initWithLatitude:secondaryLocation.latitude
                                                                     longitude:secondaryLocation.longitude];
        
        CLLocationDistance distanciaMetros = [locationMainCL distanceFromLocation:locationSecondaryCL];
        
        CGFloat zoomRegion =  (distanciaMetros / k_BESTO_ZOOM);
        
        span.latitudeDelta = zoomRegion;
        span.longitudeDelta = zoomRegion;
        
        
    }
    else{
        
        span.latitudeDelta = 0.005;
        span.longitudeDelta = 0.005;
        
    }
    
    
    CLLocationCoordinate2D regionLocation = CLLocationCoordinate2DMake(locationMain.latitude, locationMain.longitude);
    
    MKCoordinateRegion region;
    
    
    region.span = span;
    region.center.latitude = regionLocation.latitude;
    region.center.longitude = regionLocation.longitude;
    
    [_mapMV setRegion:region animated:YES];

}

-(void)changePositionPlacesTV:(k_Position_PlacesTV)k_position{
    
    CGFloat mapHeight;
    CGFloat contentPlacesY;
    
    if (k_position == k_Position_PlacesTV_Hidden) {
        
        contentPlacesY = _contentMainVew.frame.size.height - _tabBtn.frame.size.height;
        mapHeight = contentPlacesY;
        positionPlaces = k_Position_PlacesTV_Show;
        
    }
    else if (k_position == k_Position_PlacesTV_Show) {
        
        contentPlacesY = _contentMainVew.frame.size.height - _contentPlacesVew.frame.size.height;
        mapHeight = contentPlacesY;
        positionPlaces = k_Position_PlacesTV_Hidden;
        
    }
    else{
        return;
    }
    
    NSLog(@"contentPlacesY: %f", contentPlacesY);
    
    [UIView beginAnimations:@"" context:nil];
    
    CGRect frame = _mapMV.frame;
    frame.size.height = mapHeight;
    [_mapMV setFrame:frame];
    
    frame = _contentPlacesVew.frame;
    frame.origin.y = contentPlacesY;
    [_contentPlacesVew setFrame:frame];
    
    [UIView commitAnimations];
    
}



#pragma mark - ServiceSearchTemplesDelegate Methods

-(void)endServiceSearchTemples:(NSArray *)array{

    
    [_activityIndicator stopAnimating];
    
    placesArr = [NSArray arrayWithArray:array];
    NSLog(@"placesArr: %@", placesArr);
    
    NSMutableArray *pinesArray = [NSMutableArray array];
    
    for (NSDictionary *placeDic in placesArr) {
        
        PinAnnotation *pin = [[PinAnnotation alloc] init];
        CLLocationCoordinate2D location = CLLocationCoordinate2DMake([[placeDic objectForKey:kf_Foursquare_Venue_Latitud] floatValue], [[placeDic objectForKey:kf_Foursquare_Venue_Longitud] floatValue]);
        
        [pin setCoordinate:location];
        [pin setType:@"b"];
        [pin setImage:k_NAME_IMAGE_GEO_IMAGE];
        [pin setLabel:[placeDic objectForKey:kf_Foursquare_Venue_Name]];
        [pin setAddres:[placeDic objectForKey:kf_Foursquare_Venue_Address]];
        
        [pinesArray addObject:pin];
        
    }
    
    [_mapMV addAnnotations:pinesArray];
    
    
    [_placesTV reloadData];

}



#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
    //VARR - Evalua el tipo de error al geolocalizar
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        //VARR - El caso en que la aplicacion este bloqueada para geolocalizacion
        
        NSLog(@"To can enjoy all function from IndianApp, you need able the location permission in Settings.");
        
    }
    else {
        
    }
    
    NSLog(@"locationManager - didFailWithError: %@", error);
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    
//    
//    if (currentLocationPA == nil) {
//        currentLocationPA = [[PinAnnotation alloc] init];
//    }
//
//    currentLocationPA = [[PinAnnotation alloc] init];
//    [currentLocationPA setCoordinate:newLocation.coordinate];
//    [currentLocationPA setType:@"a"];
//    [currentLocationPA setImage:@"pin_current_location.png"];
//
//
//    [_mapMV removeAnnotation:currentLocationPA];
//    [_mapMV addAnnotation:currentLocationPA];
//
//    
//
}



#pragma mark - MKMapViewDelegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    
    NSString *typeAnnotation;
    NSString *imageAnnotation;
    BOOL respondToTouch;
    
    if ([annotation isKindOfClass:[PinAnnotation class]]) {
        
        PinAnnotation *annot = (PinAnnotation *)annotation;
        typeAnnotation = annot.type;
        imageAnnotation = annot.image;
        respondToTouch = YES;
        
    }
    else{
        
        typeAnnotation = @"a";
        imageAnnotation = k_NAME_IMAGE_CURRENT_POSITION_IMAGE;
        respondToTouch = NO;
        
    }
    
    
    MKPinAnnotationView *annPin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:typeAnnotation];
    
    
    annPin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:typeAnnotation];
    [annPin setCanShowCallout:respondToTouch];
    [annPin setCalloutOffset:CGPointMake(0, 0)];
    
    
    UIImage *image = [UIImage imageNamed:imageAnnotation];
    [annPin setImage:image];


    
    return annPin;
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{

    NSLog(@"didSelectAnnotationView - view: %@", view);
    
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    if (!firstActualLocation) {
        
        [self setRegionToMap:userLocation.coordinate withSecondaryPoint:CLLocationCoordinate2DMake(0, 0)];
        
        firstActualLocation = YES;
        
    }
    
    lastUserLocation = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
    

}


#pragma mark - TableView Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"count: %lu", (unsigned long)[placesArr count]);
    return [placesArr count];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *searchCellIdentifier = @"templesCell";
    
    TemplesCell *cell = (TemplesCell *)[tableView dequeueReusableCellWithIdentifier:searchCellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"TemplesCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    NSDictionary *diccionary = [placesArr objectAtIndex:indexPath.row];
    NSString *name = [NSString stringWithFormat:@"%@", [diccionary objectForKey:kf_Foursquare_Venue_Name]];
    NSString *distance = [NSString stringWithFormat:@"Distance: %@", [diccionary objectForKey:kf_Foursquare_Venue_Distance]];
    
//    NSLog(@"name: %@", name);
//    NSLog(@"distance: %@", distance);
    
    [cell.namePlace setText:name];
    [cell.distancePlace setText:distance];
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSDictionary *diccionary = [placesArr objectAtIndex:indexPath.row];
    
    CLLocationCoordinate2D coordinateLocation = CLLocationCoordinate2DMake([[diccionary objectForKey:kf_Foursquare_Venue_Latitud] floatValue], [[diccionary objectForKey:kf_Foursquare_Venue_Longitud] floatValue]);
    
    [self setRegionToMap:coordinateLocation withSecondaryPoint:lastUserLocation];
    
}

#pragma mark - Life Cycle

-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
        positionPlaces = k_Position_PlacesTV_Hidden;
        
    }
    
    return self;
    
}

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    
    //[self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    CGRect frame = CGRectMake(0, 0, 70, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"Nearby temples";
    self.navigationItem.titleView = label;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(dismiss)];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:18], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    
    [cancelButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIColor *backColor = [UIColor colorWithRed:250.0f/255.0f green:94.0f/255.0f blue:29.0f/255.0f alpha:1.0f];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.activityIndicator];
    self.navigationController.navigationBar.barTintColor = backColor;
    
    
//    CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(42.475, -83.411);
//    
//    MKCoordinateRegion adjustedRegion = [_mapMV regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 800, 800)];
//    
//    adjustedRegion.span.longitudeDelta = 0.005;
//    adjustedRegion.span.latitudeDelta = 0.005;
//    
//    [_mapMV setRegion:adjustedRegion];
    [_mapMV setUserTrackingMode:MKUserTrackingModeFollow];
    
    
    //[self starLocattionFromUser];

}

-(void)viewWillDisappear:(BOOL)animated{

    firstActualLocation = NO;
    
}

-(void)viewDidAppear:(BOOL)animated{
    
}

-(void)viewWillAppear:(BOOL)animated{

    [self consumeServiceSearch];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

