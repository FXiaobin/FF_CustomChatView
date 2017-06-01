//
//  AddFriendViewController.m
//  FF_CustomChatView
//
//  Created by fanxiaobin on 2017/5/31.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "AddFriendViewController.h"


@interface AddFriendViewController ()<UITextFieldDelegate>

@property  (nonatomic,strong) UITextField *nickTF;

@property  (nonatomic,strong) SZTextView *remarkTF;

@property  (nonatomic,strong) UIButton *addBtn;

@end

@implementation AddFriendViewController

-(UITextField *)nickTF{
    if (_nickTF == nil) {
        _nickTF = [UIViewUtils createTextFieldWithFrame:CGRectZero placeholder:@"请输入好友昵称" tintColor:kTitleColor];
        _nickTF.delegate = self;
        _nickTF.backgroundColor = kWhiteColor;
        _nickTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _nickTF;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(SZTextView *)remarkTF{
    if (_remarkTF == nil) {
        _remarkTF = [[SZTextView alloc] initWithFrame:CGRectZero];
        _remarkTF.placeholder = @"备注";
    }
    return _remarkTF;
}

-(UIButton *)addBtn{
    if (_addBtn == nil) {
        _addBtn = [UIViewUtils createButtomWithFrame:CGRectZero title:@"添加" titleColor:kTitleColor font:kFont(kSCALE(36.0)) target:self action:@selector(addFriendBtnAction:)];
        _addBtn.backgroundColor = [UIColor orangeColor];
        
    }
    return _addBtn;
}

- (void)addFriendBtnAction:(UIButton *)sender{
    if (self.nickTF.text.length == 0) {
        ShowAlert(@"请输入昵称");
        return;
    }
    
    [self addFriendRequest];
}

- (void)addFriendRequest{
    
    NSString *mark = self.remarkTF.text ? self.remarkTF.text : @"我想加你为好友!";
    
    [[EMClient sharedClient].contactManager addContact:self.nickTF.text message:mark completion:^(NSString *aUsername, EMError *aError) {
        if (!aError) {
            ShowAlert(@"添加成功");
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            ShowAlert(aError.errorDescription);
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"添加好友";
    self.view.backgroundColor = kSeperatorColor;
    
    [self.view addSubview:self.nickTF];
    [self.view addSubview:self.remarkTF];
    [self.view addSubview:self.addBtn];
    
    
    [self.nickTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kSCALE(30.0));
        make.right.equalTo(self.view.mas_right).offset(-kSCALE(30));
        make.top.equalTo(self.view).offset(64+kSCALE(100.0));
        make.height.mas_equalTo(30);
    }];
    
    [self.remarkTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kSCALE(30.0));
        make.right.equalTo(self.view.mas_right).offset(-kSCALE(30));
        make.top.equalTo(self.nickTF.mas_bottom).offset(kSCALE(50));
        make.height.mas_equalTo(kSCALE(200));
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kSCALE(30.0));
        make.right.equalTo(self.view.mas_right).offset(-kSCALE(30));
        make.top.equalTo(self.remarkTF.mas_bottom).offset(kSCALE(50.0));
        make.height.mas_equalTo(kSCALE(80));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
