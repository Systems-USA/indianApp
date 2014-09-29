//
//  TemplesListVC.h
//  indianApp
//
//  Created by victor alejandro reza rodriguez on 20/08/14.
//  Copyright (c) 2014 SystemsUSA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>



@interface TemplesListVC : UIViewController <UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate>

@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;


@property (weak, nonatomic) IBOutlet MKMapView *mapMV;
@property (weak, nonatomic) IBOutlet UIButton *showTableBtn;
@property (weak, nonatomic) IBOutlet UITableView *placesTV;



@end
