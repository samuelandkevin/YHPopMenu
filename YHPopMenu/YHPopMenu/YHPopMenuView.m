//
//  YHPopMenuView.m
//  PikeWay
//
//  Created by samuelandkevin on 16/10/25.
//  Copyright © 2016年 YHSoft. All rights reserved.
//

#import "YHPopMenuView.h"

@interface CellForMenuItem : UITableViewCell
@property (nonatomic,strong) UIImageView *imgvIcon;
@property (nonatomic,strong) UILabel *lbName;
@property (nonatomic,strong) UIView *viewBotLine;
@property (nonatomic,strong) NSDictionary *dictConfig;//cell的配置参数

@end

#define kItemBgColor RGBCOLOR(0, 191, 144)        //item背景颜色
static const CGFloat kIconW = 16;       //图标宽(默认宽高相等)
static const CGFloat kFontSize = 14.0f; //字体大小

static const CGFloat kItemNameLeftSpace = 15;//itemName左边距
static const CGFloat kIconLeftSpace = 15;    //icon左边距离



@implementation CellForMenuItem

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier config:(NSDictionary *)config{
    if (self = [self initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
         self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setup{
    self.imgvIcon = [UIImageView new];
    [self.contentView addSubview:self.imgvIcon];
    
    self.lbName = [UILabel new];
    self.lbName.font = [UIFont systemFontOfSize:14.0f];
    self.lbName.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.lbName];
    
    self.viewBotLine = [UIView new];
    self.viewBotLine.backgroundColor = kGrayColor;
    [self.contentView addSubview:self.viewBotLine];
    
    [self layoutUI];
}

- (void)layoutUI{
    WeakSelf
    [_imgvIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset(10);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.width.height.mas_equalTo(21);
    }];
    
    [_lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.imgvIcon.mas_right).offset(20);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.right.equalTo(weakSelf.contentView).offset(-5);
    }];
    
    [_viewBotLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(0.5);
    }];
    
}

- (void)setDictConfig:(NSDictionary *)dictConfig{
    _dictConfig = dictConfig;
  
    CGFloat fontSize =  [_dictConfig[@"fontSize"] floatValue];
    fontSize = fontSize?fontSize:kFontSize;
    self.lbName.font = [UIFont systemFontOfSize:fontSize];
    
    UIColor *itemBgColor = _dictConfig[@"itemBgColor"];
    itemBgColor = itemBgColor?itemBgColor:kItemBgColor;
    self.backgroundColor = itemBgColor;
    
    UIColor *fontColor = _dictConfig[@"fontColor"];
    self.lbName.textColor = fontColor;
    
    [self updateUI];
}

- (void)updateUI{
    
    CGFloat iconW = [_dictConfig[@"iconW"] floatValue];
    iconW = iconW?iconW:kIconW;
    
    
    CGFloat iconLeftSpace = [_dictConfig[@"iconLeftSpace"] floatValue];
    iconLeftSpace = iconLeftSpace?iconLeftSpace:kIconLeftSpace;
    
    CGFloat itemNameLeftSpace = [_dictConfig[@"itemNameLeftSpace"] floatValue];
    itemNameLeftSpace = itemNameLeftSpace?itemNameLeftSpace:kItemNameLeftSpace;
    

    WeakSelf
    [_imgvIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset(iconLeftSpace);
        make.width.height.mas_equalTo(iconW);
    }];
    
    [_lbName mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.imgvIcon.mas_right).offset(itemNameLeftSpace);
    }];
    
}

@end


@interface YHPopMenuView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *viewBG;
@property (nonatomic,strong) NSDictionary *config;
@property (nonatomic,assign) CGFloat menuViewX;
@property (nonatomic,assign) CGFloat menuViewY;
@property (nonatomic,assign) CGFloat menuViewW;
@property (nonatomic,assign) CGFloat menuViewH;

@property (nonatomic,copy)   DismissBlock dBlock;
@end

static const CGFloat kItemH = 44.0f;//item高度

@implementation YHPopMenuView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _menuViewX = frame.origin.x;
        _menuViewY = frame.origin.y;
        _menuViewW = frame.size.width;
        _menuViewH = frame.size.height;

        [self setup];
    }
    return self;
}

- (void)setup{
    
    UIView *viewBG = [UIView new];
    UITapGestureRecognizer *tapViewBG =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onViewBG:)];
    UISwipeGestureRecognizer *swipViewBG = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onViewBG:)];
    UIPanGestureRecognizer *panViewBG = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onViewBG:)];
    
    [viewBG addGestureRecognizer:tapViewBG];
    [viewBG addGestureRecognizer:swipViewBG];
    [viewBG addGestureRecognizer:panViewBG];
    [self addSubview:viewBG];
    _viewBG = viewBG;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate   = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.bounces = NO;
    [tableView registerClass:[CellForMenuItem class] forCellReuseIdentifier:NSStringFromClass([CellForMenuItem class])];
    [self addSubview:tableView];
    _tableView = tableView;
    
    [self layoutUI];
}

- (void)layoutUI{
    WeakSelf
    _tableView.layer.anchorPoint = CGPointMake(1, 0);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(weakSelf.menuViewX+(weakSelf.tableView.layer.anchorPoint.x-0.5)*weakSelf.menuViewW);
        make.top.equalTo(weakSelf).offset(weakSelf.menuViewY+(weakSelf.tableView.layer.anchorPoint.y-0.5)*weakSelf.menuViewH);
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(0);
    }];
    
    [_viewBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(weakSelf);
    }];
}

#pragma mark - Lazy Load
- (NSArray *)itemNameArray{
    if (!_itemNameArray) {
        _itemNameArray = [NSArray new];
    }
    return _itemNameArray;
}

- (NSArray *)iconNameArray{
    if (!_iconNameArray) {
        _iconNameArray = [NSArray new];
    }
    return _iconNameArray;
}

- (NSDictionary *)config{
    if (!_config) {
        _itemBgColor = _itemBgColor?_itemBgColor:kItemBgColor;
        _fontColor = _fontColor?_fontColor:[UIColor blackColor];
        _config = @{
                    @"iconW":@(_iconW),
                    @"fontSize":@(_fontSize),
                    @"fontColor":_fontColor,
                    @"itemBgColor":_itemBgColor,
                    @"itemNameLeftSpace":@(_itemNameLeftSpace),
                    @"iconLeftSpace":@(_iconLeftSpace),
                    @"itemH":@(_itemH)
                    };
        
        _itemH = _itemH? _itemH :kItemH;
        self.tableView.rowHeight = _itemH;
    }
    return _config;
}


#pragma mark - Public
- (void)dismissHandler:(DismissBlock)handler{
    _dBlock = handler;
}

- (void)show{
    
    CGFloat viewBGH = _canTouchTabbar? SCREEN_HEIGHT-64-44:SCREEN_HEIGHT-64;
    self.frame = CGRectMake(0, 64, SCREEN_WIDTH, viewBGH);
    [KEYWINDOW addSubview:self];
    
    //显示PopView动画
    self.tableView.alpha = 0;
    self.tableView.contentOffset = CGPointZero;
    WeakSelf
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [weakSelf.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(weakSelf.menuViewW);
            make.height.mas_equalTo(weakSelf.menuViewH);
            weakSelf.tableView.alpha = 1;
            weakSelf.tableView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
       
        [UIView animateWithDuration:0.2 animations:^{
           
            [weakSelf.tableView layoutIfNeeded];
        }completion:^(BOOL finished) {
            
        }];
    });


   
}

- (void)hideWithAnimation:(BOOL)animate{
    
    self.tableView.contentOffset = CGPointZero;
    WeakSelf
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.tableView.alpha = 0;
        if (animate) {
            weakSelf.tableView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        }
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
    
}

#pragma mark - Life
- (void)dealloc{
    NSLog(@"%s 销毁",__func__);
}

#pragma mark - Gesture
- (void)onViewBG:(id)sender{
    if (_dBlock) {
        _dBlock(YES,-1);
    }
    [self hideWithAnimation:YES];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellForMenuItem *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CellForMenuItem class])];

    if (indexPath.row < self.iconNameArray.count) {
        NSString *iconName = self.iconNameArray[indexPath.row];
        cell.imgvIcon.image = [UIImage imageNamed:iconName];
    }
    
    if (indexPath.row < self.itemNameArray.count) {
        cell.lbName.text = self.itemNameArray[indexPath.row];
    }
    
    if (indexPath.row == self.itemNameArray.count - 1) {
        cell.viewBotLine.hidden = YES;
    }else{
        cell.viewBotLine.hidden = NO;
    }
    
    cell.dictConfig = self.config;
    return cell;

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemNameArray.count;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dBlock) {
        _dBlock(NO,indexPath.row);
    }
    [self hideWithAnimation:NO];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
