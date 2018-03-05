//
//  ViewController.m
//  barrageDemoTest
//
//  Created by 王庆学 on 2018/3/5.
//  Copyright © 2018年 王庆学. All rights reserved.
//

#import "ViewController.h"
#import "BaseTableViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

static NSString * const baseTableViewCell = @"BaseTableViewCell";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initTableView];
    [self initRAC];
}

- (void)initRAC{
    [[RACSignal interval:2 onScheduler:[RACScheduler mainThreadScheduler]]subscribeNext:^(id x) {
        [self setAnimation];
    }];
}

- (void)setAnimation{
    CGPoint contentOffset = self.tableView.contentOffset;
    contentOffset.y = contentOffset.y + 80;
    [self.tableView setContentOffset:contentOffset animated:YES];
    if (self.tableView.contentOffset.y >= 240){
        self.tableView.contentOffset = CGPointMake(0, 0);
    }
}

- (void)initTableView{
    [self.tableView registerNib:[UINib nibWithNibName:@"BaseTableViewCell" bundle:nil] forCellReuseIdentifier:@"BaseTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    self.tableView.scrollEnabled = NO;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableViewCell *baseCell = [self.tableView dequeueReusableCellWithIdentifier:baseTableViewCell forIndexPath:indexPath];
    baseCell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row % 6];
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return baseCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
