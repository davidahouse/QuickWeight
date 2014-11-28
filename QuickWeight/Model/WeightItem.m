//
//  WeightItem.m
//  QuickWeight
//
//  Created by David House on 11/8/14.
//  Copyright (c) 2014 Random Accident. All rights reserved.
//

#import "WeightItem.h"

@implementation WeightItem

#pragma mark - Public Methods
- (void)saveToHealthStore:(HKHealthStore *)healthStore
{
    NSDate *now = [NSDate date];

    HKQuantityType *qType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    
    HKQuantity *quantity = [HKQuantity quantityWithUnit:[HKUnit poundUnit] doubleValue:[self.weight doubleValue]];
    if ( !quantity ) {
        return;
    }
    
    HKQuantitySample *qSample = [HKQuantitySample quantitySampleWithType:qType quantity:quantity startDate:now endDate:now];
    
    [healthStore saveObject:qSample withCompletion:^(BOOL success, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                
                NSLog(@"Weight saved correctly");
            }
            else {
                
                NSLog(@"error %@ creating sample for weight",error);
            }
        });
    }];
}

@end
