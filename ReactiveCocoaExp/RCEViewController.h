//
//  RCEViewController.h
//  ReactiveCocoaExp
//
//  Created by Anton Astashov on 8/26/13.
//  Copyright (c) 2013 Anton Astashov. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RCEPresenter;

@interface RCEViewController : UIViewController

@property (strong, nonatomic) RCEPresenter *presenter;

@property (weak, nonatomic) IBOutlet UITextField *smallField;
@property (weak, nonatomic) IBOutlet UITextField *mediumField;
@property (weak, nonatomic) IBOutlet UITextField *largeField;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UITextField *zipField;

@property (weak, nonatomic) IBOutlet UILabel *subtotalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *taxPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *shippingPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;

- (IBAction)next:(id)sender;

@end
