//
//  RecommendModel.h
//  ILoveMovie
//
//  Created by lanou3g on 15/10/28.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendModel : NSObject

/*
 "ColumnID": 1,
 "InfoID": 3764,
 "PicURL": "/ueditor/net/upload/image/20151026/c17_22D055356862.jpg",
 "Title": "一路向前",
 "LinkUrl": "http://www.fun.tv/vplay/g-201662/?zjmoviezdomo=1",
 "Introduction": "《一路向前》：前途和女神，该选择哪个？",
 "SpecilLabelIDS": "15,",
 "Content": "<p style=\"text-align: center;\"><img src=\"/ueditor/net/upload/image/20151026/c17_1B6703446055.jpg\" title=\"2.jpg\" alt=\"2.jpg\"/></p><p style=\"text-align: center;\"><img src=\"/ued itor/net/upload/image/20151026/c17_1C7CE6119533.jpg\" title=\"3.jpg\" alt=\"3.jpg\"/></p><p style=\"text-align: center;\"><img src=\"/ueditor/net/upload/image/20151026/c17_1D8329548141.jpg\" title=\"4.jpg\" alt=\"4.jpg\"/></p><p>碌碌无为的普通青年牛顿（陈赫 饰） 是一个刚刚毕业一年的职场菜鸟， 默默暗恋着女同事姚姚（姚星彤 饰）。准备胎牛顿一直费劲心思想要讨好女神， 无奈自己却并没有任何出彩的地方。 正在此时， 公司突然有了公派纽约工作的机会，所有员工都跃跃欲试。 牛顿在极品损友卡耐基（常远 饰）的建议下不择手段跟踪处长以此要挟获得进修机会，而姚姚却因为与男友分手意外失去竞争机会……&nbsp;</p><p>在爱情和工作面前，牛顿究竟该何去何从？是选择无量前途，亦或是携手一生的伴侣？</p>",
 "AddTime": "2015-10-26T16:35:10",
 "GoodTimes": 0,
 "LabelIDS": "喜剧"
 */

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
