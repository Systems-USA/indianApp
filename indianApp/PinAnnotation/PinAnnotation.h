//
//  PinAnnotation.h
//  indianApp
//
//  Created by victor alejandro reza rodriguez on 22/08/14.
//  Copyright (c) 2014 SystemsUSA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface PinAnnotation : NSObject <MKAnnotation>



@property (nonatomic, weak) NSString *label;
@property (nonatomic, weak) NSString *addres;
@property (nonatomic, weak) NSString *latitude;
@property (nonatomic, weak) NSString *longitude;
@property (nonatomic, weak) NSString *idVenue;
@property (nonatomic, weak) NSString *image;
@property (nonatomic, weak) NSString *type;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;


@end
