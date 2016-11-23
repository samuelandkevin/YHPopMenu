# YHPopMenu
仿微信点击“+”号的菜单弹出视图

   // 在YHPopMenuView.h文件中

   // 以下是修改图标和文字参数配置属性
   
        @property (nonatomic,assign) CGFloat iconW;             //图标宽(默认宽高相等)
        @property (nonatomic,assign) CGFloat fontSize;          //字体大小
        @property (nonatomic,strong) UIColor *fontColor;        //字体颜色
        @property (nonatomic,strong) UIColor *itemBgColor;      //item背景颜色
        @property (nonatomic,assign) CGFloat itemNameLeftSpace; //itemName左边距
        @property (nonatomic,assign) CGFloat iconLeftSpace;     //icon左边距离
        @property (nonatomic,assign) CGFloat itemH;             //item高度
        @property (nonatomic,copy) NSArray *iconNameArray;      //图标名字Array
        @property (nonatomic,copy) NSArray *itemNameArray;      //item名字Array
        @property (nonatomic,assign) BOOL canTouchTabbar;//可以点击Tabbar;(默认是遮挡Tabbar)

   //  实际调用如下：
   
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
        popView.iconNameArray = @               [@"home_img_pubDyn",@"home_img_offerReward",@"home_img_pubPosition",@"chat_img_groupchat",@"chat_img_add",@"home_img_scan"];
        popView.itemNameArray = @[@"发动态",@"发悬赏",@"发职位",@"发起群聊",@"添加朋友",@"扫一扫"];
        popView.itemH     = itemH;
        popView.fontSize  = 16.0f;
        popView.fontColor = [UIColor whiteColor];
        popView.canTouchTabbar = YES;
        [popView show];
        ...
 
     }
  
  
    - (void)hidePopMenuWithAnimation:(BOOL)animate{
         [_popView hideWithAnimation:animate];
    }


  
