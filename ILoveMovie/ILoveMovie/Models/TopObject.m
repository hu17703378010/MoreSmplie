//
//  TopObject.m
//  ILoveMovie
//
//  Created by lanou3g on 15/11/7.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "TopObject.h"

@implementation TopObject
@dynamic previewImage, topicName,watchCount,detailIntroduction,topicId;
+ (NSString *)parseClassName{
    
    return @"TopObject";
}
@end
