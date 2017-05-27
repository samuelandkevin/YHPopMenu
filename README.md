# YHPopMenu </br>
### 仿微信“+”弹出菜单。</br>
### 修改图标和文字参数配置属性</br>

```
@property (nonatomic,assign) CGFloat iconW;             //图标宽(默认宽高相等)
@property (nonatomic,assign) CGFloat fontSize;          //字体大小
@property (nonatomic,strong) UIColor *fontColor;        //字体颜色
@property (nonatomic,strong) UIColor *itemBgColor;      //item背景颜色
@property (nonatomic,assign) CGFloat itemNameLeftSpace; //itemName左边距
@property (nonatomic,assign) CGFloat iconLeftSpace;     //icon左边距离
@property (nonatomic,assign) CGFloat itemH;//item高度
@property (nonatomic,copy) NSArray *iconNameArray;      //图标名字Array
@property (nonatomic,copy) NSArray *itemNameArray;      //item名字Array
@property (nonatomic,assign) BOOL canTouchTabbar;       //可以点击Tabbar;(默认是遮挡Tabbar)
```

### 弹出菜单
```
- (void)showPopMenu{
  //设置弹出视图的坐标，宽高
  CGFloat itemH = 50;//每个item的高度
  CGFloat w = 150;
  CGFloat h = 6*itemH;
  CGFloat r = 15;
  CGFloat x = SCREEN_WIDTH - w - r;
  CGFloat y = 1;
    
  //设置参数属性,图标和文字。
  YHPopMenuView *popView = [[YHPopMenuView alloc] initWithFrame:CGRectMake(x, y, w, h)];
  popView.iconNameArray = @[@"home_img_pubDyn",@"home_img_offerReward",@"home_img_pubPosition",@"chat_img_groupchat",@"chat_img_add",@"home_img_scan"];         
  popView.itemNameArray = @[@"发动态",@"发悬赏",@"发职位",@"发起群聊",@"添加朋友",@"扫一扫"];
  popView.itemH     = itemH;
  popView.fontSize  = 16.0f;
  popView.fontColor = [UIColor whiteColor];
  popView.canTouchTabbar = YES;
  [popView show];
}

```

### 关闭弹出菜单
```
- (void)hidePopMenuWithAnimation:(BOOL)animate{
          [_popView hideWithAnimation:animate];
}
```

### 效果图
<img src="http://img.blog.csdn.net/20170510160239027?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvc2FtdWVsYW5ka2V2aW4=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center" width="40%" alt="还在路上，稍等..."/>

### 呈上精品
YHPopMenuView Swift版：[YHPopMenu-Swift-](https://github.com/samuelandkevin/YHPopMenu-Swift-)

### 你的支持,我的动力！

  
