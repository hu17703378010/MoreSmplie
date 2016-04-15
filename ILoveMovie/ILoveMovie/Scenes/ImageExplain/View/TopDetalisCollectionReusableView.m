//
//  TopDetalisCollectionReusableView.m
//  ILoveMovie
//
//  Created by lanou3g on 15/10/30.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "TopDetalisCollectionReusableView.h"

@implementation TopDetalisCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
        [self addSubview:self.imageView];
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(20, self.imageView.bottom , kScreenWidth, 40)];
        [self addSubview:self.titleLable];
        self.palyCountLable = [[UILabel alloc] initWithFrame:CGRectMake(20, self.titleLable.bottom - 10 , kScreenWidth, 40)];
        [self addSubview:self.palyCountLable];
        self.detalisLable = [[UILabel alloc] initWithFrame:CGRectMake(20, self.palyCountLable.bottom - 10, kScreenWidth - 30, 40)];
        self.detalisLable.numberOfLines = 0;
        self.detalisLable.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.detalisLable];
    }
    
    return self;
}

+ (CGFloat)cellWithModel:(TopModel *)lableModel
{
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName];
    CGRect lableFrame = [lableModel.detailIntroduction boundingRectWithSize:(CGSizeMake(300, 100000)) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    return lableFrame.size.height;
}

- (void)setModel:(TopModel *)model
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.previewImage] placeholderImage:[UIImage imageNamed:@"c_placeHolder.jpg"]];
    self.titleLable.text = [NSString stringWithFormat:@"%@", model.topicName];
    self.palyCountLable.text = [NSString stringWithFormat:@"%@ 人观看", model.watchCount];
    self.detalisLable.text = [NSString stringWithFormat:@"    %@", model.detailIntroduction];
    
    // 更改lable的高度
    CGRect newFrame = self.detalisLable.frame;
    newFrame.size.height = [TopDetalisCollectionReusableView cellWithModel:model];
    self.detalisLable.frame = newFrame;
//    self.newHeight = (CGFloat)newFrame.size.height;

}

@end
