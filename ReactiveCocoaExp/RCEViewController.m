//
//  RCEViewController.m
//  ReactiveCocoaExp
//
//  Created by Anton Astashov on 8/26/13.
//  Copyright (c) 2013 Anton Astashov. All rights reserved.
//

#import "RCEViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <EXTScope.h>
#import "RCEPresenter.h"

@implementation RCEViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.presenter = [[RCEPresenter alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self bindAmountFields];
    [self bindPriceFields];
    [self bindAddressFields];
    [self bindNextButton];
}

-(IBAction)next:(id)sender {
    NSLog(@"Clicked to next");
}

#pragma mark Bindings

-(void)bindAmountFields {
    [self.smallField.rac_textSignal subscribeNext:^(NSString *value) {
        self.presenter.small = @([value integerValue]);
    }];
    [self.mediumField.rac_textSignal subscribeNext:^(NSString *value) {
        self.presenter.medium = @([value integerValue]);
    }];
    [self.largeField.rac_textSignal subscribeNext:^(NSString *value) {
        self.presenter.large = @([value integerValue]);
    }];
}

-(void)bindPriceFields {
    RACSignal *subtotalPriceSignal = [self buildPriceSignal:^{
        return [self.presenter calculateSubtotalPrice];
    }];
    RAC(self.subtotalPriceLabel.text) = subtotalPriceSignal;
    RAC(self.priceLabel.text) = subtotalPriceSignal;

    RAC(self.shippingPriceLabel.text) = [self buildPriceSignal:^{
        return [self.presenter calculateShippingPrice];
    }];
    RAC(self.taxPriceLabel.text) = [self buildPriceSignal:^{
        return [self.presenter calculateTaxPrice];
    }];
    RAC(self.totalPriceLabel.text) = [self buildPriceSignal:^{
        return [self.presenter calculateTotalPrice];
    }];
}

-(void)bindAddressFields {
    [self.nameField.rac_textSignal subscribeNext:^(NSString *value) {
        self.presenter.name = value;
    }];
    [self.addressField.rac_textSignal subscribeNext:^(NSString *value) {
        self.presenter.address = value;
    }];
    [self.zipField.rac_textSignal subscribeNext:^(NSString *value) {
        self.presenter.zip = @([value integerValue]);
    }];

    RAC(self.nameField.backgroundColor) = [self.presenter.nameSignal map:^id(NSString *name) {
        return [self fieldColor:[self.presenter isValidName]];
    }];
    RAC(self.addressField.backgroundColor) = [self.presenter.addressSignal map:^id(NSString *address) {
        return [self fieldColor:[self.presenter isValidAddress]];
    }];
    RAC(self.zipField.backgroundColor) = [self.presenter.zipSignal map:^id(NSNumber *zip) {
        return [self fieldColor:[self.presenter isValidZip]];
    }];
}

-(void)bindNextButton {
    RAC(self.nextButton.enabled) = [RACSignal
        combineLatest:self.presenter.validationSignals
        reduce:^id(NSNumber *_s, NSNumber *_m, NSNumber *_l, NSString *_n, NSString *_a, NSNumber *_z) {
            return @([self.presenter isAllValid]);
        }
    ];
}

#pragma mark Signal Builders

-(RACSignal *)buildPriceSignal:(id (^)())resultBlock {
    return [RACSignal
        combineLatest:self.presenter.priceSignals
        reduce:^id(NSNumber *_s, NSNumber *_m, NSNumber *_l) {
            return [NSString stringWithFormat:@"%.2f", [resultBlock() floatValue]];
        }
    ];
}

#pragma mark Private Methods

-(UIColor *)fieldColor:(BOOL)predicate {
    return predicate ? [UIColor whiteColor] : [UIColor redColor];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end