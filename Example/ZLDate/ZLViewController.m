//
//  ZLViewController.m
//  ZLDate
//
//  Created by xiaoyaoknight on 02/14/2020.
//  Copyright (c) 2020 xiaoyaoknight. All rights reserved.
//

#import "ZLViewController.h"
#import <ZLDate/ZLDateManager.h>
#import <ZLDate/NSDate+Tools.h>

@interface ZLViewController ()

@end

@implementation ZLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 获取当前时间，并转化成yyyy-MM-dd HH:mm:ss 格式
    [self test2];
    
    [self test3];
        
    [self test4];
    
}

- (void)test1 {
    NSDate *date1 = [NSDate date];//获得当前日期
    NSLog(@"%@",date1); //结果：2014-07-16 07:25:28 +0000
    
    NSDate *date2=[NSDate dateWithTimeIntervalSinceNow:100];//在当前日期的基础上加上100秒，注意在ObjC中多数时间单位都是秒
    NSLog(@"%@",date2); //结果：2014-07-16 07:27:08 +0000
    
    NSDate *date3 = [NSDate distantFuture];//随机获取一个将来的日期
    NSLog(@"%@",date3); //结果：4001-01-01 00:00:00 +0000
    
    NSTimeInterval time=[date2 timeIntervalSinceDate:date1];//日期之差,返回单位为秒
    NSLog(@"%f",time); //结果：100.008833
    
    NSDate *date5=[date1 earlierDate:date3];//返回比较早的日期
    NSLog(@"%@",date5); //结果：2014-07-16 07:25:28 +0000
    
    //日期格式化
    NSDateFormatter *formater1=[[NSDateFormatter alloc]init];
    formater1.dateFormat=@"yy-MM-dd HH:mm:ss";
    NSString *datestr1=[formater1 stringFromDate:date1];
    NSLog(@"%@",datestr1); //结果：14-07-16 15:25:28
    //字符串转化为日期
    NSDate *date6=[formater1 dateFromString:@"14-02-14 11:07:16"];
    NSLog(@"%@",date6); //结果：2014-02-14 03:07:16 +0000
}

/**
 *  获取当前时间，并转化成yyyy-MM-dd HH:mm:ss 格式
 */
- (void)test2 {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //24小时制：yyyy-MM-dd HH:mm:ss  12小时制：yyyy-MM-dd hh:mm:ss
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *nowDateString = [dateFormatter stringFromDate:date];
    NSLog(@"%@", nowDateString);
}

/**
 *  获取当前时间的时间戳
 */
- (void)test3 {
    NSDate *date = [NSDate date];
    //单位：秒
    NSTimeInterval interval = [date timeIntervalSince1970];
    
    NSLog(@"%f", interval);
}

/**
 *  时间字符串转时间戳
 */
- (void)test4 {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //24小时制：yyyy-MM-dd HH:mm:ss  12小时制：yyyy-MM-dd hh:mm:ss
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [dateFormatter dateFromString:@"2018-06-04 14:41:15"];
    NSTimeInterval interval = [date timeIntervalSince1970];
    
    NSLog(@"%f", interval);
}

@end
