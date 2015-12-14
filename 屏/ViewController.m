//
//  ViewController.m
//  屏
//
//  Created by qingyun on 15/12/7.
//  Copyright © 2015年 zhangxuecheng. All rights reserved.
//

#import "ViewController.h"
#import "ChatModel.h"
#import "AFNetworking.h"
#import "Common.h"
#import "ChatCell.h"


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textF;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout;
@property (strong, nonatomic)ChatModel *model;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *data;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat wight;
@property (strong, nonatomic) NSString *str;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"beijing"]];
    [self.tableView setBackgroundView:imageView];
    self.tableView.showsVerticalScrollIndicator =
    NO;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

}
-(void)loadData{
    NSString *str = self.textF.text;
    NSDictionary *params = @{@"key":@"291f634eb9ab6904c75814d86fe2222a",@"info":str};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kBaseUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *resultArr = [NSMutableArray arrayWithArray:self.data];
        ChatModel *model = [[ChatModel alloc]initWithDic:responseObject];
        [resultArr addObject:model];
        self.data = resultArr;
        [self.tableView reloadData];
        [self tableViewScrollCurrentIndexPath];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"无网络连接" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)editBegin:(UITextField *)sender {
    self.layout.constant = 256;
}
- (IBAction)editEnd:(UITextField *)sender {
    self.layout.constant = 2;
}
- (IBAction)sender:(UIButton *)sender {
     if (_textF == nil || [_textF.text isEqualToString:@""]) {
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入不能为空" preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
         UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
         [alert addAction:cancelAction];
         [alert addAction:okAction];
         [self presentViewController:alert animated:YES completion:nil];
     }else{
         ChatModel *model = [[ChatModel alloc]init];
         model.type = kChatTo;
         model.textTo = self.textF.text;
         NSMutableArray *arr = [NSMutableArray arrayWithArray:self.data];
         [arr addObject:model];
         self.data = arr;
         [self loadData];
         [self.view endEditing:YES];
     }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    [cell setModel:self.data[indexPath.row]];

   if (cell.type == kChatTo) {
       cell.iconLayout.constant = [UIScreen mainScreen].bounds.size.width - 10 -45;
       cell.contentLayout.constant = -self.wight-70;
       cell.contentHight.constant = self.height;
       cell.contentWigth.constant = self.wight;
       cell.backGroundLayout.constant = -self.wight - 85;
       cell.backGroundHeight.constant = self.height + 20;
       cell.backGroundWigth.constant = self.wight + 40;
       UIImage *image = [UIImage imageNamed:@"chatto_bg_normal"];
       image =[image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.7];
       cell.backGroundImage.image = image;
    
   }else{
       cell.iconLayout.constant = 10;
       cell.contentLayout.constant = 30;
       cell.backGroundLayout.constant = 5;
       cell.backGroundHeight.constant = self.height + 20;
       cell.backGroundWigth.constant = self.wight + 40;
       cell.contentWigth.constant = self.wight;
       cell.contentHight.constant = self.height;
       UIImage *image = [UIImage imageNamed:@"chatfrom_bg_normal"];
       image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.7];
       cell.backGroundImage.image = image;
   }
    self.textF.text = @"";
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    ChatModel *model = self.data[indexPath.row];
   
    if (model.type == kChatTo) {
        self.str = model.textTo;
    }else if(model.type == kChatFrom){
        self.str = model.text;
    }

    CGSize size = [self.str boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-120, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0f]} context:nil].size;
    self.wight = size.width;
    self.height = size.height;
    if (_height>30) {
        return _height + 40;
    }else{
        return 70;
    }
    
}
-(void)tableViewScrollCurrentIndexPath
{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.data.count-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}

@end
