//
//  SSLCacheTool.m
//  XSGL
//
//  Created by mac on 16/12/22.
//  Copyright © 2016年 senlin. All rights reserved.
//

#import "SSLCacheTool.h"

//定义常量
int COMMONLOAD = 0 ;  // 正常加载
int REFRESH = 1 ; // 刷新 （下拉刷新）
int LOADMORE = 2; // 加载更多 （上拉加载）


@implementation SSLCacheTool


/*
 * url 请求的接口路径
 * params 请求的参数
 * type 请求类型 get请求/post请求 (0为get,1为post)
 * flag  判断刷新的类型
 */

+(void)returnCacheBlockWithURL:(NSString *)url params:(NSDictionary *)params cacheKey:(NSString *)key requestType:(int)type loadFlag:(int)flag cacheCallBack:(ReturnCacheBlock)cacheBlock requestCallBack:(ReturnRequestBlock)requestBlock statusCallBack:(ReturnStatusBlock)statusBlock
{
    int haveData;//变量，用于判断缓存中有无数据（1无 2有）
    
    if (flag == REFRESH || flag == LOADMORE) {//是刷新状态，不读取缓存
        haveData = 1;
        
    }else{//非刷新状态，读取缓存
        
        NSObject *cacheResponse= (NSObject *)[[EGOCache globalCache]objectForKey:key];
        if ([cacheResponse isKindOfClass:[NSArray class]]) {//数组类型
            
            NSArray *cacheArr = (NSArray *)cacheResponse;
            if (cacheArr.count > 0) {//缓存中有数据
                haveData = 2;
                if (cacheBlock) {
                    cacheBlock(cacheArr);
                }
            }else{//缓存中无数据
                haveData = 1;
            }
            
            
        }else if ([cacheResponse isKindOfClass:[NSDictionary class]]){//字典类型
            
            NSDictionary *cacheDict = (NSDictionary *)cacheResponse;
            if (cacheDict.count > 0) {// 缓存中有数据
                haveData = 2;
                if (cacheBlock) {
                    cacheBlock(cacheDict);
                }
                
            }else{//缓存中无数据
                haveData = 1;
            }
            
        }


    }
    
    //判断网络状态
    NSString *network = [APP_DELEGATE getAppNetWorkStates];

    if (haveData == 1) {// 缓存中无数据，显示加载中...进度条
        if (![SSLToolMethod isBlankString:network]) {//有网络
            if (statusBlock) {
                statusBlock(1);
            }
        }else{//网络不可用
            if (statusBlock) {
                statusBlock(5);
            }
            return;
        }
        
    }else if (haveData == 2){//有数据
        if ([SSLToolMethod isBlankString:network]) {//网络不可用
            if (statusBlock) {
                statusBlock(6);
            }
            return;
        }
    }
    if (type == 0) {//get请求
        
        [LSHttpTool getWithURL:url params:params success:^(id responseObject) {//请求成功
            
            if (flag != LOADMORE) {//当flag不是LOADMORE（上拉加载时），才写入缓存
                [[EGOCache globalCache]setObject:responseObject forKey:key withTimeoutInterval:86400];

            }
                //1. 刷新页面  2.关闭加载中...进度条
            if (requestBlock) {
                requestBlock(responseObject);
            }
            if (statusBlock) {
                statusBlock(0);
            }
            
        } failure:^(NSError *error) { //请求失败
            if (haveData == 1) {//无数据
                 //1.用空数据刷新页面，提示报错信息
                if (cacheBlock) {
                    cacheBlock(nil);
                }
                 //2.关闭加载中...进度条
                if (statusBlock) {
                    statusBlock(0);
                }
            }
        }];
        
       
        
    }else{//post请求
        
        [LSHttpTool postWithURL:url params:params success:^(id responseObject) {//请求成功
            
            if (flag != LOADMORE) {//当flag不是LOADMORE（上拉加载时），才写入缓存
                [[EGOCache globalCache]setObject:responseObject forKey:key withTimeoutInterval:86400];
                
            }
            //1. 刷新页面  2.关闭加载中...进度条
            if (requestBlock) {
                requestBlock(responseObject);
            }
            if (statusBlock) {
                statusBlock(0);
            }
            
        } failure:^(NSError *error) {//请求失败
            if (haveData == 1) {//无数据
                //1.用空数据刷新页面，提示报错信息
                if (cacheBlock) {
                    cacheBlock(nil);
                }
                //2.关闭加载中...进度条
                if (statusBlock) {
                    statusBlock(0);
                }
            }
        }];
    }
}



@end
