//
//  SettingsViewController.m
//  indianApp
//
//  Created by SystemsUSA on 5/8/14.
//  Copyright (c) 2014 SystemsUSA. All rights reserved.
//

#import "SettingsViewController.h"
#import "SWRevealViewController.h"
#import "SettingsTableViewCell.h"
#import "Singleton.h"


#import "GeneralConstants.h"




@interface SettingsViewController ()

@end

@implementation SettingsViewController

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
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    //Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    arrElements = @[@"News", @"Music", @"Temples", @"Restaurants"];
    
    [self.sliderAverage addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    //set gesture for textfield
    UITapGestureRecognizer *tapOutside = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tapOutside];
    
    [self.lblCurrentCity setDelegate:self];
    [self.lblOriginCity setDelegate:self];
    
    
    NSMutableDictionary *diccInfo = [[Singleton sharedCenter]returnUserInfo];
    
    self.lblOriginCity.text = [diccInfo valueForKey:@"originalCity"];
    
    self.lblCurrentCity.text = [diccInfo valueForKey:@"currentCity"];
    
    Singleton *theSingleton = [Singleton sharedCenter];
    NSLog(@"distance unit: %@", [theSingleton getSettingWithKey:k_Settings_Distance_Unit]);
    
    if ([[theSingleton getSettingWithKey:k_Settings_Distance_Unit] isEqualToString:k_Settings_Distance_Unit_Key_KM]) {
        [_distanceUnitSgc setSelectedSegmentIndex:0];
    }
    else if ([[theSingleton getSettingWithKey:k_Settings_Distance_Unit] isEqualToString:k_Settings_Distance_Unit_Key_Miles]) {
        [_distanceUnitSgc setSelectedSegmentIndex:1];
    }
    
}


-(IBAction)sliderValueChanged:(id)sender{
    
    self.averageIndicator.text = [NSString stringWithFormat:@"%f", self.sliderAverage.value];
    
    Singleton *theSingleton = [Singleton sharedCenter];
    [theSingleton saveSetting:[NSNumber numberWithFloat:_sliderAverage.value] withKey:k_Settings_Distance_Long];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"settingsCell";
    
    SettingsTableViewCell *cell = (SettingsTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SettingsTableViewCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
        
    }
    
    cell.lblTopicName.text = [arrElements objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
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

- (IBAction)contactUsAction:(id)sender {
}

- (IBAction)logOutAction:(id)sender {
}

- (IBAction)setSingleton:(id)sender {

    #warning sending information...
    NSString *cityCurrent = self.txtCurrentCity.text;
    NSString *cityOriginal = self.txtOriginalCity.text;
    
    NSMutableDictionary *diccTmp = [NSMutableDictionary dictionary];
    
    [diccTmp setValue:cityOriginal forKey:@"originalCity"];
    [diccTmp setValue:cityCurrent forKey:@"currentCity"];
    
    [[Singleton sharedCenter] loadSettings:diccTmp];
    
    
    //Also load the NSUserDefaults..
    //NSString *cityCurrent = self.txtCurrentCity.text;
    //NSString *cityOriginal = self.txtOriginalCity.text;
    
    
    //[[NSUserDefaults standardUserDefaults] setObject:cityCurrent forKey:@"originalCity"];

    //[[NSUserDefaults standardUserDefaults] setObject:cityOriginal forKey:@"currentCity"];
    
    
    //[[NSUserDefaults standardUserDefaults] synchronize];
    
    /*
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setObject:cityCurrent forKey:@"originalCity"];
        [standardUserDefaults synchronize];
    }
     */
    
}

- (IBAction)changeDistanceUnit:(id)sender{

    UISegmentedControl *segmentedCtrl = sender;
    
    Singleton *theSingleton = [Singleton sharedCenter];
    
    
    if (segmentedCtrl.selectedSegmentIndex == 0) {
        
        [theSingleton saveSetting:k_Settings_Distance_Unit_Key_KM withKey:k_Settings_Distance_Unit];
        
        
        
        [_distanceSliderSld setMaximumValue:k_Settings_Distance_Unit_Max_Value_KM];

    }
    else if (segmentedCtrl.selectedSegmentIndex == 1) {
        
        [theSingleton saveSetting:k_Settings_Distance_Unit_Key_Miles withKey:k_Settings_Distance_Unit];
        [_distanceSliderSld setMaximumValue:k_Settings_Distance_Unit_Max_Value_Miles];
        
    }

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.lblOriginCity resignFirstResponder];
    [self.lblCurrentCity resignFirstResponder];
    
    return YES;
    
}

-(void)dismissKeyboard{
    
    [self.lblCurrentCity resignFirstResponder];
    [self.lblOriginCity resignFirstResponder];
    
}

@end
