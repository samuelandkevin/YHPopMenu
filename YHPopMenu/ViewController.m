//
//  ViewController.m
//  YHPopMenu
//
//  Created by samuelandkevin on 16/11/23.
//  Copyright © 2016年 YHSoft. All rights reserved.
//

#import "ViewController.h"
#import "YHPopMenuView.h"

@interface ViewController ()
@property (nonatomic, assign) BOOL rBtnSelected;
@property (nonatomic, strong) YHPopMenuView *popView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUpNavigationBar];
}

- (void)setUpNavigationBar{
    self.title = @"首页";
    
    //设置导航栏背景颜色
    UIColor * color = [UIColor colorWithRed:0.f green:191.f / 255 blue:143.f / 255 alpha:1];
    self.navigationController.navigationBar.barTintColor = color;
    
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowColor = [UIColor colorWithWhite:0.871 alpha:1.000];
    shadow.shadowOffset = CGSizeMake(0.5, 0.5);
    //    shadow.shadowBlurRadius = 20;
    
    
    //设置导航栏标题颜色
    NSDictionary *attributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18],NSShadowAttributeName:shadow};

    self.navigationController.navigationBar.titleTextAttributes = attributes;
    
    //设置返回按钮的颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //添加按钮
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onRightBtn:)];
    
    self.navigationItem.rightBarButtonItem = addBtn;
}

#pragma mark - Action
- (void)onRightBtn:(id)sender{
    
    _rBtnSelected = !_rBtnSelected;
    if (_rBtnSelected) {
        [self showPopMenu];
    }else{
        [self hidePopMenuWithAnimation:YES];
    }
    
}

- (void)showPopMenu{
    CGFloat itemH = 50;
    CGFloat w = 150;
    CGFloat h = 6*itemH;
    CGFloat r = 15;
    CGFloat x = SCREEN_WIDTH - w - r;
    CGFloat y = 1;
    
    YHPopMenuView *popView = [[YHPopMenuView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    popView.iconNameArray = @[@"home_img_pubDyn",@"home_img_offerReward",@"home_img_pubPosition",@"chat_img_groupchat",@"chat_img_add",@"home_img_scan"];
    popView.itemNameArray = @[@"发动态",@"发悬赏",@"发职位",@"发起群聊",@"添加朋友",@"扫一扫"];
    popView.itemH     = itemH;
    popView.fontSize  = 16.0f;
    popView.fontColor = [UIColor whiteColor];
    popView.canTouchTabbar = YES;
    [popView show];
    _popView = popView;
    
    WeakSelf
    [popView dismissHandler:^(BOOL isCanceled, NSInteger row) {
        if (!isCanceled) {
            
            NSLog(@"点击第%ld行",(long)row);
            if (!row) {
                
            }
            else if(row == 1){
            }
            else if(row == 2){

            }
            else if(row == 3){
               
            }
            else if(row == 4){
                
            }
            else if(row == 5){
                
            }
        }
        
        weakSelf.rBtnSelected = NO;
    }];
}

- (void)hidePopMenuWithAnimation:(BOOL)animate{
    [_popView hideWithAnimation:animate];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
