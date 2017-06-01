//
//  ChatCell.h
//  FF_CustomChatView
//
//  Created by fanxiaobin on 2017/5/31.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ChatCellType) {
    ChatCellTypeSelf,   ///自己
    ChatCellTypeOther   ///好友
};

@interface ChatCell : UITableViewCell

@property (nonatomic) ChatCellType cellType;


@property  (nonatomic,strong) EMMessage *message;

+ (CGFloat)cellHeightWithMessage:(EMMessage *)message;


@end
