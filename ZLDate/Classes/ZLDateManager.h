//
//  ZLDateManager.h
//  ZLDate
//
//  Created by wangzelong on 2020/2/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *DateFormatYMDHMS = @"yyyy-MM-dd HH:mm:ss";

static NSString *DateFormatYMDHM = @"yyyy-MM-dd HH:mm";

static NSString *DateFormatMDHM = @"MM-dd HH:mm";

static NSString *DateFormatYMD = @"yyyy-MM-dd";

static NSString *DateFormatYMD1 = @"yyyyMMdd";

static NSString *DateFormatYMD2 = @"yyyy/MM/dd";

static NSString *DateFormatMD = @"MM-dd";

@interface ZLDateManager : NSObject

/// 时间样式
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

+ (ZLDateManager *)shareManager;

/**
 *  获取当前时间，例如：20150730
 *
 *  @return 当前时间
 */
- (NSString *)getCurrentDate;

/**
 *  get date by dateFormat MM-dd, for example 07-06
 */
- (NSString *)getDateWithTimeInterval:(NSInteger)timeInterval formatSytle:(NSString *)formatSytle;

/**
 *  格式化时间戳
 *
 *  @param date        NSDate格式
 *  @param formatSytle 格式 eg: yy/MM/dd
 *
 *  @return NSString
 */
- (NSString *)getDateWithNSDate:(NSDate *)date formatSytle:(NSString *)formatSytle;

/**
 *  根据string获取nsdate
 *
 *  @param timeString  时间string
 *  @param formatSytle 格式 eg: yyMMdd
 *
 *  @return NSDate
 */
- (NSDate *)getDateWithString:(NSString *)timeString formatSytle:(NSString *)formatSytle;

/**
 *  获取倒计时剩余的时间
 *
 *  @param amountTimeInterval 倒计时多长时间, eg:倒计时8小时 给 8*60*60
 *  @param startTime    时间戳 1970
 *  @param formatSytle 格式 eg: yyMMdd
 *
 *  @return 返回值为 倒计时剩余多少秒, 如果倒计时已过,返回 -1
 */
- (NSTimeInterval)getCountdownTimeWithAmountTimeInterval:(NSTimeInterval)amountTimeInterval
                                               startTime:(NSTimeInterval)startTime
                                             formatSytle:(NSString *)formatSytle;

/**
 *  获取某个时间距离当前时间的时间间隔
 */
- (NSTimeInterval)getDifferNowTime:(NSString *)time;

/**
 *  获取当前时间之后的12小时是今天/明天
 *
 *  @param dateString xxx
 *  @param formatSytle 格式 eg: yyMMdd
 *
 *  @return 返回值为 今天/明天 HH:mm
 */
- (NSString *)getAfterNowTime:(NSString *)dateString withFormateStyle:(NSString *)formatSytle;

/**
 /////  和当前时间比较
 ////   1）1分钟以内   显示     :    刚刚
 ////   2）1小时以内   显示     :    X分钟前
 ///    3）今天或者昨天 显示     :    今天 09:30  昨天 09:30
 ///    4) 今年       显示     :    09月12日
 ///    5) 大于本年    显示     :    2013/09/09
 **/
- (NSString *)formateDate:(NSString *)dateString withFormateStyle:(NSString *)formatSytle;

@end

NS_ASSUME_NONNULL_END
