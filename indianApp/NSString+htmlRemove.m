//
//  NSString+htmlRemove.m
//  indianApp
//
//  Created by SystemsUSA on 6/6/14.
//  Copyright (c) 2014 SystemsUSA. All rights reserved.
//

#import "NSString+htmlRemove.h"

@implementation NSString (htmlRemove)

-(NSString *)stringByStrippingHTML{
    
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound){
        s = [s stringByReplacingCharactersInRange:r withString:@""];}
    
    s = [s stringByReplacingOccurrencesOfString:@"&#39;s" withString:@""];
    
    s = [s stringByReplacingOccurrencesOfString:@"&#39;" withString:@""];
    
    s = [s stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    
    
    s = [s stringByReplacingOccurrencesOfString:@"&quot;" withString:@""];
    
    return s;
    
}

@end
