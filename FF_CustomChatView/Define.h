//
//  Define.h
//  FF_CustomChatView
//
//  Created by fanxiaobin on 2017/5/31.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#ifndef Define_h
#define Define_h

#define kWdith [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height


#define UI_SCALE                [UIScreen mainScreen].bounds.size.width / 750.0
#define kSCALE(value)           value * UI_SCALE

#define kFont(fontSize)         [UIFont systemFontOfSize:fontSize]

#define kPlaceholderImage       [UIImage imageNamed:@"chat_default_header"]
#define kPlaceholderImageName   @"chat_default_header"

//对象循环引用弱化
#define WEAKSELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;
//字体
#define MAIN_FONT(fontName,fontSize) [UIFont fontWithName:fontName size:FontSize(fontSize)]
//rgb色值
#define RGB(r,g,b)          [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]
#define RGBA(r,g,b,a)       [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

//十六进制色值
#define HexRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kTitleColor     HexRGB(0x333333)
#define kSeperatorColor HexRGB(0xe0e0e0)
#define kContentColor   HexRGB(0x666666)
#define kTimeColor      HexRGB(0x999999)
#define kOrangeColor    HexRGB(0xff7349)
#define kMainColor      HexRGB(0xff6634)
#define kWhiteColor     [UIColor whiteColor]





#endif /* Define_h */
