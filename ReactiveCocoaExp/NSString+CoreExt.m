//
//  NSString+CoreExt.m
//  ReactiveCocoaExp
//
//  Created by Anton Astashov on 31/08/13.
//  Copyright (c) 2013 Anton Astashov. All rights reserved.
//

#import "NSString+CoreExt.h"

@implementation NSString (CoreExt)

-(BOOL)isBlank {
    // Note that [string length] == 0 can be false when [string isEqualToString:@""] is true, because these are Unicode strings.
    NSString *string = [self stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return [string isEqualToString:@""];
}

-(BOOL)isPresent {
    return ![self isBlank];
}

@end
