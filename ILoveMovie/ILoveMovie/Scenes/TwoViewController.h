//
//  TwoViewController.h
//  ILoveMovie
//
//  Created by lanou3g on 15/11/3.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MovieModel.h"
// 分享
#import "AAShareBubbles.h"

@interface TwoViewController : UIViewController<AAShareBubblesDelegate>

{
    AAShareBubbles *shareBubbles;
    float radius;
    float bubbleRadius;
}

@property (nonatomic,retain)MovieModel *model;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UISlider *radiusSlider;
@property (weak, nonatomic) IBOutlet UISlider *bubbleRadiusSlider;
@property (weak, nonatomic) IBOutlet UILabel *radiusLabel;
@property (weak, nonatomic) IBOutlet UILabel *bubbleRadiusLabel;


@end
