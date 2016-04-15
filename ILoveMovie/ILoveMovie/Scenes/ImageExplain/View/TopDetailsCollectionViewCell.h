//
//  TopDetailsCollectionViewCell.h
//  ILoveMovie
//
//  Created by lanou3g on 15/10/30.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadLineModel.h"
@interface TopDetailsCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong)HeadLineModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UILabel *videoLable;
@property (weak, nonatomic) IBOutlet UILabel *playCountLable;

@end
