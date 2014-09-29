//
//  ConnectionURL.h
//  indianApp
//
//  Created by victor alejandro reza rodriguez on 20/08/14.
//  Copyright (c) 2014 SystemsUSA. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ConnectionURLDelegate <NSObject>


@required

-(void)finishConnection:(NSDictionary *)dataDic withSuccess:(BOOL)success toNameService:(NSString *)nameService;


@end




@interface ConnectionURL : UIViewController


@property (nonatomic, assign) id <ConnectionURLDelegate> delegateConnect;


-(void)connectionToService:(NSString *)nameService withParameters:(NSMutableDictionary *)parameters;



@end
