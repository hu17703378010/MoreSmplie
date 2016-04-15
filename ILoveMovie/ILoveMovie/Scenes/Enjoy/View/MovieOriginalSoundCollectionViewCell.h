//
//  MovieOriginalSoundCollectionViewCell.h
//  ILoveMovie
//
//  Created by lanou3g on 15/10/28.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MovieModel.h"  // model


@interface MovieOriginalSoundCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain)UIImageView *soundImageView; // 图片
@property (nonatomic, retain)UILabel *soundLable; // 名字

@property (nonatomic, strong) MovieModel *movieSoundModel;
@end
