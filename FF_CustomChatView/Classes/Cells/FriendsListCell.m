//
//  FriendsListCell.m
//  FF_CustomChatView
//
//  Created by fanxiaobin on 2017/5/31.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "FriendsListCell.h"

@interface FriendsListCell ()
///头像
@property  (nonatomic,strong) UIImageView *headerIcon;
///昵称
@property  (nonatomic,strong) UILabel *nickNameLabel;
///消息
@property  (nonatomic,strong) UILabel *messageLabel;
///时间
@property  (nonatomic,strong) UILabel *timeLabel;
///未读消息数量
@property  (nonatomic,strong) UILabel *unReadCountLabel;

@end

@implementation FriendsListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI{
    
    self.headerIcon = [UIViewUtils createImageViewWithFrame:CGRectZero imageName:kPlaceholderImageName contentMode:UIViewContentModeScaleToFill];
    [self.contentView addSubview:self.headerIcon];
    
    self.nickNameLabel = [UIViewUtils createLabelWithFrame:CGRectZero text:@"Bob" textColor:kTitleColor textAlignment:NSTextAlignmentLeft font:kFont(kSCALE(36.0)) numberOfLines:1];
    [self.contentView addSubview:self.nickNameLabel];
    
    
    self.messageLabel = [UIViewUtils createLabelWithFrame:CGRectZero text:@"您收到一条消息" textColor:kContentColor textAlignment:NSTextAlignmentLeft font:kFont(kSCALE(28)) numberOfLines:1];
    [self.contentView addSubview:self.messageLabel];
    
    self.timeLabel = [UIViewUtils createLabelWithFrame:CGRectZero text:@"15:36" textColor:kTimeColor textAlignment:NSTextAlignmentRight font:kFont(kSCALE(24)) numberOfLines:1];
    [self.contentView addSubview:self.timeLabel];
    
    self.unReadCountLabel = [UIViewUtils createLabelWithFrame:CGRectZero text:@"2" textColor:kWhiteColor textAlignment:NSTextAlignmentCenter font:kFont(kSCALE(24)) numberOfLines:1];
    [CommonUtils cornerRadius:kSCALE(kSCALE(30)) forView:self.unReadCountLabel];
    self.unReadCountLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.unReadCountLabel];
    
    
    [self.headerIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kSCALE(30.0));
        make.centerY.equalTo(self.contentView);
        make.width.and.height.mas_equalTo(kSCALE(88.0));
    }];
    
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerIcon.mas_right).offset(kSCALE(30.0));
        make.top.equalTo(self.headerIcon);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-kSCALE(30.0));
        make.centerY.equalTo(self.nickNameLabel);
        make.left.equalTo(self.nickNameLabel.mas_right).offset(kSCALE(30.0));
    }];
    
    [self.unReadCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.timeLabel.mas_right);
        make.bottom.equalTo(self.headerIcon.mas_bottom);
        make.width.and.height.mas_equalTo(kSCALE(30.0));
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nickNameLabel);
        make.bottom.equalTo(self.headerIcon.mas_bottom);
        make.right.equalTo(self.unReadCountLabel.mas_left).offset(-kSCALE(30.0));
    }];
    
    
    
    
}


-(void)setConversation:(EMConversation *)conversation{
    _conversation = conversation;
    
    EMMessage *lastMsg = conversation.latestMessage;
    self.nickNameLabel.text = lastMsg.from;
    self.timeLabel.text = [CommonUtils timeFormatterStringWithTimestamp:lastMsg.localTime dateFormatter:@"HH:mm:ss"];
    if (lastMsg.isRead) {
        self.unReadCountLabel.hidden = YES;
    }else{
        self.unReadCountLabel.hidden = NO;
        self.unReadCountLabel.text = [NSString stringWithFormat:@"%d",conversation.unreadMessagesCount];
    }
    
    EMMessageBody *body = lastMsg.body;
    
    if (body.type == EMMessageBodyTypeText) {
        EMTextMessageBody *textBody = (EMTextMessageBody *)body;
        self.messageLabel.text = textBody.text;
    }else if (body.type == EMMessageBodyTypeImage){
        self.messageLabel.text = @"图片";
    }else if (body.type == EMMessageBodyTypeVideo){
        self.messageLabel.text = @"语音";
    }else if (body.type == EMMessageBodyTypeLocation){
        self.messageLabel.text = @"位置";
    }
}


@end
