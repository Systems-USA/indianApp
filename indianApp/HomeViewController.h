//
//  HomeViewController.h
//  indianApp
//
//  Created by SystemsUSA on 5/8/14.
//  Copyright (c) 2014 SystemsUSA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Frame.h"

@interface HomeViewController : UIViewController<UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>{
    
    UICollectionView *_collectionView;
    NSInteger choosed;
    NSMutableArray *arrImages;
    
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIButton *newsBtn;
@property (weak, nonatomic) IBOutlet UIButton *btnTemples;
@property (weak, nonatomic) IBOutlet UIButton *btnEvents;
@property (weak, nonatomic) IBOutlet UIButton *btnRestaurants;
@property (weak, nonatomic) IBOutlet UIButton *btnClassified;
@property (weak, nonatomic) IBOutlet UIButton *btnSocial;
@property (weak, nonatomic) IBOutlet UIButton *btnLock;

@end
