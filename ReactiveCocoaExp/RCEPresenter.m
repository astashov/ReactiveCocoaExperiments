//
//  RCEPresenter.m
//  ReactiveCocoaExp
//
//  Created by Anton Astashov on 31/08/13.
//  Copyright (c) 2013 Anton Astashov. All rights reserved.
//

#import "RCEPresenter.h"
#import "NSString+CoreExt.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RCEPresenter ()

@property (readwrite, nonatomic, strong) RACSignal *smallSignal;
@property (readwrite, nonatomic, strong) RACSignal *mediumSignal;
@property (readwrite, nonatomic, strong) RACSignal *largeSignal;

@property (readwrite, nonatomic, strong) RACSignal *nameSignal;
@property (readwrite, nonatomic, strong) RACSignal *addressSignal;
@property (readwrite, nonatomic, strong) RACSignal *zipSignal;

@property (readwrite, strong, nonatomic) NSArray *priceSignals;
@property (readwrite, strong, nonatomic) NSArray *validationSignals;

@end

@implementation RCEPresenter

-(id)init {
    self = [super init];
    if (self) {
        self.smallSignal = RACAbleWithStart(self.small);
        self.mediumSignal = RACAbleWithStart(self.medium);
        self.largeSignal = RACAbleWithStart(self.large);

        self.nameSignal = RACAbleWithStart(self.name);
        self.addressSignal = RACAbleWithStart(self.address);
        self.zipSignal = RACAbleWithStart(self.zip);

        self.priceSignals = @[self.smallSignal, self.mediumSignal, self.largeSignal];
        self.validationSignals = [self.priceSignals
            arrayByAddingObjectsFromArray:@[self.nameSignal, self.addressSignal, self.zipSignal]
        ];
    }
    return self;
}

#pragma mark Price Calculators

-(NSNumber *)calculateSubtotalPrice {
    return @(
        [self.small ?: @0 doubleValue] * 5.00 +
        [self.medium ?: @0 doubleValue] * 10.00 +
        [self.large ?: @0 doubleValue] * 15.00
    );
}

-(NSNumber *)calculateTaxPrice {
    return @(([[self calculateSubtotalPrice] floatValue] + [[self calculateShippingPrice] floatValue]) * 0.0825);
}

-(NSNumber *)calculateShippingPrice {
    return @(([self.small ?: @0 doubleValue] + [self.medium ?: @0 doubleValue] + [self.large ?: @0 doubleValue]) * 2.0);
}

-(NSNumber *)calculateTotalPrice {
    return @(
        [[self calculateSubtotalPrice] floatValue] +
        [[self calculateShippingPrice] floatValue] +
        [[self calculateTaxPrice] floatValue]
    );
}

#pragma mark isValid methods

-(BOOL)isAllValid {
    return (
        (
            [self.small integerValue] != 0 ||
            [self.medium integerValue] != 0 ||
            [self.large integerValue] != 0
        ) &&
        [self isValidName] &&
        [self isValidAddress] &&
        [self isValidZip]
    );
}

-(BOOL)isValidName {
    return [self.name isPresent];
}

-(BOOL)isValidAddress {
    return [self.address isPresent];
}

-(BOOL)isValidZip {
    return [self.zip integerValue] && [self.zip integerValue] != 0;
}

@end
