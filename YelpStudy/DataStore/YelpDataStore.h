//
//  YelpDataStore.h
//  YelpStudy
//
//  Created by Joshua on 12/3/18.
//  Copyright © 2018 Joshua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YelpDataModel.h"

@import CoreLocation;
@interface YelpDataStore : NSObject

@property (nonatomic, copy) NSArray <YelpDataModel *> *dataModels;
@property (nonatomic) CLLocation *userLocation;

+ (YelpDataStore *)sharedInstance;
@end
