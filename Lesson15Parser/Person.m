//
//  Person.m
//  Lesson15Parser
//
//  Created by lanouhn on 15/9/22.
//  Copyright (c) 2015年 大爱海星星. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)dealloc {
    [_position release];
    [_name release];
    [_gender release];
    [_hobby release];
    [_age release];
    [_job release];
    [super dealloc];
}

@end
