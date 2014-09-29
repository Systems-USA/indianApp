//
//  ServiceSearchTemples.h
//  indianApp
//
//  Created by victor alejandro reza rodriguez on 20/08/14.
//  Copyright (c) 2014 SystemsUSA. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol ServiceSearchTemplesDelegate <NSObject>


@required

-(void)endServiceSearchTemples:(NSArray * )array;



@end




@interface ServiceSearchTemples : NSObject


@property (nonatomic, assign) id <ServiceSearchTemplesDelegate> delegate;




-(void)getServiceSearchTemples:(NSString *)stringSearch;



@end
