//
//  SSLCacheTool.h
//  XSGL
//
//  Created by mac on 16/12/22.
//  Copyright © 2016年 senlin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ReturnRequestBlock)(id responseObject);//请求的数据
typedef void(^ReturnCacheBlock)(id responseObject);//缓存的数据
typedef void(^ReturnStatusBlock)(int statusType);//状态类型(0移除加载中，1显示加载中；2移除无数据或网络异常，3显示无数据；5显示网络异常；6提示网络异常)

@interface SSLCacheTool : NSObject


//@property(nonatomic,copy) ReturnCacheBlock returnCacheBlock;

/*
 * url 请求的接口路径
 * params 请求的参数
 * type 请求类型 get请求/post请求 (0为get,1为post)
 * refresh  是否是刷新
 * cacheBlock 读取缓存的数据
 * requestBlock  请求新的数据
 * statusBlock  状态（加载中，无数据，请求失败）
 */
+(void)returnCacheBlockWithURL:(NSString *)url params:(NSDictionary *)params cacheKey:(NSString *)key requestType:(int)type loadFlag:(int)flag cacheCallBack:(ReturnCacheBlock)cacheBlock requestCallBack:(ReturnRequestBlock)requestBlock statusCallBack:(ReturnStatusBlock)statusBlock;


@end
