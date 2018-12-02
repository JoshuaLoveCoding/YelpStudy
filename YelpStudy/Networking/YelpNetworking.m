//
//  YelpNetworking.m
//  YelpStudy
//
//  Created by Joshua on 12/1/18.
//  Copyright © 2018 Joshua. All rights reserved.
//

#import "YelpNetworking.h"

static NSString * const api_key = @"***";

typedef void (^TokenPendingTask)(NSString *token);

@interface YelpNetworking ()

@property (nonatomic, copy) NSString *token;

@end

@implementation YelpNetworking

+ (YelpNetworking *)sharedInstance {
    static YelpNetworking *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[YelpNetworking alloc] init];
    });
    return _sharedInstance;
}

- (void)fetchTokenWithTokenPendingTask:(TokenPendingTask)tokenPendingTask
{
    self.token = api_key;
    if (tokenPendingTask) {
        tokenPendingTask(self.token);
    }
}


-(void)fetchRestaurantsBasedOnLocation:(CLLocation *)location term:(NSString *)term completionBlock:(RestaurantCompletionBlock)completionBlock
{
    TokenPendingTask tokenTask = ^(NSString *token){
        NSString *string = [NSString stringWithFormat:@"https://api.yelp.com/v3/businesses/search?term=%@&latitude=%.6f&longitude=%.6f",term, location.coordinate.latitude, location.coordinate.longitude];
        
        NSURL *url = [NSURL URLWithString:string];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        
        [request setHTTPMethod:@"GET"];
        
        NSString *headerToken = [NSString stringWithFormat:@"Bearer %@",token];
        
        [request addValue:headerToken forHTTPHeaderField:@"Authorization"];
        
        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NULL error:nil];
            if (!error) {
                completionBlock([YelpDataModel buildDataModelArrayFromDictionaryArray:dict[@"businesses"]]);
            }
        }];
        
        [dataTask resume];
    };
    
    if (self.token) {
        tokenTask(self.token);
    } else {
        [self fetchTokenWithTokenPendingTask:^ (NSString *token) {
            tokenTask(token);
        }];
    }

}

@end
