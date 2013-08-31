//
//  RCEPresenter.h
//  ReactiveCocoaExp
//
//  Created by Anton Astashov on 31/08/13.
//  Copyright (c) 2013 Anton Astashov. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RACSignal;

@interface RCEPresenter : NSObject

-(NSNumber *)calculateSubtotalPrice;
-(NSNumber *)calculateTaxPrice;
-(NSNumber *)calculateShippingPrice;
-(NSNumber *)calculateTotalPrice;

-(BOOL)isValidName;
-(BOOL)isValidAddress;
-(BOOL)isValidZip;
-(BOOL)isAllValid;

@property (readwrite, strong, nonatomic) NSNumber *small;
@property (readwrite, strong, nonatomic) NSNumber *medium;
@property (readwrite, strong, nonatomic) NSNumber *large;

@property (readwrite, strong, nonatomic) NSString *name;
@property (readwrite, strong, nonatomic) NSString *address;
@property (readwrite, strong, nonatomic) NSNumber *zip;

@property (readonly, nonatomic, strong) RACSignal *smallSignal;
@property (readonly, nonatomic, strong) RACSignal *mediumSignal;
@property (readonly, nonatomic, strong) RACSignal *largeSignal;

@property (readonly, nonatomic, strong) RACSignal *nameSignal;
@property (readonly, nonatomic, strong) RACSignal *addressSignal;
@property (readonly, nonatomic, strong) RACSignal *zipSignal;

@property (readonly, strong, nonatomic) NSArray *priceSignals;
@property (readonly, strong, nonatomic) NSArray *validationSignals;

@end
