//
//  EXCar.h
//  copy
//
//  Created by L on 2018/4/17.
//  Copyright © 2018年 L. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXCar : NSObject<NSCopying, NSMutableCopying>

@property (nonatomic, strong, readonly) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end
