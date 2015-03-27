//
//  WeiboCell.m
//  Weibo
//
//  Created by hellovoidworld on 14/12/5.
//  Copyright (c) 2014年 hellovoidworld. All rights reserved.
//

#import "WeiboCell.h"
#import "WeiboFrame.h"
#import "Weibo.h"

// 昵称字体
#define NAME_FONT [UIFont systemFontOfSize:14]
// 博文字体
#define TEXT_FONT [UIFont systemFontOfSize:15]


@interface WeiboCell()

// 创建各个子控件的成员，用来分离数据赋值和尺寸、位置调整
/** 头像 */
@property(nonatomic, weak) UIImageView *iconView;

/** 昵称 */
@property(nonatomic, weak) UILabel *nameView;

/** vip标志 */
@property(nonatomic, weak) UIImageView *vipView;

/** 博文 */
@property(nonatomic, weak) UILabel *textView;

/** 配图 */
@property(nonatomic, weak) UIImageView *pictureView;

//UIPageControl *pageControl
@property(nonatomic, weak) UIPageControl *pageControl;

@end

@implementation WeiboCell

@synthesize weibodata = _weibodata;
@synthesize picArray = _picArray;


- (void)awakeFromNib {
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - 初始化
// 自定义带有父控件tableView初始化方法
+ (instancetype) cellWithTableView:(UITableView *) tableView {
    static NSString *ID = @"weibo";
    
    // 从缓存池寻找
//    WeiboCell *cell;
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

//
//    // 使用重写的构造方法初始化
    if (nil == cell) {
        cell = [[WeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return  cell;
}


// 重写缓存池初始化方法，加入各个子控件，可以设置静态数据，但是没有动态的数据和位置尺寸信息
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 1.头像
        /** 
            由于self.iconView是weak类型,不能写成:
            self.iconView = [[UIImageView alloc] init];
            会被立即释放，不能正常赋值，下同
         */

        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        // 2.昵称
        UILabel *nameView = [[UILabel alloc] init];
        // 指定字体用来计算占用的尺寸大小
        nameView.font = NAME_FONT;
        [self.contentView addSubview:nameView];
        self.nameView = nameView;
        
        // 3.vip标志
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.image = [UIImage imageNamed:@"vip"];
        [self.contentView addSubview:vipView];
        self.vipView = vipView;
        
        // 4.博文
        UILabel *textView = [[UILabel alloc] init];
        textView.font = TEXT_FONT;
        textView.numberOfLines = 0;// 设置自动换行
        [self.contentView addSubview:textView];
        self.textView = textView;
        
        // 5.配图
        UIImageView *pictureView = [[UIImageView alloc] init];
       [self.contentView addSubview:pictureView];
        self.pictureView = pictureView;
        
        
    }
    
    return self;
}

#pragma mark - 数据加载
// 加载数据的时候设置数据和尺寸、位置
- (void)setWeiboFrame:(WeiboFrame *)weiboFrame {
    _weiboFrame = weiboFrame;
    
    // 1.设置数据
    [self calWeiboData];
    
    // 2.设置尺寸、位置
    [self calWeiboFrame];
}

// 设置数据
- (void) calWeiboData {
//    Weibo *weibo = self.weiboFrame.weibo;
    
    NSDictionary* retweetedStatusDic = [self.weibodata objectForKey:@"retweeted_status"];
    if (retweetedStatusDic) {
        _picArray = [[self.weibodata objectForKey:@"retweeted_status"] objectForKey:@"pic_urls"];
    }
    else
    {
        _picArray = [_weibodata objectForKey:@"pic_urls"];
    }
    
    // 1.头像
    self.iconView.image = [UIImage imageNamed:[[self.weibodata objectForKey:@"user"] objectForKey:@"profile_image_url"]];
    
    // 2.昵称
    self.nameView.text = [[self.weibodata objectForKey:@"user"] objectForKey:@"name"];
    
    // 3.vip标志
//    if (weibo.vip) {
//        self.vipView.hidden = NO;
//    }
//    else {
//        self.vipView.hidden = YES;
//    }
    
    // 4.博文
    self.textView.text = [self.weibodata objectForKey:@"text"];

    NSLog(@"%@",self.textView.text);
//    // 5.配图
    


        if (1 == [_picArray count]) {
            self.pictureView.image = [UIImage imageNamed:[[_picArray objectAtIndex:0] objectForKey:@"thumbnail_pic"]];
            NSLog(@"%@",[[_picArray objectAtIndex:0] objectForKey:@"thumbnail_pic"]);
            self.pictureView.hidden = NO;
        }
        if ([_picArray count] > 1) {
            [self addScrollView];
        }


//        NSArray *picArray = [self.weibodata objectForKey:@"pic_urls"];
//        
//        if (1 == [_picArray count]) {
//            self.pictureView.image = [UIImage imageNamed:[[_picArray objectAtIndex:0] objectForKey:@"thumbnail_pic"]];
//            self.pictureView.hidden = NO;
//        }
//        if ([_picArray count] > 1) {
//            [self addScrollView];
//        }
    
    
//    if (weibo.picture) {
//        
//
//        
//        
//    }
//    else {
//        self.pictureView.hidden = YES;
//        self.pictureView.image = nil;
//    }
}

// 设置位置、尺寸
- (void) calWeiboFrame {
    // 1.头像
    self.iconView.frame = self.weiboFrame.iconFrame;
    
    // 2.昵称
    self.nameView.frame = self.weiboFrame.nameFrame;
    
    // 3.vip标志
    self.vipView.frame = self.weiboFrame.vipFrame;
    
    // 4.博文
    self.textView.frame = self.weiboFrame.textFrame;
    
    // 5.配图
    if (self.weiboFrame.weibo.picture) {
        if(1 ==[self.weiboFrame.weibo.picture count])
        {
            self.pictureView.frame = self.weiboFrame.pictureFrame;
        }
        if ([self.weiboFrame.weibo.picture count] == 2 || [self.weiboFrame.weibo.picture count] == 3) {
            
        }
        //宽 640 ，图片150，间隙 25，10
        
    }
}

-(void)addScrollView {
    
    Weibo *weibo = self.weiboFrame.weibo;
    
    UIScrollView *imageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 768, 1024)];
    imageScrollView.backgroundColor = [UIColor clearColor];
    imageScrollView.contentSize = CGSizeMake(7768 * 4, 1024);    // 设置内容大小
    imageScrollView.delegate = self;
    imageScrollView.pagingEnabled = YES;
    imageScrollView.showsHorizontalScrollIndicator = NO;//滚动的时候是否有水平的滚动条，默认是有的
    
    
    
    
    for (int j = 0; j < 3; j ++) {
        for (int i = j * 3; i < j*3 + 3; i++) {
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(j*100+20 , (i%3)*100+100, 100, 100)];//这里开始的时候就习惯定义imageView为全局的了，然后我点击任何白色的imageView的时候，得到的tag值始终是115，也就是总是得到最后一个imageView的tag。全局变量始终是一个，我一直在给一个对象多次初始化，结果最后得到的就只有一个。
            imageView.backgroundColor = [UIColor blackColor];
            imageView.tag = 100 + i;
            NSLog(@"tap %ld image",(long)imageView.tag);
            imageView.userInteractionEnabled=YES;//与用户交互
            NSInteger countPic = [_picArray count];
            if (i < countPic) {
                imageView.image = [UIImage imageNamed:[[_picArray objectAtIndex:i] objectForKey:@"thumbnail_pic"]];
                NSLog(@"%@",[[_picArray objectAtIndex:i] objectForKey:@"thumbnail_pic"]);
            }
            
            
            //为UIImageView添加点击手势
            UITapGestureRecognizer *tap;
            tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            tap.numberOfTapsRequired = 1;//tap次数
            tap.numberOfTouchesRequired = 1;//手指数
            [imageView addGestureRecognizer:tap];
            
            [imageScrollView addSubview:imageView];
            
            
        }
        
    }
    
    [self.contentView addSubview:imageScrollView];
}




//单击图片之后响应的
-(void) tap: (UITapGestureRecognizer*)sender{
    NSLog(@"%ld",(long)sender.view.tag);//根据手势来取得当前点击的view
    
}


//添加PageControl
-(void) addPageControl {
    
    _pageControl.frame = CGRectMake(768/2-150, 900, 320, 40);
    _pageControl.numberOfPages = 4;//页数（几个圆圈）
    _pageControl.tag = 101;
    _pageControl.currentPage = 0;
    
    [self.contentView addSubview:_pageControl];
    
}


//滚动视图的代理方法－ scrollview 减速停止
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    int current = scrollView.contentOffset.x/768;
    NSLog(@"current:%d",current);
    _pageControl.currentPage = current;
}


@end
