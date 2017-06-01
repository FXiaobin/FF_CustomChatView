//
//  UIViewUtils.h
//  dfds
//
//  Created by fanxiaobin on 17/3/7.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^UIViewUtilsResult)(id obj);

@interface UIViewUtils : UIView

@property (nonatomic,copy) UIViewUtilsResult viewUtilsResultBlock;



/// 标签 UILabel
+ (UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)alignment font:(UIFont *)font numberOfLines:(NSInteger)lines;

/// 按钮 UIButton
+ (UIButton *)createButtomWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target action:(SEL)sel;

+ (UIButton *)createButtomWithFrame:(CGRect)frame backgroundImage:(NSString *)imageName target:(id)target action:(SEL)sel;

/// 图片 UIImageView
+ (UIImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName contentMode:(UIViewContentMode)contentModel;

/// 文本域 UITextView
+ (UITextView *)createTextViewWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor;

/// 输入框 UITextField
+ (UITextField *)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder tintColor:(UIColor *)tintColor;

/// 列表 TableView  CollectionView
+ (UITableView *)createTableViewWithFrame:(CGRect)frame target:(id)target style:(UITableViewStyle)style isHeaderRefreshing:(BOOL)isHeaderRefreshing headerRefreshAction:(SEL)headerAction isFooterLoadMore:(BOOL)isFooterLoadMore footerLoadMoreAction:(SEL)footerAction;

+ (UICollectionView *)createCollectionViewWithFrame:(CGRect)frame layout:(UICollectionViewFlowLayout *)layout target:(id)target isHeaderRefreshing:(BOOL)isHeaderRefreshing headerRefreshAction:(SEL)headerAction isFooterLoadMore:(BOOL)isFooterLoadMore footerLoadMoreAction:(SEL)footerAction;

/// 警告框
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message targetVC:(UIViewController *)targetVC ensureActionTitle:(NSString *)ensureTitle completeBlock:(UIViewUtilsResult)block isShowCancelAction:(BOOL)isShow;





@end
