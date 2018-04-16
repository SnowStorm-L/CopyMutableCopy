//
//  TestView.m
//  copy
//
//  Created by L on 2018/4/16.
//  Copyright © 2018年 L. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (id)copyWithZone:(NSZone *)zone {
    TestView *testView = [[[self class] allocWithZone:zone]init];
    testView.string =  [self.string copyWithZone:zone];
    testView.mutableDictionary = [self.mutableDictionary mutableCopyWithZone:zone];
    testView.age = self.age;
    return testView;
}

@end
