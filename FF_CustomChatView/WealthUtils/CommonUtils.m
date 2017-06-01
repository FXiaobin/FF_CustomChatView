//
//  CommonUtils.m
//  dfds
//
//  Created by fanxiaobin on 17/3/7.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "CommonUtils.h"
#import <CoreText/CoreText.h>

#define HISTORY_SEARCH_STRING   @"historySearchString"
#define MAIN_FONT(fontSize)     [UIFont systemFontOfSize:fontSize]
#define MAIN_COLOR              [UIColor orangeColor]

@implementation CommonUtils



+(CommonUtils *)manager{
    return [[CommonUtils alloc] init];
}

/*
+ (void)goUserLoginWithTarget:(UIViewController *)target{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [target presentViewController:loginVC animated:YES completion:nil];
}*/

#pragma mark --- 添加 边框 圆角 点击事件
+ (void)cornerRadius:(CGFloat)cornerRadius forView:(UIView *)aview{
    
    aview.clipsToBounds = YES;
    aview.layer.cornerRadius = cornerRadius;
}

+ (void)borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor forView:(UIView *)aview{
    aview.layer.borderColor = borderColor.CGColor;
    aview.layer.borderWidth = borderWidth;
}

+ (void)addTarget:(id)target selector:(SEL)selector forView:(UIView *)aView{
    aView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [aView addGestureRecognizer:tap];
}


#pragma mark --- 属性字符串
+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)text color:(UIColor *)color fontSize:(CGFloat)fontSize range:(NSRange)range{
    
    NSMutableAttributedString *attribitedStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attribitedStr addAttributes:@{NSForegroundColorAttributeName : color, NSFontAttributeName : kFont(kSCALE(fontSize))} range:range];
    
    return attribitedStr;
}

+ (NSAttributedString *)paragraphStyleWithContent:(NSString *)content lineSpacing:(CGFloat)lineSpacing{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = lineSpacing;
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSParagraphStyleAttributeName : paragraph}];
    return attributedStr;
}

+ (NSAttributedString *)paragraphStyleWithContent:(NSString *)content lineSpacing:(CGFloat)lineSpacing lineHeight:(CGFloat)lineHeight{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = lineSpacing;
    paragraph.minimumLineHeight = lineHeight;
    paragraph.maximumLineHeight = lineHeight;
    paragraph.lineHeightMultiple = lineHeight;
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSParagraphStyleAttributeName : paragraph}];
    return attributedStr;
}

+ (CGSize)sizeWithContent:(NSString *)content attributed:(NSDictionary *)attributedDic limitedSize:(CGSize)limitSize{
    
    CGRect rect = [content boundingRectWithSize:limitSize
                                        options:NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading
                                     attributes:attributedDic context:nil];
    
    return rect.size;
}


#pragma mark --- 导航条颜色修改
+ (void)navigationBarSetWithTargetColor:(UIColor *)mainColor{
    
    //UIColor *mainColor = MAIN_COLOR;
    UIColor *tintColor = [UIColor whiteColor];
    NSString *indicatorImage = @"nav_back_white";
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont fontWithName:@"PingFang SC" size:17]}];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    [[UINavigationBar appearance] setTintColor:tintColor ];
    [[UINavigationBar appearance] setBarTintColor:mainColor];
    
    [UINavigationBar appearance].backIndicatorImage = [UIImage imageNamed:indicatorImage];
    [UINavigationBar appearance].backIndicatorTransitionMaskImage = [UIImage imageNamed:indicatorImage];
    
//    [targetVC.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:mainColor] forBarMetrics:UIBarMetricsDefault];
//    [targetVC.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:mainColor]];
}

#pragma mark --- 保存图片至相册
- (void)saveImageToPhotoLibraryWithImage:(UIImage *)image completeBlock:(resultBlock)block{
    self.commonUtilsBlock = block;
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    if (self.commonUtilsBlock) {
        self.commonUtilsBlock(error);
    }
}

#pragma mark ---  添加的 常用的
#pragma mark --- NSDate

#define Date_MINUTE	60
#define Date_HOUR		3600
#define Date_DAY		86400
#define Date_WEEK		604800
#define Date_YEAR		31556926

+ (NSString *)timeStringGetWithDate:(NSDate *)date{
    NSString *timeStr;
    NSDate *todayDate = [NSDate date];
    NSTimeInterval seconds = [todayDate timeIntervalSinceDate:date];
    
    if (seconds < Date_MINUTE) {
        timeStr = [NSString stringWithFormat:@"%d秒前",(int)seconds];
    }else if (seconds < Date_HOUR){
        seconds /= Date_MINUTE;
        timeStr = [NSString stringWithFormat:@"%d分钟前",(int)seconds];
    }else if (seconds < Date_DAY){
        seconds /= Date_HOUR;
        timeStr = [NSString stringWithFormat:@"%d小时前",(int)seconds];
    }else if (seconds < Date_WEEK){
        seconds /= Date_DAY;
        timeStr = [NSString stringWithFormat:@"%d天前",(int)seconds];
    }else if (seconds < Date_YEAR){
        seconds /= Date_WEEK;
        timeStr = [NSString stringWithFormat:@"%d周前",(int)seconds];
    }else{
        seconds /= Date_YEAR;
        timeStr = [NSString stringWithFormat:@"%d年前",(int)seconds];
    }
    return timeStr;
}

//某个日期对应的时间戳，精确到毫秒
+ (NSTimeInterval)timeIntervalNowTo1970WithDate:(NSDate *)date{
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    return timeInterval * 1000.0;
}

// dateFormatter字符串yyyyMMddTHHmmss，记住你中间有个T
+ (NSDate *)dateWithTimeDateFormatter:(NSString *)dateStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 设置为UTC时区
    // 这里如果不设置为UTC时区，会把要转换的时间字符串定为当前时区的时间（东八区）转换为UTC时区的时间
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    //[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    
    NSDate *date = [formatter dateFromString:dateStr];
    
    return date;
}

/**
 *  日期格式化
 *
 *  @param date          某个日期
 *  @param dateFormatter 要显示的格式 常用的有：YYYY-MM-dd HH:mm:ss  YYYY/MM/dd HH:mm:ss 和 yyyyMMddHHmmssSSS
 *
 *  @return 某个格式的日期字符串
 */
+ (NSString *)timeFormatterStringWithDate:(NSDate *)date dateFormatter:(NSString *)dateFormatter{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormatter;
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *timeStr = [formatter stringFromDate:date];
    
    return timeStr;
}

//将时间戳格式化成字符串
+ (NSString *)timeFormatterStringWithTimestamp:(NSTimeInterval)timestamp dateFormatter:(NSString *)dateFormatter{
    timestamp += 8 * 60 * 60;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *timeFormatterStr = [self timeFormatterStringWithDate:date dateFormatter:dateFormatter];
    return timeFormatterStr;
}

+ (NSString *)crazyTimeToEndDate:(NSDate *)endDate{
    NSDate *relNowDate = [NSDate dateWithTimeIntervalSinceNow:8 * 3600];
    
    NSCalendar* chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSCalendarIdentifierGregorian ];
    NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *cps = [chineseClendar components:unitFlags fromDate:relNowDate toDate: endDate options:0];
    NSInteger Hour = [cps hour];
    NSInteger Min = [cps minute];
    NSInteger Sec = [cps second];
    //NSInteger Day = [cps day];
    //NSInteger nanosecond = [cps nanosecond];
    //NSInteger Mon = [cps month];
    //NSInteger Year = [cps year];
    //NSLog( @" From Now to %@, diff: Years: %ld  Months: %ld, Days; %ld, Hours: %ld, Mins:%ld, sec:%ld",[nowDate description], (long)Year, (long)Mon, (long)Day, (long)Hour, (long)Min,(long)Sec );
  
    
    
    NSString *countdown = [NSString stringWithFormat:@"%02zi:%02zi:%02zi",Hour,Min, Sec];
    if (Sec < 0) {
        countdown=[NSString stringWithFormat:@"00:00:00"];
    }
    return countdown;
    
}

+ (NSString*)remainingTimeToEndDate:(NSDate *)endDate text:(NSString *)text{
    //得到当前时间
    //NSDate *nowDate = [NSDate date];
    NSDate *relNowDate = [NSDate dateWithTimeIntervalSinceNow:8 * 3600];
   
    NSCalendar* chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSCalendarIdentifierGregorian ];
    NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *cps = [chineseClendar components:unitFlags fromDate:relNowDate toDate: endDate options:0];
    NSInteger Hour = [cps hour];
    NSInteger Min = [cps minute];
    NSInteger Sec = [cps second];
    NSInteger Day = [cps day];
    //NSInteger Mon = [cps month];
    //NSInteger Year = [cps year];
    //NSLog( @" From Now to %@, diff: Years: %ld  Months: %ld, Days; %ld, Hours: %ld, Mins:%ld, sec:%ld",[nowDate description], (long)Year, (long)Mon, (long)Day, (long)Hour, (long)Min,(long)Sec );
    
    NSString *countdown = [NSString stringWithFormat:@"%@ %02zi天 %02zi:%02zi:%02zi", text,Day,Hour, Min, Sec];
    if (Sec < 0) {
        countdown=[NSString stringWithFormat:@"00天 00:00:00"];
    }
    return countdown;
}

+ (NSInteger)isSalingWithDate:(NSDate *)date{
    
    //NSDate *nowDate = [NSDate date];
    NSDate *relNowDate = [NSDate dateWithTimeIntervalSinceNow:8 * 3600];
    
    NSCalendar* chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSCalendarIdentifierGregorian ];
    NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *cps = [chineseClendar components:unitFlags fromDate:date toDate:relNowDate options:0];
   
    NSInteger Sec = [cps second];
  
    return Sec;
}


#pragma mark --- 搜索
+ (void)saveSearchString:(NSString *)searchString{
    
    NSArray *historyArr = [self fetchHistorySearchResultArray];
    
    NSMutableArray *array = [NSMutableArray array];
    if (historyArr.count ) {
        [array addObjectsFromArray:historyArr];
    }
    [array addObject:searchString];
    
    NSSet *set = [NSSet setWithArray:array];
    NSArray *hArray = [NSArray arrayWithArray:set.allObjects];
    
    NSData *historyData = [NSKeyedArchiver archivedDataWithRootObject:hArray];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:historyData forKey:HISTORY_SEARCH_STRING];
    [ud synchronize];
}

+ (NSArray *)fetchHistorySearchResultArray{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *historyData = [ud objectForKey:HISTORY_SEARCH_STRING];
    NSArray *historyArr = [NSKeyedUnarchiver unarchiveObjectWithData:historyData];
    
    return historyArr;
}

+ (void)clearAllHistorySearchString{
    
    NSArray *historyArr = @[];
    NSData *historyData = [NSKeyedArchiver archivedDataWithRootObject:historyArr];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:historyData forKey:HISTORY_SEARCH_STRING];
    [ud synchronize];
}

/*
 转场类型type：
 
 Fade = 1,                   //淡入淡出
 Push,                       //推挤
 Reveal,                     //揭开
 MoveIn,                     //覆盖
 Cube,                       //立方体
 SuckEffect,                 //吮吸（水滴）
 OglFlip,                    //翻转
 RippleEffect,               //波纹
 （默认以父类为参照，所以一般我们使用一个和子控件一样大的父控件来修改这个效果）
 PageCurl,                   //翻页
 PageUnCurl,                 //反翻页
 CameraIrisHollowOpen,       //开镜头
 CameraIrisHollowClose,      //关镜头
 CurlDown,                   //下翻页
 CurlUp,                     //上翻页
 FlipFromLeft,               //左翻转
 FlipFromRight,              //右翻转

 转场子类型subtype：
 
 kCAMediaTimingFunctionLinear            线性即匀速
 kCAMediaTimingFunctionEaseIn            先慢后快
 kCAMediaTimingFunctionEaseOut           先快后慢
 kCAMediaTimingFunctionEaseInEaseOut     先慢后快再慢
 kCAMediaTimingFunctionDefault           实际效果是动画中间比较快
 
 */
#pragma mark ---  转场动画
+ (void)transationAnimationForViewWithType:(NSString *)type subType:(NSString *)subType forView:(UIView *)aView{
    
    CATransition *transtion = [CATransition animation];
    //[transtion setStartProgress:0.2];
    //[transtion setEndProgress:0.8];
    transtion.duration = 1.0;
    [transtion setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [transtion setType:type];
    
    //kCATransitionFromTop
    [transtion setSubtype:subType];
    
    [aView.layer addAnimation:transtion forKey:@"transtionKey"];
}

#pragma mark --- 核心动画
/// 左右抖动
+ (void)shakeAnimationWithAnimationView:(UIView *)animationView{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];

    [animation setDuration:0.1];
    //抖动角度
    animation.fromValue = @(-M_1_PI/2);
    animation.toValue = @(M_1_PI/2);
    //重复次数，2次
    animation.repeatCount = 2;
    //恢复原样
    animation.autoreverses = YES;
    //锚点设置为图片中心，绕中心抖动
    animationView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    [animationView.layer addAnimation:animation forKey:@"rotation"];
}

/// 点赞放大缩小
+ (void)scaleAnimationWithAnimationView:(UIView *)animationView{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@1.5 ,@0.8, @1.0,@1.2,@1.0];
    animation.duration = 0.5;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:@"transform.scale"];
}

+ (void)rotationAnimationWithAnimationView:(UIView *)animationView{
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(M_PI*2.0);
    rotationAnimation.duration = 0.5;
    rotationAnimation.cumulative = YES;
    //rotationAnimation.repeatCount = MAXFLOAT;//一直旋转
    [animationView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}


+ (NSInteger)getLinesArrayOfString:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)maxWidth{
  
    //CGRect rect = [label frame];
    
    CTFontRef myFont = CTFontCreateWithName(( CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge  id)myFont range:NSMakeRange(0, attStr.length)];
    CFRelease(myFont);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,kSCALE(maxWidth),100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge  CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithFloat:0.0]));
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithInt:0.0]));
        //NSLog(@"''''''''''''''''''%@",lineString);
        [linesArray addObject:lineString];
    }
    
    CGPathRelease(path);
    CFRelease( frame );
    CFRelease(frameSetter);
    return linesArray.count;
}

@end
