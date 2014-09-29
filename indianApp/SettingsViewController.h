//
//  SettingsViewController.h
//  indianApp
//
//  Created by SystemsUSA on 5/8/14.
//  Copyright (c) 2014 SystemsUSA. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    
    NSArray *arrElements;
    
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;


@property (weak, nonatomic) IBOutlet UILabel *averageIndicator;
@property (weak, nonatomic) IBOutlet UISlider *sliderAverage;
@property (weak, nonatomic) IBOutlet UITableView *topicSelection;
@property (weak, nonatomic) IBOutlet UIButton *logOut;
@property (weak, nonatomic) IBOutlet UIButton *contactUs;


#warning temporal text for singleton
@property (weak, nonatomic) IBOutlet UITextField *lblCurrentCity;

@property (weak, nonatomic) IBOutlet UITextField *lblOriginCity;


- (IBAction)contactUsAction:(id)sender;

- (IBAction)logOutAction:(id)sender;

- (IBAction)setSingleton:(id)sender;

- (IBAction)changeDistanceUnit:(id)sender;



@property (weak, nonatomic) IBOutlet UITextField *txtCurrentCity;


@property (weak, nonatomic) IBOutlet UITextField *txtOriginalCity;

@property (weak, nonatomic) IBOutlet UISegmentedControl *distanceUnitSgc;

@property (weak, nonatomic) IBOutlet UISlider *distanceSliderSld;

@end
