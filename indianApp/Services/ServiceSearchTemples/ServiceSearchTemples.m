//
//  ServiceSearchTemples.m
//  indianApp
//
//  Created by victor alejandro reza rodriguez on 20/08/14.
//  Copyright (c) 2014 SystemsUSA. All rights reserved.
//

#import "ServiceSearchTemples.h"

#import "GeneralConstants.h"
#import "ConstantsFoursquareKeys.h"
#import "ConstantsConnection.h"


#import "ConnectionURL.h"



#define k_Name_Query_Mandir                 @"mandir"
#define k_Name_Query_Hindu                  @"hindu"



@interface ServiceSearchTemples () <ConnectionURLDelegate> {
    
    NSInteger *countServices;
    NSMutableArray *querysToCallArr;
    NSMutableArray *responsesFromService;

}


@property (nonatomic, strong) ConnectionURL *connect;


@end



@implementation ServiceSearchTemples



#pragma mark - Public Methods

-(void)getServiceSearchTemples:(NSString *)stringSearch{

    //api.foursquare.com/v2/venues/search?client_id=P0TS2KXJB4LXFUN2GROEQZFA2UATSJY1IEJNQM2YOBRED4XI&client_secret=QVU5F4VIHTDR23GDM1OQ1FYHDAGNZFDZVKEUPKJ2LZPGE5EI&v=20140815&ll=42.475819,-83.411175&radius=100000&query=puja
    
    [self manageQuerysToCallService];
    
}



#pragma mark - Private Methods

-(void)manageQuerysToCallService{

    if (querysToCallArr == nil) {
        
        querysToCallArr = [NSMutableArray arrayWithObjects:k_Name_Query_Mandir, k_Name_Query_Hindu, nil];
        responsesFromService = [NSMutableArray array];
        
    }
    else{
        [querysToCallArr removeObjectAtIndex:0];
    }
    
    
    if ([querysToCallArr count] != 0) {
        
        NSMutableDictionary *parameters = [self defineConstantParametersToService];
        [parameters setObject:[querysToCallArr objectAtIndex:0] forKey:kf_Foursquare_Query];
    
        [self connectService:parameters];
        
        NSLog(@"Despues - connectService");
    }
    else{
        
        [self parserInfo:responsesFromService];
        
    }

}

-(NSMutableDictionary *)defineConstantParametersToService{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:k_Foursquare_Client_ID forKey:kf_Foursquare_Cliente_ID];
    [parameters setObject:k_Foursquare_Client_Secet forKey:kf_Foursquare_Cliente_Secret];
    [parameters setObject:k_Foursquare_Version forKey:kf_Foursquare_Version];
    [parameters setObject:@"100000" forKey:kf_Foursquare_Distance];
    [parameters setObject:@"42.475819,-83.411175" forKey:kf_Foursquare_Location_User];
    
    
    return parameters;


}

-(void)connectService:(NSMutableDictionary*)parametersDic{

    if (_connect == nil) {
        _connect = [[ConnectionURL alloc] init];
        [_connect setDelegateConnect:self];
    }
    
    [_connect connectionToService:ks_Service_Name_Search_Places withParameters:parametersDic];


}

-(void)parserInfo:(NSMutableArray *)arrayWithInfo{
    
    NSArray *justVenues = [self takeOutFromMainArray:arrayWithInfo];
    
    NSArray *filterVenues = [self takeDistinctDictionaryFromArray:justVenues withKeyFromDictionary:kf_Foursquare_Venue_Id];
    
    //NSLog(@"finalVenues: %@", filterVenues);

    NSMutableArray *datosSorted = [NSMutableArray arrayWithArray:filterVenues];
    NSSortDescriptor *distanceOrder = [[NSSortDescriptor alloc] initWithKey:kf_Foursquare_Venue_Distance ascending:YES];
    
    [datosSorted sortUsingDescriptors:[NSArray arrayWithObjects:distanceOrder, nil]];
    
    NSLog(@"datosSorted: %@", datosSorted);
    [_delegate endServiceSearchTemples:[NSArray arrayWithArray:datosSorted]];
    
}

-(NSArray *)takeOutFromMainArray:(NSArray *)mainArray{
    
    NSMutableArray *finalArray = [NSMutableArray array];
    
    for (NSDictionary *originalDic in mainArray) {
        
        NSDictionary *responseDic = [originalDic objectForKey:kf_Foursquare_Venue_Response];
        NSArray *venuesArr = [responseDic objectForKey:kf_Foursquare_Venue_Venues];
        
        
        for (NSDictionary *venueDic in venuesArr) {
            
            NSMutableDictionary *newVenueDic = [NSMutableDictionary dictionary];
            
            [newVenueDic setObject:[venueDic objectForKey:kf_Foursquare_Venue_Id] forKey:kf_Foursquare_Venue_Id];
            [newVenueDic setObject:[venueDic objectForKey:kf_Foursquare_Venue_Name] forKey:kf_Foursquare_Venue_Name];
            
            NSDictionary *locationDic = [venueDic objectForKey:kf_Foursquare_Venue_Location];
            
            [newVenueDic setObject:[locationDic objectForKey:kf_Foursquare_Venue_Latitud] forKey:kf_Foursquare_Venue_Latitud];
            [newVenueDic setObject:[locationDic objectForKey:kf_Foursquare_Venue_Longitud] forKey:kf_Foursquare_Venue_Longitud];
            [newVenueDic setObject:[locationDic objectForKey:kf_Foursquare_Venue_Distance] forKey:kf_Foursquare_Venue_Distance];
            
            
            NSArray *addressArr = [locationDic objectForKey:kf_Foursquare_Venue_Address];
            NSMutableString *completeAddress = [NSMutableString string];
            
            for (NSInteger iCount = 0; iCount < [addressArr count]; iCount++) {

                NSString *tempAdd = [addressArr objectAtIndex:iCount];
                [completeAddress appendString:tempAdd];
                [completeAddress appendString:@" "];
                
            }
            
            [newVenueDic setObject:[NSString stringWithString:completeAddress] forKey:kf_Foursquare_Venue_Address];
            [finalArray addObject:[NSDictionary dictionaryWithDictionary:newVenueDic]];
            
        }
        
        
    }
    
    //NSLog(@"finalArray: %@", finalArray);
    return [NSArray arrayWithArray:finalArray];
    
}

-(NSArray *)takeDistinctDictionaryFromArray:(NSArray *)arrayToFilter withKeyFromDictionary:(NSString *)keyFilter{

    NSString *queryValueKeyPath = [NSString stringWithFormat:@"@distinctUnionOfObjects.%@", keyFilter];
    NSArray *distinctVenues = [arrayToFilter valueForKeyPath:queryValueKeyPath];
    
    
    NSMutableArray *finalVenues = [NSMutableArray array];
    
    for (NSString *idVenue in distinctVenues) {
        
        for (NSDictionary *tempDic in arrayToFilter) {
            
            NSString *idVenueFromDic = [tempDic objectForKeyedSubscript:keyFilter];
            
            if ([idVenue isEqualToString:idVenueFromDic]) {
                
                [finalVenues addObject:[NSDictionary dictionaryWithDictionary:tempDic]];
                break;
                
            }
        }
    }
    
    return [NSArray arrayWithArray:finalVenues];
    
}



#pragma mark - Connection Delegate Methods

-(void)finishConnection:(NSDictionary *)dataDic withSuccess:(BOOL)success toNameService:(NSString *)nameService{

    if (success) {
        
        //NSLog(@"JSONDic: %@", dataDic);
        
        [responsesFromService addObject:[NSDictionary dictionaryWithDictionary:dataDic]];
        
        [self manageQuerysToCallService];
        
    }
    else{
    
        [self manageQuerysToCallService];
    
    }

}




@end
