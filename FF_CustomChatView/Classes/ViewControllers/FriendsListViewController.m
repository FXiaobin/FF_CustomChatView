//
//  FriendsListViewController.m
//  FF_CustomChatView
//
//  Created by fanxiaobin on 2017/5/31.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "FriendsListViewController.h"
#import "AddFriendViewController.h"
#import "ChatViewController.h"

@interface FriendsListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property  (nonatomic,strong) NSMutableArray *dataArr;

@property  (nonatomic,strong) UITableView *tableView;

@end

@implementation FriendsListViewController

-(NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
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
    self.navigationItem.title = @"好友列表";
    
    [self.view addSubview:self.tableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"➕" style:UIBarButtonItemStyleDone target:self action:@selector(addFriendsItemAction:)];
    
    
    [[EMClient sharedClient].contactManager getContactsFromServerWithCompletion:^(NSArray *aList, EMError *aError) {
        
        
        if (!aError) {
            [self.dataArr removeAllObjects];
            [self.dataArr addObjectsFromArray:aList];
        }else{
            ShowAlert(@"获取好友列表失败");
        }
        
        
        [self.tableView reloadData];
    }];
    
    
    
}

- (void)addFriendsItemAction:(UIBarButtonItem *)item{

    AddFriendViewController *add = [[AddFriendViewController alloc] init];
    [self.navigationController pushViewController:add animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArr[indexPath.row];
   
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifer = self.dataArr[indexPath.row];
    EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:identifer type:EMConversationTypeChat createIfNotExist:YES];
    ChatViewController *chat = [[ChatViewController alloc] init];
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
