//
//  UIViewUtils.m
//  dfds
//
//  Created by fanxiaobin on 17/3/7.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "UIViewUtils.h"
#import <MJRefresh/MJRefresh.h>
#import <UIImageView+WebCache.h>

@implementation UIViewUtils

+ (void)addTarget:(id)target selector:(SEL)selector forView:(UIView *)aView{
    aView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:@selector(selector)];
    [aView addGestureRecognizer:tap];
}

+ (UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)alignment font:(UIFont *)font numberOfLines:(NSInteger)lines{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = textColor;
    label.textAlignment = alignment;
    label.font = font;
    label.numberOfLines = lines;
    
    return label;
}

+ (UIButton *)createButtomWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target action:(SEL)sel{
    
    UIButton *aButton = [[UIButton alloc] initWithFrame:frame];
    [aButton setTitleColor:titleColor forState:UIControlStateNormal];
    [aButton setTitle:title forState:UIControlStateNormal];
    aButton.titleLabel.font = font;
    [aButton addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return aButton;
}

+ (UIButton *)createButtomWithFrame:(CGRect)frame backgroundImage:(NSString *)imageName target:(id)target action:(SEL)sel{
    UIButton *aButton = [[UIButton alloc] initWithFrame:frame];
    [aButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [aButton addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return aButton;
}

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName contentMode:(UIViewContentMode)contentModel{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:imageName];
    
    if ([imageName hasPrefix:@"http"] || [imageName hasPrefix:@"https"]) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }
    
    imageView.clipsToBounds = YES;
    imageView.contentMode = contentModel;
    
    return imageView;
}

+ (UITextView *)createTextViewWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor{
    UITextView *textView = [[UITextView alloc] initWithFrame:frame];
    textView.text = text;
    textView.textColor = textColor;
    
    return textView;
}

+ (UITextField *)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder tintColor:(UIColor *)tintColor{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.tintColor = tintColor;
    textField.placeholder = placeholder;
    
    return textField;
}

+ (UITableView *)createTableViewWithFrame:(CGRect)frame target:(id)target style:(UITableViewStyle)style isHeaderRefreshing:(BOOL)isHeaderRefreshing headerRefreshAction:(SEL)headerAction isFooterLoadMore:(BOOL)isFooterLoadMore footerLoadMoreAction:(SEL)footerAction{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:style];
    tableView.delegate = target;
    tableView.dataSource = target;
    tableView.tableFooterView = [UIView new];
    
    if (isHeaderRefreshing) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:headerAction];
        header.lastUpdatedTimeLabel.hidden = YES;
        tableView.mj_header = header;
    }
    
    if (isFooterLoadMore) {
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:footerAction];
    }
    
    return tableView;
}


+ (UICollectionView *)createCollectionViewWithFrame:(CGRect)frame layout:(UICollectionViewFlowLayout *)layout target:(id)target isHeaderRefreshing:(BOOL)isHeaderRefreshing headerRefreshAction:(SEL)headerAction isFooterLoadMore:(BOOL)isFooterLoadMore footerLoadMoreAction:(SEL)footerAction{
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];;
    collectionView.delegate = target;
    collectionView.dataSource = target;
    
    if (isHeaderRefreshing) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:headerAction];
        header.lastUpdatedTimeLabel.hidden = YES;
        collectionView.mj_header = header;
    }
    
    if (isFooterLoadMore) {
        collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:footerAction];
    }
    
    return collectionView;
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message targetVC:(UIViewController *)targetVC ensureActionTitle:(NSString *)ensureTitle completeBlock:(UIViewUtilsResult)block isShowCancelAction:(BOOL)isShow{
    
    UIAlertController *av = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [av addAction:[UIAlertAction actionWithTitle:ensureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        block(action);
    }]];
    
    if (isShow) {
        [av addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    }
    
    [targetVC presentViewController:av animated:YES completion:nil];
}


@end
