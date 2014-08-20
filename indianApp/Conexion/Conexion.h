//
//  ConexionModalView.h
//  iReflexis
//
//  Created by Jesus Manuel Vigueras Chaparro on 09/12/11.
//  Copyright (c) 2011 Banco Azteca. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ConexionDelegate <NSObject>

-(void)finishConexion:(NSDictionary *)JSONDic withSuccess:(BOOL)success toNameService:(NSString *)nameService;

@end



@interface Conexion : NSObject{
    
	NSMutableData *webData;
	NSURLConnection *conn;
    NSString *nameServiceCall;

    id <ConexionDelegate> delegate;
    
}

@property (nonatomic, assign) id <ConexionDelegate> delegate;

@property (nonatomic, retain) NSString *nameServiceCall;



-(void)connect:(NSMutableURLRequest *)request;
-(void)callService:(NSString *)nameService withParameter:(NSMutableDictionary *)parameters;

-(NSString *)getEnviroment;


@end
