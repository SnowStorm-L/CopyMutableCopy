//
//  TestView.h
//  copy
//
//  Created by L on 2018/4/16.
//  Copyright © 2018年 L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestView : UIView<NSCopying>

@property (nonatomic, copy) NSString *string;

@property (nonatomic, strong) NSMutableDictionary *mutableDictionary;

@property (nonatomic, assign) NSInteger age;

@end
