//
//  HomeViewController.m
//  indianApp
//
//  Created by SystemsUSA on 5/8/14.
//  Copyright (c) 2014 SystemsUSA. All rights reserved.
//

#import "HomeViewController.h"
#import "SWRevealViewController.h"

#import "MPSkewedCell.h"
#import "MPSkewedParallaxLayout.h"


#import "indianNewsTableViewController.h"
#import "TemplesListVC.h"




static NSString *kCell = @"cell";

#define PARALLAX_ENABLED 1




@interface HomeViewController ()

@end

@implementation HomeViewController

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
    
    UIColor *backColor = [UIColor colorWithRed:250.0f/255.0f green:94.0f/255.0f blue:29.0f/255.0f alpha:1.0f];
    
    self.navigationController.navigationBar.barTintColor = backColor;
    
    arrImages = [[NSMutableArray alloc]init];
    
    [arrImages addObject:@"newspaper.jpg"];
    [arrImages addObject:@"temples.jpg"];
    [arrImages addObject:@"events.jpg"];
    [arrImages addObject:@"food.jpg"];
    [arrImages addObject:@"classified.jpg"];
    [arrImages addObject:@"socialHindi.png"];
    [arrImages addObject:@"shopping.jpg"];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.view setBackgroundColor:[UIColor whiteColor]];
     
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    //Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    //Collection animated...
    choosed=-1;
    
#ifndef PARALLAX_ENABLED
    // you can use that if you don't need parallax
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.itemSize=CGSizeMake(self.view.width, 230);
    layout.minimumLineSpacing=-layout.itemSize.height/3; // must be always the itemSize/3
    //use the layout you want as soon as you recalculate the proper spacing if you made different sizes
#else
    MPSkewedParallaxLayout *layout=[[MPSkewedParallaxLayout alloc] init];
    
    
#endif
    _collectionView=[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.backgroundColor=[UIColor whiteColor];
    
    [_collectionView registerClass:[MPSkewedCell class] forCellWithReuseIdentifier:kCell];
    
    //New location for the main menu
    _collectionView.frame = CGRectMake(_collectionView.frame.origin.x, _collectionView.frame.origin.y + 42, _collectionView.frame.size.width, _collectionView.frame.size.height);
    
    [self.view addSubview:_collectionView];
    
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    
}


#pragma delegates Menu annimated
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 7;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MPSkewedCell* cell = (MPSkewedCell *) [collectionView dequeueReusableCellWithReuseIdentifier:kCell forIndexPath:indexPath];
    
    cell.image = [UIImage imageNamed:[arrImages objectAtIndex:indexPath.row]];
    
    NSString *text;
    NSInteger index=choosed>=0 ? choosed : indexPath.row%7;
    
    switch (index) {
        case 0:
            text=@"NEWS\n indian news";
            break;
        case 1:
            text=@"TEMPLES\n nearby temples";
            break;
        case 2:
            text=@"EVENTS\n local events";
            break;
        case 3:
            text=@"RESTAURANTS\n indian food";
            break;
        case 4:
            text=@"CLASSIFIED\n buy and sell";
            break;
        case 5:
            text=@"SOCIAL\n keep you connected";
            break;
        case 6:
            text=@"SHOPPING\n find what you want";
            break;
        default:
            break;
    }
    
    cell.text=text;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    //Load news view...
//    indianNewsTableViewController *newsController = [[indianNewsTableViewController alloc] initWithNibName:@"indianNewsTableViewController" bundle:nil];
//    
//    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:newsController];
//    
//    [self presentViewController:navController animated:YES completion:nil];

    
    if (indexPath.row != 1) {
        
        indianNewsTableViewController *newsController = [[indianNewsTableViewController alloc] initWithNibName:@"indianNewsTableViewController" bundle:nil];
        
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:newsController];
        
        [self presentViewController:navController animated:YES completion:nil];
        
    }
    else{
        
        NSLog(@"Templos");
        
        TemplesListVC *newsController = [[TemplesListVC alloc] initWithNibName:@"TemplesListVC" bundle:nil];
        
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:newsController];
        
        [self presentViewController:navController animated:YES completion:nil];
        
        
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
