//
//  Singleton.h
//  indianApp
//
//  Created by SystemsUSA on 6/12/14.
//  Copyright (c) 2014 SystemsUSA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject{
    
    NSMutableDictionary *userInfo;
    
}

+(Singleton *)sharedCenter;

-(void)customMethod;

-(NSMutableDictionary *)loadSettings:(NSMutableDictionary *)dictDetails;

-(NSMutableDictionary *)returnUserInfo;

@end
