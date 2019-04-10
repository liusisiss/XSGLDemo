//
//  LSToolMethod.m
//  ZKSC01
//
//  Created by senlin on 15/5/27.
//  Copyright (c) 2015年 chanjing. All rights reserved.
//

#import "LSToolMethod.h"

@implementation LSToolMethod



#pragma mark- 获取随机字符串
+(NSString *)getRandomString
{
    
    NSString *str1 = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    for (int i=0; i<30; i++)
    {
        int radomNmber = random()%62;
        NSString *radomStr = [str1 substringWithRange:NSMakeRange(radomNmber, 1)];
        [resultStr appendString:radomStr];
    }
    
    return resultStr;
}

#pragma mark-获取版本号
+(NSString *)getSystermVersion
{
    NSString *systermvesion = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"];

    return systermvesion;
}
#pragma mark- 返回圆形头像
+(UIImage*)circleImage:(UIImage*)image withParam:(CGFloat)inset
{
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGRect rect=CGRectMake(inset, inset, image.size.width-inset*2.0f, image.size.height-inset*2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimage=UIGraphicsGetImageFromCurrentImageContext();
    
    return newimage;
    
}

#pragma mark-获取session
+(NSString *)getSession
{
    NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
    NSString *session = [defaults objectForKey:@"session"];
    return session;

}

//获取当前时间是今年的第几周
+(NSInteger)getNumOfTheWeekWithCurrentDate
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps;
    // 周几和星期几获得
    comps = [calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
                        fromDate:date];
    NSInteger week = [calendar ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSYearCalendarUnit forDate:date]; // 今年的第几周
    return week;
}

//获取当前时间是星期几
+(NSArray *)getOrderOfTheWeekWithCurrentDate:(NSString *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    NSDate *currentDate = [dateFormatter dateFromString:date];//获取当前时间，日期
    NSDate *yesterdayDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([currentDate timeIntervalSinceReferenceDate]-24*60*60)];
    NSDate *tomorrowDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([currentDate timeIntervalSinceReferenceDate]+24*60*60)];

    
    NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
    [weekFormatter setDateFormat:@"EEEE"];
    
     NSString *yesterdayString = [weekFormatter stringFromDate:yesterdayDate];
    NSString *currentString = [weekFormatter stringFromDate:currentDate];
    NSString *tomorrowString = [weekFormatter stringFromDate:tomorrowDate];
    
    //将--星期--转换为－－－－周
    yesterdayString = [yesterdayString stringByReplacingOccurrencesOfString:@"星期" withString:@"周"];
    currentString = [currentString stringByReplacingOccurrencesOfString:@"星期" withString:@"周"];
    tomorrowString = [tomorrowString stringByReplacingOccurrencesOfString:@"星期" withString:@"周"];

    NSArray *resultArray = [NSArray arrayWithObjects:yesterdayString,currentString,tomorrowString, nil];
    return resultArray;
}

//获取当前时间的时、分
+(NSString *)getMinuteWithCurrentDate;
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm:ss SS"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSString *subString = [dateString substringWithRange:NSMakeRange(11, 5)];
    return subString;
}
//判断2个时间的大小 Ascending----上升
+(BOOL)compareWithTimeA:(NSString *)timeA andTimeB:(NSString *)timeB
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *dateA = [dateFormatter dateFromString:timeA];
    NSDate *dateB = [dateFormatter dateFromString:timeB];
    
    
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedAscending) return NO;
    else return YES;
}
//获取连续三天的日期（月、日）
+(NSArray *)getContinuousDateWithMonthAndDay:(NSString *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *currentDate = [dateFormatter dateFromString:date];//获取当前时间，日期
    NSDate *yesterdayDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([currentDate timeIntervalSinceReferenceDate]-24*60*60)];
    NSDate *tomorrowDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([currentDate timeIntervalSinceReferenceDate]+24*60*60)];
    
    NSString *yesterdayString = [dateFormatter stringFromDate:yesterdayDate];
//    NSString *yesterdayStr = [yesterdayString substringFromIndex:5];
    
    NSString *currentString = [dateFormatter stringFromDate:currentDate];
//    NSString *currentStr = [currentString substringFromIndex:5];
    
    NSString *tomorrowString = [dateFormatter stringFromDate:tomorrowDate];
//    NSString *tomorrowStr = [tomorrowString substringFromIndex:5];
    
    NSArray *resultArray = [NSArray arrayWithObjects:yesterdayString,currentString,tomorrowString, nil];
    return resultArray;

}
//获取周一到周日对应的日期
+(NSArray *)getContinuousN_DateWithMonthAndDay:(NSString *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSMutableArray *resultArray = [NSMutableArray new];
     NSDate *currentDate = [dateFormatter dateFromString:date];//获取当前时间
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSDayCalendarUnit fromDate:currentDate];
    
    // 1(星期天) 2(星期二) 3(星期三) 4(星期四) 5(星期五) 6(星期六) 7(星期天)
    NSInteger weekDay = [comp weekday];
    // 得到几号
    NSInteger day = [comp day];
    
    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff;
    if (weekDay == 1) firstDiff = 1;
    else firstDiff = [calendar firstWeekday] - weekDay;
    
    NSDateComponents *firstDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate];
    [firstDayComp setDay:day + firstDiff];
    
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
    for (NSInteger i=1; i<8; i++)
    {
        NSDate *tomorrowDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([firstDayOfWeek timeIntervalSinceReferenceDate]+i*24*60*60)];
        NSString *tomorrowString = [dateFormatter stringFromDate:tomorrowDate];

        [resultArray addObject:tomorrowString];
    }
    return resultArray;
}

//NSDate转NSString
+(NSString*)stringFromDate:(NSDate*)date
{
    //用于格式化NSDate对象
    NSDateFormatter*dateFormatter=[[NSDateFormatter alloc]init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:sszzz"];
    //NSDate转NSString
    NSString *currentDateString=[dateFormatter stringFromDate:date];
    //输出currentDateString
    return currentDateString;
}
#pragma mark 把NSDate转换为NSString(格式 2016-03-34)
+(NSString *)dateStringFromDate:(NSDate *)date
{
    NSString *dateString = [self stringFromDate:date];
    NSArray *dateArray = [dateString componentsSeparatedByString:@" "];
    NSString *currentDateString = [dateArray firstObject];
    //输出currentDateString
    return currentDateString;
}
//获取当前时间
+(NSString *)getCurrentDate
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}

//获取年、月、日
+(NSString *)getCurrentDateWithFormat
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;

}

//获取昨天
+(NSString *)getYestodayDate
{
    NSDate *yesterdayDate = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60)];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *yesterdayString = [dateFormatter stringFromDate:yesterdayDate];
    return yesterdayString;
}

//获取明天
+(NSString *)getTomorowDate
{
    NSDate *tomorrowDate = [NSDate dateWithTimeIntervalSinceNow:(24*60*60)];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *tomorowString = [dateFormatter stringFromDate:tomorrowDate];
    return tomorowString;
}
//获取选中某一周的时间
+(NSString *)getTheDateOfMultipleNum:(NSInteger)num andCurentTime:(NSString *)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *currentDate = [dateFormatter dateFromString:time];
     NSDate *selectDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([currentDate timeIntervalSinceReferenceDate]+num*7*24*60*60)];
    NSString *selectString = [dateFormatter stringFromDate:selectDate];
    return selectString;
}

//判断 截取 00 的 心跳字符串
+(NSString *)judgeHaveHeartStringAndCutOfWithCachStr:(NSString *)cachStr
{
    NSString *twoHeadStr = nil;
    NSString *resultStr = cachStr;

    twoHeadStr = [cachStr substringToIndex:1];
    
    while ([twoHeadStr isEqualToString:@"00"])
    {
        resultStr = [resultStr substringFromIndex:1];
        if ([resultStr length]>2)
        {
            twoHeadStr = [resultStr substringToIndex:1];
        }
        else
        {
            twoHeadStr = @"01";
            resultStr = nil;
        }
    }
    return resultStr;
}
//判断2个时间的的差是否大于5分钟
+(double)compareMoreThanFiveMinuteWithTimeA:(NSString *)timeA andTimeB:(NSString *)timeB
{
    double timeDistance = 0.0;

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *dateA = [dateFormatter dateFromString:timeA];
    NSDate *dateB = [dateFormatter dateFromString:timeB];
    
    
    timeDistance = [dateB timeIntervalSinceDate:dateA];
    timeDistance = fabs(timeDistance);
    return timeDistance;
}

//判断2个时间的的差是否大于1天
+(double)compareMoreThanOneDayWithTimeA:(NSString *)timeA andTimeB:(NSString *)timeB
{
    double timeDistance = 0.0;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateA = [dateFormatter dateFromString:timeA];
    NSDate *dateB = [dateFormatter dateFromString:timeB];
    
    
    timeDistance = [dateB timeIntervalSinceDate:dateA];
    timeDistance = fabs(timeDistance);
    return timeDistance;
}
//判断socket是否登录成功
+(NSInteger)getSocketLoginStatusWithString:(NSString *)string
{
    if ([string length]>2)
    {
        NSString *nextString = [string substringFromIndex:2];
        NSData *data = [nextString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSInteger  logStatus = [[dic objectForKey:@"s"] integerValue];
        return logStatus;
    }

    else return 0;
}

//将相邻日期的时间配对处理
+(NSArray *)getContinuousDateArrayWithData:(NSArray *)date
{
    // 1、先对date从小到大排序
    NSMutableArray *newDictArray = [NSMutableArray new];
    NSMutableArray *newSortArray = [NSMutableArray new];

    for (int i=0; i<[date count]; i++) {
        NSDictionary *dict = [NSDictionary dictionaryWithObject:[date objectAtIndex:i] forKey:@"selDate"];
        [newDictArray addObject:dict];
    }
    NSSortDescriptor*sorter=[[NSSortDescriptor alloc]initWithKey:@"selDate" ascending:YES];
    NSMutableArray *sortDescriptors=[[NSMutableArray alloc]initWithObjects:&sorter count:1];
    NSArray *sortArray=[newDictArray sortedArrayUsingDescriptors:sortDescriptors];
    for (int i=0; i<[sortArray count]; i++) {
        NSString *sorStr = [[sortArray objectAtIndex:i] objectForKey:@"selDate"];
        [newSortArray addObject:sorStr];
    }
    LSLog(@"sortArray=%@",sortArray);
    
    //2、获取断点
    NSString *firstDStr = [newSortArray firstObject];
   firstDStr =  [NSString stringWithFormat:@"%@ 00:00",firstDStr];

    NSMutableArray *indexArray = [NSMutableArray new];
    NSMutableArray *startArray = [NSMutableArray arrayWithObject:firstDStr];
    NSMutableArray *endArray = [NSMutableArray new];
    if ([newSortArray count] == 0) return nil;
    
    
    for (int i=0; i<[newSortArray count]-1; i++)
    {
        NSString *dateS = [newSortArray objectAtIndex:i];
        NSString *dateE = [newSortArray objectAtIndex:i+1];
        double timeDistance = [LSToolMethod compareMoreThanOneDayWithTimeA:dateS andTimeB:dateE];
        if (timeDistance>24*60*60)
        {
            [indexArray addObject:[NSString stringWithFormat:@"%d",i+1]];
            dateE = [NSString stringWithFormat:@"%@ 00:00",dateE];
            [startArray addObject:dateE];
        }
    }
   
   //3、获取、终点－－时间点
    for(int i=0;i<[indexArray count];i++)
    {
        NSString *indexStr = [indexArray objectAtIndex:i];
        NSString *beforIndex = [newSortArray objectAtIndex:[indexStr integerValue]-1];
        beforIndex = [NSString stringWithFormat:@"%@ 23:59",beforIndex];
        NSDictionary *dictT = [NSDictionary dictionaryWithObject:beforIndex forKey:[NSString stringWithFormat:@"%d",i]];
        [endArray addObject:dictT];
    }
    //最后那个日期
    NSString * lastDStr  = [newSortArray lastObject];
    lastDStr =  [NSString stringWithFormat:@"%@ 23:59",lastDStr];
    NSDictionary *dictT = [NSDictionary dictionaryWithObject:lastDStr forKey:[NSString stringWithFormat:@"%ld",[startArray count]-1]];
    [endArray addObject:dictT];


      //4、返回数组
    NSArray *resultArray = [NSArray arrayWithObjects:startArray,endArray, nil];
    return resultArray;
}
// 获取开始、结束的日期数组
+(NSArray *)getStartEndDateArrayWithData:(NSArray *)date start:(NSString *)start end:(NSString *)end everyDay:(BOOL)everyDay
{
    NSString *tempEnd = end;
    // 1、先对date从小到大排序
    NSMutableArray *startArray = [NSMutableArray new];
    NSMutableArray *endArray = [NSMutableArray new];
    NSMutableArray *newDictArray = [NSMutableArray new];
    NSMutableArray *newSortArray = [NSMutableArray new];
    
    for (int i=0; i<[date count]; i++) {
        NSDictionary *dict = [NSDictionary dictionaryWithObject:[date objectAtIndex:i] forKey:@"selDate"];
        [newDictArray addObject:dict];
    }
    NSSortDescriptor*sorter=[[NSSortDescriptor alloc]initWithKey:@"selDate" ascending:YES];
    NSMutableArray *sortDescriptors=[[NSMutableArray alloc]initWithObjects:&sorter count:1];
    NSArray *sortArray=[newDictArray sortedArrayUsingDescriptors:sortDescriptors];
    for (int i=0; i<[sortArray count]; i++) {
        NSString *sorStr = [[sortArray objectAtIndex:i] objectForKey:@"selDate"];
        [newSortArray addObject:sorStr];
    }

    
    if (everyDay)//每天同一时段
    {
        start = [NSString stringWithFormat:@"%@:00",start];
        end = [NSString stringWithFormat:@"%@:59",end];
        for (int i=0; i<[newSortArray count]; i++)
        {
            NSString *startTime = [newSortArray objectAtIndex:i];
            NSString *endTime = [newSortArray objectAtIndex:i];
            NSString *startFormat = [NSString stringWithFormat:@"%@ %@",startTime,start];
            NSString *endFormat = [NSString stringWithFormat:@"%@ %@",endTime,end];
            [startArray addObject:startFormat];
            [endArray addObject:endFormat];
        }

    }
    else
    {
        if ([newSortArray count]==1)
        {
            for (int i=0; i<[newSortArray count]; i++)
            {
                start = [NSString stringWithFormat:@"%@:00",start];
                end = [NSString stringWithFormat:@"%@:59",end];
                
                NSString *startTime = [newSortArray objectAtIndex:i];
                NSString *endTime = [newSortArray objectAtIndex:i];
                NSString *startFormat = [NSString stringWithFormat:@"%@ %@",startTime,start];
                NSString *endFormat = [NSString stringWithFormat:@"%@ %@",endTime,end];
                [startArray addObject:startFormat];
                [endArray addObject:endFormat];
            }

        }
        else
        {
            for (int i=0; i<[newSortArray count]; i++)
            {
                if (i==0)
                {
                    start = [NSString stringWithFormat:@"%@:00",start];
                    end = @"23:59:59";
                }
                else if (i==[newSortArray count]-1)
                {
                    start = @"00:00:00";
                    end = [NSString stringWithFormat:@"%@:59",tempEnd];
                }
                else
                {
                     start = @"00:00:00";
                     end = @"23:59:59";
                }
                
                NSString *startTime = [newSortArray objectAtIndex:i];
                NSString *endTime = [newSortArray objectAtIndex:i];
                NSString *startFormat = [NSString stringWithFormat:@"%@ %@",startTime,start];
                NSString *endFormat = [NSString stringWithFormat:@"%@ %@",endTime,end];
                [startArray addObject:startFormat];
                [endArray addObject:endFormat];
            }
        }
    }

    //4、返回数组
    NSArray *resultArray = [NSArray arrayWithObjects:startArray,endArray, nil];
    return resultArray;
}

// 日期排序
+(NSArray *)makeOrderOfDate:(NSArray *)date
{
    // 1、先对date从小到大排序
    NSMutableArray *newDictArray = [NSMutableArray new];
    NSMutableArray *newSortArray = [NSMutableArray new];
    
    for (int i=0; i<[date count]; i++) {
        NSDictionary *dict = [NSDictionary dictionaryWithObject:[date objectAtIndex:i] forKey:@"selDate"];
        [newDictArray addObject:dict];
    }
    NSSortDescriptor*sorter=[[NSSortDescriptor alloc]initWithKey:@"selDate" ascending:YES];
    NSMutableArray *sortDescriptors=[[NSMutableArray alloc]initWithObjects:&sorter count:1];
    NSArray *sortArray=[newDictArray sortedArrayUsingDescriptors:sortDescriptors];
    for (int i=0; i<[sortArray count]; i++)
    {
        NSString *sorStr = [[sortArray objectAtIndex:i] objectForKey:@"selDate"];
        [newSortArray addObject:sorStr];
    }
    return [newSortArray copy];
}
// 获取上个月日期
+(NSDate *)getLastMonthDateWithCurrentDate:(NSDate *)date
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *lastMonDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return lastMonDate;
}
// 获取下个月日期
+(NSDate *)getDateWithCurrentDate:(NSDate *)date  addCount:(NSInteger)count
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +count;
    NSDate *nextMonDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return nextMonDate;
}

// 获取文本的高度
+(CGFloat)getTextHeightWithString:(NSString *)str font:(UIFont *)font with:(CGFloat)with
{
    
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
    CGSize maxSize = CGSizeMake(with, 10000);
    CGRect contentRect=[str boundingRectWithSize:maxSize options:opts attributes:attributes context:nil];
    CGSize  resultSize = contentRect.size;
    return resultSize.height;
}

// 获取开始时间---结束时间---间隔天数
+(NSArray *)getDaysFrom:(NSString *)serverDate To:(NSString *)endDate
{
    NSString *startTimeFooter = [serverDate substringFromIndex:11];
    NSString *endTimeFooter = [endDate substringFromIndex:11];
    serverDate = [serverDate substringToIndex:10];
    endDate = [endDate substringToIndex:10];
    
    NSMutableArray *allDateArray = [NSMutableArray new];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate *dateA = [dateFormatter dateFromString:serverDate];
    NSDate *dateB = [dateFormatter dateFromString:endDate];
    [allDateArray addObject:dateA];

    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:dateA toDate:dateB options:0];
    
    NSInteger totalDateCount = dayComponents.day;
    for (NSInteger i=0; i<totalDateCount; i++)
    {
        NSDate *lastDate = [allDateArray lastObject];
         NSDate *nextDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([lastDate timeIntervalSinceReferenceDate]+24*60*60)];
        NSComparisonResult result = [lastDate compare:nextDate];
        if (result == NSOrderedAscending)
        {
            [allDateArray addObject:nextDate];
        }
    }
    NSMutableArray *resultDateArray = [NSMutableArray new];
    for (int i=0; i<[allDateArray count]; i++) {
        NSString *resultDateStr = [dateFormatter stringFromDate:[allDateArray objectAtIndex:i]];
        
        if (i==0)
        {
            resultDateStr = [NSString stringWithFormat:@"%@ %@-%@",resultDateStr,startTimeFooter,@"23:59"];
        }
        else if (i==[allDateArray count]-1)
        {
            resultDateStr = [NSString stringWithFormat:@"%@ %@-%@",resultDateStr,@"00:00",endTimeFooter];
        }
        else
        {
            resultDateStr = [NSString stringWithFormat:@"%@ %@-%@",resultDateStr,@"00:00",@"23:59"];
        }
        [resultDateArray addObject:resultDateStr];
        
    }
   
    return [resultDateArray copy];
}

+(NSString *)getTestIphoneDeviceID
{
    Class cls = NSClassFromString(@"UMANUtil");
    SEL deviceIDSelector = @selector(openUDIDString);
    NSString *deviceID = nil;
    if(cls && [cls respondsToSelector:deviceIDSelector]){
        deviceID = [cls performSelector:deviceIDSelector];
    }
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    NSString *testIPhoneID = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return testIPhoneID;
}

#pragma mark-获取服务器日期
+(void)getCurrentDateFromServer
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
       
        NSString *APPURL = [[NSUserDefaults standardUserDefaults] objectForKey:@"serverURL"];
        [LSHttpTool getWithURL:[NSString stringWithFormat:@"%@/zksc/front/schedule/currentdate.htm",APPURL] params:nil success:^(id responseObject) {
            
            LSLog(@"currentDict = %@",responseObject);
            NSDictionary *currentDict = (NSDictionary *)responseObject;
            NSString *serverDateStr = [currentDict objectForKey:@"current"];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *serverBackDate = [dateFormatter dateFromString:serverDateStr];
            
            NSUserDefaults *userDefault = [[NSUserDefaults alloc] init];
            [userDefault setObject:serverBackDate forKey:@"serverdate"];
            [userDefault setObject:serverDateStr forKey:@"serverdateStr"];
            [userDefault synchronize];
            
        } failure:^(NSError *error) {
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
            NSDate *currentDate = [dateFormatter dateFromString:dateString];
            
            NSUserDefaults *userDefault = [[NSUserDefaults alloc] init];
            [userDefault setObject:currentDate forKey:@"serverdate"];
            [userDefault setObject:dateString forKey:@"serverdateStr"];
            [userDefault synchronize];
            
        }];
    });
    
}

+ (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

+(CGSize)getSizeWithString:(NSString *)str textFont:(UIFont *)textFont viewHeight:(CGFloat)viewHeight
{
    if (![str isKindOfClass:[NSString class]]) return CGSizeZero;
    CGSize size = CGSizeMake(MAXFLOAT, viewHeight);
    CGSize buttonSize = [str boundingRectWithSize:size
                                                    options:NSStringDrawingTruncatesLastVisibleLine  | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                 attributes:@{ NSFontAttributeName:textFont}
                                                    context:nil].size;
    return buttonSize;
}

+(CGSize)getSizeWithString:(NSString *)str textFont:(UIFont *)textFont maxSize:(CGSize)maxSize{
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    NSDictionary *attributes = @{ NSFontAttributeName : textFont, NSParagraphStyleAttributeName : style };
    CGRect contentRect=[str boundingRectWithSize:maxSize options:opts attributes:attributes context:nil];
    CGSize  resultSize = contentRect.size;
    return resultSize;
    
}
# pragma mark--裁切成圆形
+(CAShapeLayer *)getShapeLayerWithView:(UIView *)layerView
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:layerView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:layerView.bounds.size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = layerView.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    return maskLayer;
}
+(CAShapeLayer *)getShapeLayerCornerSize:(CGSize)cornerSize layerView:(UIView *)layerView // 圆角
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:layerView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:cornerSize];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = layerView.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    return maskLayer;
}
#pragma mark-拉伸填充图片
+ (UIImage *)resizedImageWithName:(NSString *)name
{
    UIImage *tempImg = [UIImage imageNamed:name];
    UIImage *resultImage = [tempImg resizableImageWithCapInsets:UIEdgeInsetsMake(6, 6, 6, 6) resizingMode:UIImageResizingModeStretch];
    
    return resultImage;
}
# pragma mark--去掉字符串前后的空格
+(NSString *)getNewCharacterWithCurrentString:(NSString *)currentString
{
    NSString * newstr = [currentString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return newstr;
}

# pragma mark--获取字符串中的数字
+(NSString *)findNumFromStr:(NSString *)fromStr
{
    NSString *originalString = fromStr;
    
    // Intermediate
    NSMutableString *numberString = [[NSMutableString alloc] init];
    NSString *tempStr;
    NSScanner *scanner = [NSScanner scannerWithString:originalString];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    while (![scanner isAtEnd]) {
        // Throw away characters before the first number.
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        
        // Collect numbers.
        [scanner scanCharactersFromSet:numbers intoString:&tempStr];
        [numberString appendString:tempStr];
        tempStr = @"";
    }
    
    return [numberString copy];
}
+(void)downloadWithImageUrl:(NSString *)imageUrl backImg:(ReturnImgBlock)imgBlock
{
    //选择组合：全局队列异步执行 -> 由子线程下载图片
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_async(globalQueue, ^{
        
        
        NSURL *imageURL = [NSURL URLWithString:imageUrl];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:imageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //返回数据
            if(image) imgBlock(image);
            else imgBlock(nil);
        });
    });
}

# pragma mark-根据行间距，获取富文本
+(NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace textFont:(UIFont*)textFont
{
    NSMutableAttributedString *attributedString;
    if (![SSLToolMethod isBlankString:string]) {
        attributedString = [[NSMutableAttributedString alloc] initWithString:string];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = lineSpace; // 调整行间距
        NSRange range = NSMakeRange(0, [string length]);
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
        [attributedString addAttribute:NSFontAttributeName value:textFont range:range];
    }   

    return attributedString;
}

#pragma mark 获取版本号
+(float)iOSVersion {
    static float version = 0.f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        version = [[[UIDevice currentDevice] systemVersion] floatValue];
    });
    return version;
}

@end
