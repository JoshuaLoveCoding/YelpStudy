//
//  YelpDataStore.m
//  YelpStudy
//
//  Created by Joshua on 12/3/18.
//  Copyright © 2018 Joshua. All rights reserved.
//

#import "YelpDataStore.h"

@implementation YelpDataStore

+ (YelpDataStore *)sharedInstance {
    static YelpDataStore *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[YelpDataStore alloc] init];
    });
    return _sharedInstance;
}

@end
