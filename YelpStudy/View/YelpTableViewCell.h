//
//  YelpTableViewCell.h
//  YelpStudy
//
//  Created by Joshua on 12/2/18.
//  Copyright © 2018 Joshua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpDataModel.h"

@interface YelpTableViewCell : UITableViewCell

- (void)updateBasedOnDataModel:(YelpDataModel *)dataModel;

@end

