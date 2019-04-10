//
//  LSToolMethod.h
//  ZKSC01
//
//  Created by senlin on 15/5/27.
//  Copyright (c) 2015年 chanjing. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

typedef void(^ReturnImgBlock)(id responseObject);//请求的图片

@interface LSToolMethod : NSObject





//pragma mark- 获取30位随机字符串
+(NSString *)getRandomString;


//返回圆形头像
+(UIImage*)circleImage:(UIImage*)image withParam:(CGFloat)inset;

//获取版本号
+(NSString *)getSystermVersion;

//获取session
+(NSString *)getSession;

//获取当前时间是今年的第几周
+(NSInteger)getNumOfTheWeekWithCurrentDate;

//获取当前时间是星期几
+(NSArray *)getOrderOfTheWeekWithCurrentDate:(NSString *)date;

//获取当前时间的时、分
+(NSString *)getMinuteWithCurrentDate;

//判断2个时间的大小
+(BOOL)compareWithTimeA:(NSString *)timeA andTimeB:(NSString *)timeB;

//获取连续三天的日期（月、日）
+(NSArray *)getContinuousDateWithMonthAndDay:(NSString *)date;
//获取周一到周日对应的日期
+(NSArray *)getContinuousN_DateWithMonthAndDay:(NSString *)date;
//NSString转NSDate
//+(NSDate*)dateFromString:(NSString*)string;

//把NSDate转换为NSString(格式 2016-03-34)
+(NSString *)dateStringFromDate:(NSDate *)date;

//获取当前时间
+(NSString *)getCurrentDate;

//获取年、月、日
+(NSString *)getCurrentDateWithFormat;

//获取昨天
+(NSString *)getYestodayDate;

//获取明天
+(NSString *)getTomorowDate;


//获取选中某一周的时间
+(NSString *)getTheDateOfMultipleNum:(NSInteger)num andCurentTime:(NSString *)time;


// ************************************************************//

//判断 截取 00 的 心跳字符串
+(NSString *)judgeHaveHeartStringAndCutOfWithCachStr:(NSString *)cachStr;

//判断2个时间的的差是否大于5分钟
+(double)compareMoreThanFiveMinuteWithTimeA:(NSString *)timeA andTimeB:(NSString *)timeB;

//判断2个时间的的差是否大于1天
+(double)compareMoreThanOneDayWithTimeA:(NSString *)timeA andTimeB:(NSString *)timeB;

//判断socket是否登录成功
+(NSInteger)getSocketLoginStatusWithString:(NSString *)string;

//将相邻日期的时间配对处理
+(NSArray *)getContinuousDateArrayWithData:(NSArray *)date;

+(NSArray *)getStartEndDateArrayWithData:(NSArray *)date start:(NSString *)start end:(NSString *)end everyDay:(BOOL)everyDay;

//日期排序
+(NSArray *)makeOrderOfDate:(NSArray *)date;

// 获取上个月日期
+(NSDate *)getLastMonthDateWithCurrentDate:(NSDate *)date;

// 获取某个月日期
+(NSDate *)getDateWithCurrentDate:(NSDate *)date  addCount:(NSInteger)count;

// 获取文本的高度
+(CGFloat)getTextHeightWithString:(NSString *)str font:(UIFont *)font with:(CGFloat)with;

// 获取开始时间---结束时间---间隔天数
+(NSArray *)getDaysFrom:(NSString *)serverDate To:(NSString *)endDate;

+(NSString *)getTestIphoneDeviceID;

#pragma mark-获取服务器日期
+(void)getCurrentDateFromServer;

+ (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;

+(CGSize)getSizeWithString:(NSString *)str textFont:(UIFont *)textFont viewHeight:(CGFloat)viewHeight;

+(CGSize)getSizeWithString:(NSString *)str textFont:(UIFont *)textFont maxSize:(CGSize)maxSize;

# pragma mark--裁切成圆形
+(CAShapeLayer *)getShapeLayerWithView:(UIView *)layerView;// 圆形
+(CAShapeLayer *)getShapeLayerCornerSize:(CGSize)cornerSize layerView:(UIView *)layerView;// 圆角
+ (UIImage *)resizedImageWithName:(NSString *)name;//拉伸填充
# pragma mark--去掉字符串前后的空格
+(NSString *)getNewCharacterWithCurrentString:(NSString *)currentString;


# pragma mark--获取字符串中的数字
+(NSString *)findNumFromStr:(NSString *)fromStr;

# pragma mark--下载图片
+(void)downloadWithImageUrl:(NSString *)imageUrl backImg:(ReturnImgBlock)imgBlock;

# pragma mark-根据行间距，获取富文本
+(NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace textFont:(UIFont*)textFont;

#pragma mark 获取版本号
+(float)iOSVersion;

@end
