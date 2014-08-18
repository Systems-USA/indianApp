//
//  NewsTableViewCell.h
//  indianApp
//
//  Created by SystemsUSA on 6/6/14.
//  Copyright (c) 2014 SystemsUSA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitleNews;
@property (weak, nonatomic) IBOutlet UILabel *lblContentNews;
@property (weak, nonatomic) IBOutlet UIImageView *imgNews;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
