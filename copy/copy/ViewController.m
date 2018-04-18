//
//  ViewController.m
//  copy
//
//  Created by L on 2018/4/16.
//  Copyright © 2018年 L. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"
#import "EXCar.h"
#import "EXMutableCar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // iOS 中 copy和mutableCopy 并不等于浅拷贝和深拷贝
    // 另外集合对象和非集合对象的拷贝也是有差别的
    
    // 官网关于浅拷贝和深拷贝的介绍
    
    // https://developer.apple.com/library/content/documentation/CoreFoundation/Conceptual/CFMemoryMgmt/Concepts/CopyFunctions.html#//apple_ref/doc/uid/20001149-CJBEJBHH
    // 集合对象的拷贝
    // https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Collections/Articles/Copying.html#//apple_ref/doc/uid/TP40010162-SW1
    
    //[self nonCollectionObjectsTest];
    //[self collectionObjectsTest];
    //[self realDeepCopyInCollectionMethodOne];
    //[self realDeepCopyInCollectionMethodTwo];
    //[self realDeepCopyInCollectionMethodThree];
    
    // How to implement properly mutableCopyWithZone and copyWithZone
    //[self carDemo];
}

- (void)nonCollectionObjectsTest {
    // 非集合对象样例
    NSString *originStr = @"testStr";
    NSLog(@"originStr 的存储地址 %p", originStr);
    
    // 对originStr进行copy和mutableCopy操作
    NSString *copyOriginStr = [originStr copy];
    NSMutableString *mutableCopyOriginStr = [originStr mutableCopy];
    
    NSLog(@"copyOriginStr 的存储地址 %p 是浅拷贝", copyOriginStr);
    NSLog(@"mutableCopyOriginStr 的存储地址 %p 是深拷贝", mutableCopyOriginStr);
    NSLog(@"\n");
    
    // 对originMutableStr进行copy和mutableCopy操作
    NSMutableString * originMutableStr = [NSMutableString stringWithFormat:@"testMutableStr"];
    
    NSLog(@"originMutableStr 的存储地址 %p", originMutableStr);
    
    NSString *copyOriginMutableStr = [originMutableStr copy];
    NSMutableString *mutableCopyOriginMutableStr = [originMutableStr mutableCopy];
    
    NSLog(@"copyOriginMutableStr 的存储地址 %p 是深拷贝", copyOriginMutableStr);
    NSLog(@"mutableCopyOriginMutableStr 的存储地址 %p 是深拷贝", mutableCopyOriginMutableStr);
    
    // 结论
    /*
     非集合类对象的 copy 操作：
     [immutableObject copy] 浅复制
     [immutableObject mutableCopy] 深复制
     [mutableObject copy] 深复制
     [mutableObject mutableCopy] 深复制
     */
}

// 这里拿数组做测试,其它集合类对象同理
- (void)collectionObjectsTest {
    NSLog(@"\n");
    
    UIView *view1 = [UIView new];
    UIView *view2 = [UIView new];
    
    NSLog(@"view1 的存储地址 %p",view1);
    
    NSArray *originNSArray = @[view1, view2];
    NSLog(@"originNSArray 的存储地址 %p", originNSArray);
    
    NSLog(@"\n");
    
    NSArray *copyOriginNSArray = [originNSArray copy];
    NSMutableArray *mutableCopyOriginNSArray = [originNSArray mutableCopy];
    
    NSLog(@"copyOriginNSArray 的存储地址 %p 是浅拷贝", copyOriginNSArray);
    NSLog(@"copyOriginNSArray view1 的存储地址 %p 与源地址相同", copyOriginNSArray[0]);
    
    NSLog(@"\n");
    
    NSLog(@"mutableCopyOriginNSArray 的存储地址 %p 是单层深拷贝", mutableCopyOriginNSArray);
    NSLog(@"mutableCopyOriginNSArray view1 的存储地址 %p 与源地址相同", mutableCopyOriginNSArray[0]);
    
    NSLog(@"\n");
    
    NSMutableArray *originNSMutableArray = [NSMutableArray arrayWithObjects:view1, view2, nil];
    
    NSLog(@"originNSMutableArray 的存储地址 %p", originNSArray);
    
    NSArray *copyOriginNSMutableArray = [originNSMutableArray copy];
    NSMutableArray *mutableCopyOriginNSMutableArray = [originNSMutableArray mutableCopy];
    
    NSLog(@"\n");
    
    NSLog(@"copyOriginNSMutableArray 的存储地址 %p 是单层深拷贝", copyOriginNSMutableArray);
    NSLog(@"copyOriginNSMutableArray view1 的存储地址 %p 与源地址相同", copyOriginNSMutableArray[0]);
    
    NSLog(@"\n");
    
    NSLog(@"mutableCopyOriginNSMutableArray 的存储地址 %p 是单层深拷贝", mutableCopyOriginNSMutableArray);
    NSLog(@"mutableCopyOriginNSMutableArray view1 的存储地址 %p 与源地址相同", mutableCopyOriginNSMutableArray[0]);
    
    // 结论
    /*
     集合类的对象进行 copy 操作
     [immutableObject copy] 浅复制（内外层对象地址一样）
     [immutableObject mutableCopy] 深复制 (单层或者完全)
     [mutableObject copy] 深复制 (单层或者完全)
     [mutableObject mutableCopy] 深复制 (单层或者完全)
     */
    
    /*
     如果在多层数组中，对第一层进行内容拷贝，其它层进行指针拷贝，这种情况是属于深复制，还是浅复制？
     
     对此，苹果官网文档有这样一句话描述:(看上面给出的集合类对象官方文档链接)
     
     This kind of copy is only capable of producing a one-level-deep copy. If you only need a one-level-deep copy...
     
     If you need a true deep copy, such as when you have an array of arrays...
     
     从文中可以看出，苹果认为这种复制不是真正的深复制，而是将其称为单层深复制(one-level-deep copy)。
     
     因此，有人对浅复制、完全深复制、单层深复制做了概念区分。
     
     当然，这些都是概念性的东西，没有必要纠结于此。
     
     以上String和Array的测试结论可以看工程copyMutableCopy.png图片与代码印证
     */
}


- (void)realDeepCopyInCollectionMethodOne {
    
    UIView *view1 = [UIView new];
    
    NSLog(@"view1 的存储地址 %p ", view1);
    
    NSArray<UIView *> *originNSArray = @[view1];
    NSLog(@"originNSArray 的存储地址 %p", originNSArray);
    
    // 多层对象深拷贝
    // **** 归档与反归档会使, 集合所有级别(层级)的可变性或不可变性与以前相同 所以这里就不试mutable (无论多少层都会深拷贝~~~厉害了卧槽)
    // 这种方法并不要求集合内对象实现NSCopying、NSMutableCopying协议(UIView默认就没实现这些协议)
    // 方法1
    NSArray *trueDeepCopyArray = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:originNSArray]];
    
    NSLog(@"trueDeepCopyArray view1 的存储地址 %p 与源地址不相同", trueDeepCopyArray[0]);
    NSLog(@"trueDeepCopyArray 的存储地址 %p 是完全深复制", trueDeepCopyArray);
    
}

- (void)realDeepCopyInCollectionMethodTwo {
    
    // 方法2
    // copyItems方法
    // 这种方法要求集合内对象遵循NSCopying协议,并实现copyWithZone方法  不然报错崩溃
    
    TestView *view2 = [TestView new];
    TestView *view3 = [TestView new];
    
    NSLog(@"view2 的存储地址 %p ", view2);
    
    // 这2种结果相同都是完全深复制
    NSMutableArray *originArray = [[NSMutableArray alloc]initWithObjects:view2, view3, nil];
    //NSArray *originArray = @[view2, view3];
    
    NSLog(@"originArray 的存储地址 %p ", originArray);
    
    NSLog(@"\n");
    
    NSArray *nsArray = [[NSArray alloc] initWithArray:originArray copyItems:YES];
    NSLog(@"nsArray view2 的存储地址 %p 与源地址不同", nsArray[0]);
    NSLog(@"nsArray 的存储地址 %p 是完全深复制", nsArray);
    
    NSLog(@"\n");
    
    NSMutableArray *nsMutableArray = [[NSMutableArray alloc]initWithArray:originArray copyItems:YES];
    
    NSLog(@"nsMutableArray view2 的存储地址 %p 与源地址不同", nsMutableArray[0]);
    NSLog(@"nsMutableArray 的存储地址 %p 是完全深复制", nsMutableArray);
    
    NSLog(@"\n");
    
    // ******* 注意事项 这种方法,下一个级别是不可变的
    NSMutableArray *testcopyItems = @[@[view2, view3].mutableCopy].mutableCopy;
    
    NSLog(@"testcopyItems 的存储地址 %p ", testcopyItems);
    
    __unused NSMutableArray *result = [[NSMutableArray alloc]initWithArray:testcopyItems copyItems:YES];
    
    //   注意原本2层都是可变数组,  进行了copyItems操作后result[0]就由可变数组变成不可变数组了
    //   执行以下代码会崩溃
    //   [result[0] addObject:@[view3]];
    
}

- (void)realDeepCopyInCollectionMethodThree {
    
   // 方法3
   // CFPropertyListCreateDeepCopy(<#CFAllocatorRef allocator#>, <#CFPropertyListRef propertyList#>, <#CFOptionFlags mutabilityOption#>)
   // 递归地创建给定属性列表的副本（如此嵌套数组字典以及最上面的容器都被复制）。
    // 先解释一下3个参数
    /*
     参数1: CFAllocatorRef allocator
     填NULL或同义词kCFAllocatorDefault
     */
    /*
     参数2: CFPropertyListRef propertyList
        源数据根属性(输入参数最外层的类型)
         CFArrayRef;
         CFMutableArrayRef;
         CFDictionaryRef;
         ....等等
     */
    /*
     参数3: CFOptionFlags mutabilityOption
         kCFPropertyListImmutable
         指定属性列表应为不可变。
         kCFPropertyListMutableContainers
         指定属性列表应具有可变容器, 但不变的叶。
         kCFPropertyListMutableContainersAndLeaves
         指定属性列表应具有可变容器和可变叶。
     */

    
    // 用途(暂时只发现在解析json用得比较多)
    
    // 温故
    // 枚举NSJSONReadingOptions
    /*
        NSJSONReadingMutableContainers = (1UL << 0),
       (解析成可变容器NSMutableDictionary与NSMutableArray的嵌套)
     
        NSJSONReadingMutableLeaves = (1UL << 1),
        (解释成不可变容器NSDictionary与NSArray的嵌套)
        网上说可以吧返回的JSON对象中字符串的值为NSMutableString, 我自己测试没发现,不知道是苹果的bug还是什么,先不管
     
        NSJSONReadingAllowFragments = (1UL << 2)
        能解释不是数组或字典开始的结构  例如 NSString *num=@"\"abcd\"";
     
     填0等于填kNilOptions在MacTypes.h定义的
     (处理方式与NSJSONReadingMutableLeaves类似,但不确定相不相同)
    */
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Test" ofType:@"json"]] options: NSJSONReadingMutableLeaves error:nil];
    
    NSArray *array = jsonDic[@"key"];
    NSDictionary *detailDic = array[0];
    
    NSLog(@"jsonDic --- %@", jsonDic.classForCoder);
    NSLog(@"array --- %@", array.classForCoder);
    NSLog(@"detailDic --- %@", detailDic.classForCoder);
   
   // 上面解析出来的jsonDic每层都是不可变的(强行例子....)
     CFBridgingRelease(CFPropertyListCreateDeepCopy(NULL, (CFDictionaryRef)jsonDic, kCFPropertyListMutableContainersAndLeaves));
    // 这里用了CFPropertyListCreateDeepCopy之后, 得到的对象每层都是可变的了
}

- (void)carDemo {
    
    EXCar *car = [[EXCar alloc]init]; // car.name is (null)
    NSLog(@"car.name is %@", car.name);
    EXCar *carCopy = [car copy]; // we can do this
    NSLog(@"carCopy type %@", carCopy.classForCoder);
    EXMutableCar *mutableCar = [car mutableCopy]; // and this
    NSLog(@"mutableCar type %@", mutableCar.classForCoder);
    mutableCar.name = @"BMW";
    car = [mutableCar copy]; // car.name is now @"BMW"
    NSLog(@"car.name is %@", car.name);
    NSLog(@"car type %@", car.classForCoder);
    EXMutableCar *anotherMutableCar = [car mutableCopy]; //anotherMutableCar.name is @"BMW"
    NSLog(@"car.name is %@", anotherMutableCar.name);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
