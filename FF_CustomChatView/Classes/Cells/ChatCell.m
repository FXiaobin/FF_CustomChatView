//
//  ChatCell.m
//  FF_CustomChatView
//
//  Created by fanxiaobin on 2017/5/31.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "ChatCell.h"

@interface ChatCell ()

@property  (nonatomic,strong) UIImageView *headerIcon;

@property  (nonatomic,strong) UILabel *nickNameLabel;

@property  (nonatomic,strong) UILabel *timeLabel;

@property  (nonatomic,strong) MLEmojiLabel *messageLabel;

@property  (nonatomic,strong) UIImageView *picImage;

@end

@implementation ChatCell

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
    
    
    
    self.nickNameLabel = [UIViewUtils createLabelWithFrame:CGRectZero text:@"" textColor:kTitleColor textAlignment:NSTextAlignmentLeft font:kFont(kSCALE(20)) numberOfLines:1];
    [self.contentView addSubview:self.nickNameLabel];
    
    self.timeLabel = [UIViewUtils createLabelWithFrame:CGRectZero text:@"" textColor:kTitleColor textAlignment:NSTextAlignmentLeft font:kFont(kSCALE(20)) numberOfLines:1];
    [self.contentView addSubview:self.timeLabel];
    
    self.messageLabel = [[MLEmojiLabel alloc] initWithFrame:CGRectZero];
    self.messageLabel.isNeedAtAndPoundSign = NO;
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.font = kFont(kSCALE(28));
    [self.contentView addSubview:self.messageLabel];
    
    
    self.picImage = [[UIImageView alloc] init];
    self.picImage.image = kPlaceholderImage;
    [self.contentView addSubview:self.picImage];
  
    
}



-(void)setMessage:(EMMessage *)message{
    _message = message;
    EMMessageBody *messageBody = message.body;
    
    CGFloat width = 0.0, height = 0.0;
    
    if (messageBody.type == EMMessageBodyTypeText) {
        EMTextMessageBody *textBody = (EMTextMessageBody *)messageBody;
        
        self.messageLabel.hidden = NO;
        self.picImage.hidden = YES;
        self.messageLabel.text = textBody.text;
        
        CGSize size = [self.messageLabel sizeThatFits:CGSizeMake(kSCALE(360), CGFLOAT_MAX)];
        width = size.width + kSCALE(20);
        height = size.height + kSCALE(20);

          
    }else if (messageBody.type == EMMessageBodyTypeImage){
        EMImageMessageBody *imageBody = (EMImageMessageBody *)messageBody;
        self.messageLabel.hidden = YES;
        self.picImage.hidden = NO;
         [self.picImage sd_setImageWithURL:[NSURL URLWithString:imageBody.thumbnailRemotePath] placeholderImage:kPlaceholderImage];
        self.picImage.image = [UIImage imageWithContentsOfFile:imageBody.localPath];
        
        CGFloat rate = imageBody.size.height / imageBody.size.width;
        
        width = kSCALE(260);
        height = width * rate;
        
    }else if (messageBody.type == EMMessageBodyTypeLocation){
        width =  kSCALE(300);
        height = kSCALE(300);
        
    }
   
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    if ([message.from isEqualToString:username]) {
        self.cellType = ChatCellTypeSelf;
        self.nickNameLabel.text = message.from;
    }else{
        self.cellType = ChatCellTypeOther;
        self.nickNameLabel.text = message.from;
    }
   
    self.timeLabel.text = [CommonUtils timeFormatterStringWithTimestamp:message.localTime dateFormatter:@"HH:mm:ss"];

//    
    if (_cellType == ChatCellTypeSelf) {
        ///布局
        [self.headerIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-kSCALE(30));
            make.top.equalTo(self.contentView).offset(kSCALE(20));
            make.height.mas_equalTo(kSCALE(80.0));
            make.width.mas_equalTo(kSCALE(80.0));
        }];
        
        [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.headerIcon.mas_left).offset(-kSCALE(30));
            make.top.equalTo(self.headerIcon);
            make.height.mas_equalTo(kSCALE(30.0));
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.nickNameLabel.mas_left).offset(-kSCALE(30));
            make.centerY.equalTo(self.nickNameLabel);
        }];
        
        if (messageBody.type == EMMessageBodyTypeText) {
            [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.nickNameLabel.mas_right);
                make.top.equalTo(self.nickNameLabel.mas_bottom);
                make.height.mas_equalTo(height);
                make.width.mas_equalTo(width);
            }];
            
            
            
            
        }else if (messageBody.type == EMMessageBodyTypeImage){
            
            [self.picImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.nickNameLabel.mas_right);
                make.top.equalTo(self.nickNameLabel.mas_bottom);
                make.height.mas_equalTo(height);
                make.width.mas_equalTo(width);
            }];
            
           
        
        }
        
        
        
    }else{
        
        [self.headerIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(kSCALE(30));
            make.top.equalTo(self.contentView).offset(kSCALE(20));
            make.height.mas_equalTo(kSCALE(80.0));
            make.width.mas_equalTo(kSCALE(80));
        }];
        
        [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headerIcon.mas_right).offset(kSCALE(20));
            make.top.equalTo(self.headerIcon);
            make.height.mas_equalTo(kSCALE(30.0));
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nickNameLabel.mas_right).offset(kSCALE(30));
            make.centerY.equalTo(self.nickNameLabel);
        }];
        
        if (messageBody.type == EMMessageBodyTypeText) {
            [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.nickNameLabel);
                make.top.equalTo(self.nickNameLabel.mas_bottom);
                make.height.mas_equalTo(height);
                make.width.mas_equalTo(width);
            }];
            
            
            
            
        }else if (messageBody.type == EMMessageBodyTypeImage){
            
            [self.picImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.nickNameLabel);
                make.top.equalTo(self.nickNameLabel.mas_bottom);
                make.height.mas_equalTo(height);
                make.width.mas_equalTo(width);
            }];
         
        }

    }
    
    
    
    
 
}

+ (CGFloat)cellHeightWithMessage:(EMMessage *)message{
    CGFloat height = 0.0;
    EMMessageBody *messageBody = message.body;
    
    switch (messageBody.type) {
        case EMMessageBodyTypeText: {
            EMTextMessageBody *textBody = (EMTextMessageBody *)messageBody;
            CGSize size = [textBody.text boundingRectWithSize:CGSizeMake(kSCALE(360), 10000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesDeviceMetrics attributes:@{NSFontAttributeName : kFont(kSCALE(28))} context:nil].size;
            height = size.height + kSCALE(20) + kSCALE(60);
      
        }break;
        case EMMessageBodyTypeImage: {
            EMImageMessageBody *imageBody = (EMImageMessageBody *)messageBody;
            CGFloat rate = imageBody.size.height / imageBody.size.width;
            
            height = kSCALE(260) * rate;
            height += kSCALE(80);
            
        }break;
        case EMMessageBodyTypeLocation: {
            
            height = kSCALE(300.0);
            
        }break;
            
        default:
            break;
    }

    return height;
}

@end
