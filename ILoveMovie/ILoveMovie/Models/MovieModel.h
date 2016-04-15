//
//  MovieModel.h
//  ILoveMovie
//
//  Created by lanou3g on 15/11/2.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieModel : NSObject

// 用于影娱全部页面及推荐部分页面
/*
 ColumnID
 InfoID
 PicURL
 Title           图片标题
 LinkUrl
 Introduction
 SpecilLabelIDS
 Content
 AddTime
 GoodTimes
 LabelIDS
 */

// 图片网址
// 需要拼接: http://apk.zdomo.com
@property (nonatomic,retain)NSString *ColumnID;
@property (nonatomic,retain)NSString *PicURL;
@property (nonatomic,retain)NSString *InfoID;
@property (nonatomic,retain)NSString *Title;
@property (nonatomic,retain)NSString *LinkUrl;
@property (nonatomic,retain)NSString *Introduction;
@property (nonatomic,retain)NSString *SpecilLabelIDS;
@property (nonatomic,retain)NSString *Content;
@property (nonatomic,retain)NSString *AddTime;
@property (nonatomic,retain)NSString *GoodTimes;
@property (nonatomic,retain)NSString *LabelIDS;





@end
