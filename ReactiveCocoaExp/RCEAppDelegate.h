//
//  RCEAppDelegate.h
//  ReactiveCocoaExp
//
//  Created by Anton Astashov on 8/26/13.
//  Copyright (c) 2013 Anton Astashov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "stdio.h"

@class RCEViewController;

@interface RCEAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) RCEViewController *viewController;

@end
