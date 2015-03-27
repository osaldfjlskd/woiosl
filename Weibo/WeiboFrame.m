//
//  WeiboFrame.m
//  Weibo
//
//  Created by hellovoidworld on 14/12/5.
//  Copyright (c) 2014年 hellovoidworld. All rights reserved.
//

#import "WeiboFrame.h"
#import "Weibo.h"

// 昵称字体
#define NAME_FONT [UIFont systemFontOfSize:14]
// 博文字体
#define TEXT_FONT [UIFont systemFontOfSize:15]

@implementation WeiboFrame

#pragma mark - 加载数据
// 加载数据，用以计算各个控件的位置、尺寸
- (void)setWeibo:(Weibo *)weibo {
    _weibo = weibo;
    
    // 间隙参数
    CGFloat padding = 10;
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    CGFloat screenwidth = size.width;
    CGFloat screenheight = size.height;
    
    // 1.头像
    CGFloat iconWidth = 30;
    CGFloat iconHeight = 30;
    CGFloat iconX = padding;
    CGFloat iconY = padding;
    _iconFrame = CGRectMake(iconX, iconY, iconWidth, iconHeight);
    
    // 2.昵称
    // 计算昵称占用的size
    CGSize nameSize = [self calTextSizeWithText:self.weibo.name font:TEXT_FONT maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    CGFloat nameX = CGRectGetMaxX(_iconFrame) + padding;
    CGFloat nameY = iconY + (iconHeight - nameSize.height) / 2;// 居中
    _nameFrame.size = nameSize;
    _nameFrame.origin = CGPointMake(nameX, nameY);
    
    // 3.vip标志
    CGFloat vipWith = 14;
    CGFloat vipHeight = 14;
    CGFloat vipX = CGRectGetMaxX(_nameFrame) + padding;
    CGFloat vipY = nameY;
    _vipFrame = CGRectMake(vipX, vipY, vipWith, vipHeight);
    
    // 4.博文
    CGSize textSize = [self calTextSizeWithText:self.weibo.text font:TEXT_FONT maxSize:CGSizeMake(300, MAXFLOAT)];
    CGFloat textX = padding;
    CGFloat textY = CGRectGetMaxY(_iconFrame) + padding;
    _textFrame = CGRectMake(textX, textY, textSize.width, textSize.height);
    
    // 5.配图
    if (self.weibo.picture) {
        
        if (1 == [self.weibo.picture count])
        {
         CGFloat pictureWidth = screenwidth/2;
         CGFloat pictureHeight = screenwidth/2;
        CGFloat pictureX = padding;
        CGFloat pictureY = CGRectGetMaxY(_textFrame) + padding;
        _pictureFrame = CGRectMake(pictureX, pictureY, pictureWidth, pictureHeight);
        
        _cellHeight = CGRectGetMaxY(_pictureFrame) + padding; //计算cell高度
        }
        
        if ([self.weibo.picture count]== 2 || [self.weibo.picture count] == 3)
        {
            CGFloat pictureWidth = screenwidth/4.2;
            CGFloat pictureHeight = pictureWidth;
            CGFloat pictureX = padding;
            CGFloat pictureY = CGRectGetMaxY(_textFrame) + padding;
            _pictureFrame = CGRectMake(pictureX, pictureY, pictureWidth, pictureHeight);
            
            _cellHeight = CGRectGetMaxY(_pictureFrame) + padding; //计算cell高度
        }
        
        if([self.weibo.picture count] ==4||[self.weibo.picture count] == 5|| [self.weibo.picture count]==6)
        {
            CGFloat pictureWidth = screenwidth/4.2;
            CGFloat pictureHeight = pictureWidth;
            CGFloat pictureX = padding;
            CGFloat pictureY = CGRectGetMaxY(_textFrame) + padding;
            _pictureFrame = CGRectMake(pictureX, pictureY, pictureWidth, pictureHeight);
            
            _cellHeight = CGRectGetMaxY(_pictureFrame)*2; //计算cell高度
            _cellHeight = _cellHeight + padding;
        }
        if ([self.weibo.picture count] == 7 ||[self.weibo.picture count] ==8 ||[self.weibo.picture count] ==9) {
            CGFloat pictureWidth = screenwidth/4.2;
            CGFloat pictureHeight = pictureWidth;
            CGFloat pictureX = padding;
            CGFloat pictureY = CGRectGetMaxY(_textFrame) + padding;
            _pictureFrame = CGRectMake(pictureX, pictureY, pictureWidth, pictureHeight);
            
            _cellHeight = CGRectGetMaxY(_pictureFrame)*3; //计算cell高度
            _cellHeight = _cellHeight + padding;
        }
    }
    else {
        _cellHeight = CGRectGetMaxY(_textFrame) + padding;
    }
}

// 使用自带方法计算一段文字占用的size
- (CGSize) calTextSizeWithText:(NSString *) text font:(UIFont *) font maxSize:(CGSize) maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
