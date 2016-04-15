//
//  CommentModel.h
//  ILoveMovie
//
//  Created by lanou3g on 15/10/29.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject


/*
 "ColumnID": 2,
 "InfoID": 311,
 "PicURL": "/ueditor/net/upload/image/20141022/c210_3464D1493193.jpg",
 "Title": "《水牛城66》，谁说你会一直倒霉？",
 "LinkUrl": "",
 "Introduction": "",
 "SpecilLabelIDS": "",
 "Content": "<p>有时候，你可能会觉得自己很倒霉，干嘛嘛不顺。然而，看到《水牛城66》里的倒霉蛋Billy遇到的事，你可能会宽慰不少：</p><p style=\"text-align: center;\"><img src=\"/ueditor/net/upload/image/20141022/c210_FFFCF5F36752712.jpg\" title=\"８.jpg\" alt=\"８.jpg\" data-pinit=\"registered\"/></p><p>没做什么坏事，却蹲了五年大牢；</p><p>出狱后无处可去，躺监狱外的椅子上休息一会，被寒风吹得瑟瑟发抖，心中渴望洗一个热水澡；</p><p>被尿憋醒后，去监狱上厕所，监狱不给进；坐上最后一班车回到城里找厕所，却四处碰壁；索性躲在一辆汽车后解决，恰巧这时汽车要开走；终于找到厕所了，却遇到一个讨厌鬼，想尿也尿不出来；</p><p>出狱后应该与父母团聚，却还要编织自己这么多年都生活得很好的谎言；</p><p>遇到多年暗恋的女孩，却被嘲笑和羞辱一顿……</p><p>处处不顺心的Billy内心很无助，但还要把自己伪装成刺猬，不仅对劫持到的女孩Layla和自己最好的朋友凶巴巴的，还破罐子破摔要去杀掉那个害他蹲大狱的人。</p><p style=\"text-align:center\"><img src=\"/ueditor/net/upload/image/20141022/c210_1D68C1754872.jpg\" alt=\"c210_1D68C1754872.jpg\" data-pinit=\"registered\"/></p><p style=\"text-align: left;\">可是地球是转动的，事物永远是变化的，倒霉的人不可能永远都处在同一状态上。当Billy遇到Layla的那一刻，就注定他的倒霉状态要改变：</p><p style=\"text-align: left;\">被劫持的Layla很听话，Billy让她怎么做就怎么做，在Billy父母家假扮Billy老婆时，把老两口哄得很高兴；<br/>一直开着破车陪伴Billy，主动给Billy赞美和关爱；<br/>不知不觉爱上Billy，把Billy那颗脆弱而又冰冷的心融化，用爱阻止Billy的倒霉事继续发生……<br/>当最后Billy把枪扔掉，开心地给Layla买热巧克力并送陌生人女友曲奇饼时，偶感动得扬起嘴角——这就是爱的力量！<br/>此外，影片的布景与摄影很有意思，让片子在沉重中透露出一些小情趣，大家不妨看一看。<br/></p>",
 "AddTime": "2015-10-29T14:35:37",
 "GoodTimes": 1,
 "LabelIDS": ""
 */

// 标题描述
@property (nonatomic, strong) NSString *Title;
// 图片链接
@property (nonatomic, strong) NSString *PicURL;

@property (nonatomic,retain)NSString *Content;
@end
