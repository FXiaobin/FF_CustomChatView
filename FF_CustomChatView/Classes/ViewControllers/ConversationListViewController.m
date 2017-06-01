//
//  ConversationListViewController.m
//  FF_CustomChatView
//
//  Created by fanxiaobin on 2017/5/31.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "ConversationListViewController.h"
#import "FriendsListCell.h"
#import "FriendsListViewController.h"
#import "ChatViewController.h"

@interface ConversationListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property  (nonatomic,strong) NSMutableArray *dataArr;

@property  (nonatomic,strong) UITableView *tableView;

@end

@implementation ConversationListViewController

-(NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        [_tableView registerClass:[FriendsListCell class] forCellReuseIdentifier:@"FriendsListCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = kSCALE(120);
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"消息";
    
    [self.view addSubview:self.tableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"好友" style:UIBarButtonItemStyleDone target:self action:@selector(addFriendsItemAction:)];
    
    
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:conversations];
    
    [self.tableView reloadData];
}

- (void)addFriendsItemAction:(UIBarButtonItem *)item{
    FriendsListViewController *friendlist = [[FriendsListViewController alloc] init];
    [self.navigationController pushViewController:friendlist animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsListCell" forIndexPath:indexPath];
    EMConversation *conversation = self.dataArr[indexPath.row];
    cell.conversation = conversation;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatViewController *chat = [[ChatViewController alloc] init];
    EMConversation *conversation = self.dataArr[indexPath.row];
    chat.conversation = conversation;
    [self.navigationController pushViewController:chat animated:YES];
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
