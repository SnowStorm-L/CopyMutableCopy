//
//  EXMutableCar.m
//  copy
//
//  Created by L on 2018/4/17.
//  Copyright © 2018年 L. All rights reserved.
//

#import "EXMutableCar.h"

@implementation EXMutableCar

@synthesize name = _mutableName;

- (id)copyWithZone:(NSZone *)zone {
    EXCar *car = [[EXCar alloc]initWithName:_mutableName];
    return car;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    EXMutableCar* car = [super mutableCopyWithZone:zone];
    car->_mutableName = [_mutableName mutableCopyWithZone:zone];
    return car;
}

@end
