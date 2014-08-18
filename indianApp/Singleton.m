//
//  Singleton.m
//  indianApp
//
//  Created by SystemsUSA on 6/12/14.
//  Copyright (c) 2014 SystemsUSA. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

static Singleton *sharedSingleton = nil;

+(Singleton *)sharedCenter{
    
    if (sharedSingleton == nil) {
        sharedSingleton = [[super allocWithZone:NULL]init];
    }
    return sharedSingleton;
    
}

-(id)init{
    
    if ((self = [super init])) {
        //custom initialization
        userInfo = [self defaultInitialization];//[NSMutableDictionary dictionary];
    }
    else{
        [self defaultInitialization];
    }
    return self;
    
}

-(NSMutableDictionary *)defaultInitialization{
    
    userInfo = [NSMutableDictionary dictionary];
    
    [userInfo setValue:@"New Delhi" forKey:@"originalCity"];
    [userInfo setValue:@"Detroit" forKey:@"currentCity"];
    
    return userInfo;
}


//singleton methods
+(id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedCenter];
}

-(id)copyWithZone:(NSZone *)zone{
    return self;
}

-(void)customMethod{
    
}

-(NSMutableDictionary *)loadSettings:(NSMutableDictionary *)dictDetails{
    
    //if([userInfo count] > 0){
      //  [userInfo removeAllObjects];
    //}
    
    userInfo = [dictDetails copy];
    
    return userInfo;

}

-(NSMutableDictionary *)returnUserInfo{
    
    return userInfo;
    
}

@end
