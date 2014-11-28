//
//  WeightItem.h
//  QuickWeight
//
//  Created by David House on 11/8/14.
//  Copyright (c) 2014 Random Accident. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>

@interface WeightItem : NSObject

#pragma mark - Properties
@property (nonatomic,strong) NSNumber *weight;

#pragma mark - Public Methods
- (void)saveToHealthStore:(HKHealthStore *)healthStore;

@end
