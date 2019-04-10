//
//  XGHttpTool.h
//  HangXinMessage
//
//  Created by 赵小嘎 on 14-8-4.
//  Copyright (c) 2014年 联动优势. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LSHttpTool : NSObject

/**
 *  发送一个POST请求
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params md5:(NSString *)md5 success:(void (^)(id))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST请求 (有文件参数-新)
 */
+ (void)postWithUrl:(NSString *)url parameters:(id)parameters fileDate:(NSData *)data psnId:(NSString *)psnId success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST请求 (有文件参数+林修改)
 *
 *  @param url                       请求路径
 *  @param parameters                请求参数
 *  @param constructingBodyWithBlock 文件
 *  @param success                   请求成功后的回调
 *  @param failure                   请求失败后的回调
 */
+ (void)postWithUrl:(NSString *)url param:(NSDictionary *)param constructingBodyWithBlock:(void (^)(id formData))constructingBodyWithBlock success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


/**
 *  发送一个GET请求
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params md5:(NSString *)md5 success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params withTimeoutInterval:(NSTimeInterval)timeoutInterval success:(void (^)(id))success failure:(void (^)(NSError *))failure;
@end
