//
//  TopModel.h
//  ILoveMovie
//
//  Created by lanou3g on 15/10/28.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopModel : NSObject

@property (nonatomic, strong)NSString *previewImage; // 图片
@property (nonatomic, strong)NSString *topicName; // 名字
@property (nonatomic, strong)NSString *watchCount; // 观看人数
@property (nonatomic, strong)NSString *detailIntroduction;//导演介绍
@property (nonatomic, strong)NSString *topicId; // id
@end
