//
//  ConnectionURL.m
//  indianApp
//
//  Created by victor alejandro reza rodriguez on 20/08/14.
//  Copyright (c) 2014 SystemsUSA. All rights reserved.
//

#import "ConnectionURL.h"

#import "ConstantsConnection.h"



#define k_Dir_Foursquare_Service            @"https://api.foursquare.com/v2/"


@interface ConnectionURL() <NSURLConnectionDelegate>{
    
    NSString *nameServiceCall;
    NSMutableData *dataBuffer;
    
}

@end




@implementation ConnectionURL

//@synthesize delegateConnect;



#pragma mark - Public Methods

-(void)connectionToService:(NSString *)nameService withParameters:(NSMutableDictionary *)parameters{
    
    if (parameters == nil) {
        parameters = [NSMutableDictionary dictionary];
    }
    
    NSMutableString *parametersString = [NSMutableString string];
    
    if (nameServiceCall == nil) {
        nameServiceCall = [NSString string];
    }
    
    nameServiceCall = [NSString stringWithString:nameService];
    
    NSString *pathToService = [self getPathToURL:nameService];
    
    [parametersString appendString:pathToService];
    
    
    for(NSString *key in parameters) {
        
        NSString *value = [parameters objectForKey:key];
        
        [parametersString appendString:key];
        [parametersString appendString:@"="];
        
        value = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)value,  NULL,  (CFStringRef)@"!*'’\"();:@&=+$,/?%#[]%", kCFStringEncodingUTF8));
        
        [parametersString appendString:value];
        [parametersString appendString:@"&"];
        
        
    }
    
    
    NSRange ultimoCaracter = [parametersString rangeOfString:@"&" options:NSBackwardsSearch];
    
    if (ultimoCaracter.length > 0) {
        [parametersString deleteCharactersInRange:ultimoCaracter];
    }
    
    NSMutableURLRequest *requestURL = [NSURLRequest requestWithURL:[NSURL URLWithString:parametersString]];
    
    NSLog(@"Service's Name: %@", nameServiceCall);
    NSLog(@"URL coded: %@ ", parametersString);
    
    [self connect:requestURL];
    
}



#pragma mark - Private Methods

-(NSString *)getPathToURL:(NSString *)nameService {
    
    NSString *path = @"";
    
    if ([nameService isEqualToString:ks_Service_Name_Search_Places]){
        path = [NSString stringWithFormat:@"%@venues/search?", k_Dir_Foursquare_Service];
    }
    
    return path;
    
}

-(void)connect:(NSMutableURLRequest *)request{
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (conn) {
        dataBuffer = [NSMutableData data];
    }
    
}



#pragma mark - Conexion Delegados

-(void)connectionDidFinishLoading:(NSURLConnection *) connection
{
    
    NSDictionary *diccionary = [NSDictionary dictionary];
    id JSON = [NSJSONSerialization JSONObjectWithData:dataBuffer options:0 error:nil];
    diccionary = JSON;
    
    
    if (diccionary != NULL) {
        
        [_delegateConnect finishConnection:diccionary withSuccess:YES toNameService:nameServiceCall];
        
    }
    else {
        
        NSLog(@"Error to create NSDictionary from service '%@'.", nameServiceCall);
        [_delegateConnect finishConnection:nil withSuccess:NO toNameService:nameServiceCall];
        
    }
    
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [dataBuffer setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [dataBuffer appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"Connection error to get service '%@': %@", nameServiceCall, error);
    [_delegateConnect finishConnection:nil withSuccess:NO toNameService:nameServiceCall];
    
}




@end
