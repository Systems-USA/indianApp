//
//  Singleton.m
//  indianApp
//
//  Created by SystemsUSA on 6/12/14.
//  Copyright (c) 2014 SystemsUSA. All rights reserved.
//

#import "Singleton.h"
#import "GeneralConstants.h"



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
    
    [userInfo setValue:@"New Delhi" forKey:k_Settings_Original_City];
    [userInfo setValue:@"Detroit" forKey:k_Settings_Current_City];
    [userInfo setValue:k_Settings_Distance_Unit_Key_Miles forKey:k_Settings_Distance_Unit];
    [userInfo setValue:[NSNumber numberWithDouble:k_Settings_Distance_Unit_Max_Value_Miles] forKey:k_Settings_Distance_Long];
    
    return userInfo;
}


//singleton methods
+(id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedCenter];
}

-(id)copyWithZone:(NSZone *)zone{
    return self;
}



-(NSMutableDictionary *)loadSettings:(NSMutableDictionary *)dictDetails{
    
    //if([userInfo count] > 0){
      //  [userInfo removeAllObjects];
    //}
    
    userInfo = [dictDetails copy];
    
    return userInfo;

}

-(void)saveSetting:(id)setting withKey:(NSString *)settingKey{
    
    [userInfo setObject:setting forKey:settingKey];

}

-(id)getSettingWithKey:(NSString *)settingKey{
    
    return [userInfo objectForKey:settingKey];
    
}

-(NSMutableDictionary *)returnUserInfo{
    
    return userInfo;
    
}

@end
