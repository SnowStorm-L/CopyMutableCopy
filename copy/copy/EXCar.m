//
//  EXCar.m
//  copy
//
//  Created by L on 2018/4/17.
//  Copyright © 2018年 L. All rights reserved.
//

#import "EXCar.h"
#import "EXMutableCar.h"

@interface EXCar()

@property (nonatomic, strong, readwrite) NSString *name;

@end

@implementation EXCar

- (id)copyWithZone:(NSZone *)zone {
    EXCar* car = [[[self class] allocWithZone:zone] init];
    car->_name = [_name copyWithZone:zone];
    return car;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    EXMutableCar *mutableCar = [[EXMutableCar allocWithZone:zone] init];
    mutableCar.name = [_name mutableCopyWithZone:zone];
    return mutableCar;
}

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        self.name = name;
    }
    return self;
}

@end
