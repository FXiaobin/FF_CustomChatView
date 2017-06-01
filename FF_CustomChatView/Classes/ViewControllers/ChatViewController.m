//
//  ChatViewController.m
//  FF_CustomChatView
//
//  Created by fanxiaobin on 2017/5/31.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatCell.h"

@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource,EMChatManagerDelegate>

@property  (nonatomic,strong) NSMutableArray *dataArr;

@property  (nonatomic,strong) UITableView *tableView;

@end

@implementation ChatViewController

-(NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        [_tableView registerClass:[ChatCell class] forCellReuseIdentifier:@"ChatCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = kSCALE(120);
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kSeperatorColor;
    [self.view addSubview:self.tableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"sender" style:UIBarButtonItemStyleDone target:self action:@selector(sendText:)];
    
    //注册消息回调
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    
    ///标记这个会话的所有消息为已读
    [self.conversation markAllMessagesAsRead:nil];
    
    ///获取消息列表
    NSArray *list = [self.conversation loadMoreMessagesFromId:nil limit:10 direction:EMMessageSearchDirectionUp];
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:list];
    
    [self.tableView reloadData];
    if (self.dataArr.count > 0) {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArr.count - 1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionBottom];
    }
    
    
}

- (void)sendText:(UIBarButtonItem *)sender{
    
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:@"我发送的消息"];
    NSString *from = [[EMClient sharedClient] currentUsername];
    
    NSString *to;
    if ([from isEqualToString:@"fan1234"]) {
        to = @"fan123";
    }else{
        to = @"fan1234";
    }
    
    //生成Message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:from from:from to:to body:body ext:nil];
    message.chatType = EMChatTypeChat;// 设置为单聊消息
    
    [[EMClient sharedClient].chatManager sendMessage:message progress:nil completion:^(EMMessage *message, EMError *error) {
        if (!error) {
            ShowAlert(@"发送成功");
            [self.dataArr addObject:message];
            [self.tableView reloadData];
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArr.count - 1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionBottom];
        }
    }];
}

//在线普通消息会走以下回调
- (void)messagesDidReceive:(NSArray *)aMessages{
    
    [self.dataArr addObjectsFromArray:aMessages];
    [self.tableView reloadData];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArr.count - 1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionBottom];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    EMMessage *message = self.dataArr[indexPath.row];
    return [ChatCell cellHeightWithMessage:message];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell" forIndexPath:indexPath];
    EMMessage *message = self.dataArr[indexPath.row];
   
    cell.message = message;
    
    
//    EMMessageBody *body = message.body;
//    switch (body.type) {
//        case EMMessageBodyTypeText: {
//            EMTextMessageBody *textBody = (EMTextMessageBody *)body;
//            cell.textLabel.text = textBody.text;
//            
//        } break;
//        case EMMessageBodyTypeImage: {
//            cell.textLabel.text = @"图片";
//            
//        } break;
//        case EMMessageBodyTypeLocation: {
//            cell.textLabel.text = @"位置";
//            
//        } break;
//            
//        default:
//            break;
//    }
//    
    return cell;
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
