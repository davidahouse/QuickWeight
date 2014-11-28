//
//  RootViewController.m
//  QuickWeight
//
//  Created by David House on 11/8/14.
//  Copyright (c) 2014 Random Accident. All rights reserved.
//

#import "RootViewController.h"
#import <HealthKit/HealthKit.h>
#import "WeightItem.h"

@interface RootViewController () <UITextFieldDelegate>

#pragma mark - Properties
@property (nonatomic,strong) HKHealthStore *healthStore;

#pragma mark - Outlets
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set up an HKHealthStore, asking the user for read/write permissions.
    if ([HKHealthStore isHealthDataAvailable]) {
        self.healthStore = [[HKHealthStore alloc] init];
        
        
        HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];;
        NSSet *writeDataTypes = [NSSet setWithObject:weightType];
        NSSet *readDataTypes = [NSSet set];
        
        [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
            
            if (!success) {
                NSLog(@"You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: %@. If you're using a simulator, try it on a device.", error);
                return;
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITextField delegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    // Save the weight into HealthKit
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.weightTextField resignFirstResponder];
    return YES;
}

#pragma mark - IBActions
- (IBAction)saveWeight:(id)sender
{
    [self.weightTextField resignFirstResponder];
    
    WeightItem *weight = [[WeightItem alloc] init];
    weight.weight = [NSNumber numberWithDouble:[self.weightTextField.text doubleValue]];
    [weight saveToHealthStore:self.healthStore];
    
    self.weightTextField.text = @"";
}

@end
