//
//  ZLDateManager.m
//  ZLDate
//
//  Created by wangzelong on 2020/2/14.
//

#import "ZLDateManager.h"

static ZLDateManager *share = nil;

@implementation ZLDateManager


+ (ZLDateManager *)shareManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[ZLDateManager alloc] init];
    });
    return share;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        // 默认formatter样式
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        self.dateFormatter = formatter;
    }
    return self;
}

/**
 *  获取当前时间，例如：20150730
 *
 *  @return 当前时间
 */
- (NSString *)getCurrentDate {
    NSDate *date = [NSDate date];
    [self.dateFormatter setDateFormat:DateFormatYMD1];
    NSString *strDate = [self.dateFormatter stringFromDate:date];
    return strDate;
}

- (NSString *)getDateWithTimeInterval:(NSInteger)timeInterval formatSytle:(NSString *)formatSytle {
    if (!formatSytle) {
        formatSytle = DateFormatMD;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    [self.dateFormatter setDateFormat:formatSytle];
    NSString *resultStr=[self.dateFormatter stringFromDate:date];
    return resultStr;
}

- (NSString *)getDateWithNSDate:(NSDate *)date formatSytle:(NSString *)formatSytle {
    if (!formatSytle) {
        formatSytle = DateFormatYMD2;
    }
    [self.dateFormatter setDateFormat:formatSytle];
    NSString *resultStr = [self.dateFormatter stringFromDate:date];
    return resultStr;
}

- (NSDate *)getDateWithString:(NSString *)timeString formatSytle:(NSString *)formatSytle {
    if (!formatSytle) {
        formatSytle = DateFormatYMD2;
    }
    [self.dateFormatter setDateFormat:formatSytle];
    NSDate *date = [self.dateFormatter dateFromString:timeString];
    
    return date;
}

- (NSTimeInterval)getCountdownTimeWithAmountTimeInterval:(NSTimeInterval)amountTimeInterval
                                               startTime:(NSTimeInterval)startTime
                                             formatSytle:(NSString *)formatSytle {
    
    self.dateFormatter.dateFormat = formatSytle;
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:startTime];
    
    NSTimeInterval haveTime = amountTimeInterval + [startDate timeIntervalSinceNow];
    
    if (haveTime < 0) {
        haveTime = -1;
    }
    return haveTime;
}

- (NSTimeInterval)getDifferNowTime:(NSString *)time {
    NSDate * nowDate = [NSDate date];
    NSDate * needFormatDate = [NSDate dateWithTimeIntervalSince1970:[time integerValue]];
    NSTimeInterval timeInterval = [needFormatDate timeIntervalSinceDate:nowDate];
    return timeInterval;
}

- (NSString *)getAfterNowTime:(NSString *)dateString withFormateStyle:(NSString *)formatSytle {
    [self.dateFormatter setDateFormat:formatSytle];
    NSDate * nowDate = [NSDate date];
    NSDate * needFormatDate = [NSDate dateWithTimeIntervalSince1970:[dateString integerValue]];
    NSTimeInterval time = [self getDifferNowTime:dateString];
    NSString *dateStr = @"";
    if (time <= 60 * 60 * 24) {   //// 在两天内的
        NSString * need_yMd = [self.dateFormatter stringFromDate:needFormatDate];
        NSString *now_yMd = [self.dateFormatter stringFromDate:nowDate];
        
        [self.dateFormatter setDateFormat:@"HH:mm"];
        if ([need_yMd isEqualToString:now_yMd]) {
            //// 在同一天
            dateStr = [NSString stringWithFormat:@"今天 %@",[self.dateFormatter stringFromDate:needFormatDate]];
        } else{
            ////  明天
            dateStr = [NSString stringWithFormat:@"明天 %@",[self.dateFormatter stringFromDate:needFormatDate]];
        }
    }
    return dateStr;
}

- (NSString *)formateDate:(NSString *)dateString withFormateStyle:(NSString *)formatSytle {
    
    @try {
        [self.dateFormatter setDateFormat:formatSytle];
        NSDate * nowDate = [NSDate date];
        NSDate * needFormatDate = [NSDate dateWithTimeIntervalSince1970:[dateString integerValue]];
        NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
        
        //// 再然后，把间隔的秒数折算成天数和小时数：
        NSString *dateStr = @"";
        
        if (time <= 60) {  //// 1分钟以内的
            dateStr = @"刚刚";
        } else if (time <= 60 * 60) {  ////  一个小时以内的
            
            int mins = time / 60;
            dateStr = [NSString stringWithFormat:@"%d分钟前",mins];
            
        } else if (time <= 60 * 60 * 24) {   //// 在两天内的
            NSString * need_yMd = [self.dateFormatter stringFromDate:needFormatDate];
            NSString *now_yMd = [self.dateFormatter stringFromDate:nowDate];
            
            [self.dateFormatter setDateFormat:@"HH:mm"];
            if ([need_yMd isEqualToString:now_yMd]) {
                //// 在同一天
                dateStr = [NSString stringWithFormat:@"今天 %@",[self.dateFormatter stringFromDate:needFormatDate]];
            } else{
                ////  昨天
                dateStr = [NSString stringWithFormat:@"昨天 %@",[self.dateFormatter stringFromDate:needFormatDate]];
            }
        } else {
            
            [self.dateFormatter setDateFormat:@"yyyy"];
            NSString * yearStr = [self.dateFormatter stringFromDate:needFormatDate];
            NSString *nowYear = [self.dateFormatter stringFromDate:nowDate];
            
            if ([yearStr isEqualToString:nowYear]) {
                ////  在同一年
                [self.dateFormatter setDateFormat:@"MM月dd日"];
                dateStr = [self.dateFormatter stringFromDate:needFormatDate];
            } else {
                [self.dateFormatter setDateFormat:@"yyyy/MM/dd"];
                dateStr = [self.dateFormatter stringFromDate:needFormatDate];
            }
        }
        return dateStr;
    }
    @catch (NSException *exception) {
        return @"";
    }
}


@end

