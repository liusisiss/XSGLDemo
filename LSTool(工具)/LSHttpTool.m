//
//  XGHttpTool.m
//  HangXinMessage
//
//  Created by 赵小嘎 on 14-8-4.
//  Copyright (c) 2014年 联动优势. All rights reserved.
//

#import "LSHttpTool.h"
#import "AFNetworking.h"
//#import <AFNetworking/AFNetworking.h>

@implementation LSHttpTool


+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    

    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [securityPolicy setValidatesDomainName:NO];
    mgr.securityPolicy = securityPolicy;
    [mgr.securityPolicy setAllowInvalidCertificates:YES];
    [mgr.requestSerializer setTimeoutInterval:30.0];
    // 1、设置http -head参数
    NSString *user = [[[NSUserDefaults alloc] init] objectForKey:@"userId"];
    NSString *session = [[[NSUserDefaults alloc] init] objectForKey:@"session"];
    NSString  *appversion = @"1.0";

    if ([user length]>0&&[session length]>0) {
        
        [mgr.requestSerializer setValue:user forHTTPHeaderField:@"user"];
        [mgr.requestSerializer setValue:session forHTTPHeaderField:@"session"];
        [mgr.requestSerializer setValue:appversion forHTTPHeaderField:@"app-version"];

    }

    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params md5:(NSString *)md5 success:(void (^)(id))success failure:(void (^)(NSError *error))failure
{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];//返回设置

    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];//请求设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [securityPolicy setValidatesDomainName:NO];
    mgr.securityPolicy = securityPolicy;
    [mgr.securityPolicy setAllowInvalidCertificates:YES];
    [mgr.requestSerializer setTimeoutInterval:30.0];
    // 1、设置http -head参数
    NSString *user = [[[NSUserDefaults alloc] init] objectForKey:@"userId"];
    NSString *session = [[[NSUserDefaults alloc] init] objectForKey:@"session"];
    NSString  *appversion = @"1.0";
    if ([user length]>0&&[session length]>0) {
        
        [mgr.requestSerializer setValue:user forHTTPHeaderField:@"user"];
        [mgr.requestSerializer setValue:session forHTTPHeaderField:@"session"];
        [mgr.requestSerializer setValue:md5 forHTTPHeaderField:@"ResultMD5"];
        [mgr.requestSerializer setValue:appversion forHTTPHeaderField:@"app-version"];
    }
    
    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params md5:(NSString *)md5 success:(void (^)(id))success failure:(void (^)(NSError *error))failure
{
    
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    serializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    serializer.removesKeysWithNullValues = YES;
    mgr.responseSerializer = serializer;
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    [mgr.requestSerializer setTimeoutInterval:30.0];
    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [securityPolicy setValidatesDomainName:NO];
    mgr.securityPolicy = securityPolicy;
    [mgr.securityPolicy setAllowInvalidCertificates:YES];
    // 1、设置http -head参数
    NSString *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *session = [[NSUserDefaults standardUserDefaults] objectForKey:@"session"];
    NSString  *appversion = @"1.0";
    if ([user length]>0&&[session length]>0) {
        
        [mgr.requestSerializer setValue:user forHTTPHeaderField:@"user"];
        [mgr.requestSerializer setValue:session forHTTPHeaderField:@"session"];
        [mgr.requestSerializer setValue:md5 forHTTPHeaderField:@"ResultMD5"];
        [mgr.requestSerializer setValue:appversion forHTTPHeaderField:@"app-version"];
    }
    
    [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];

}

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    [AFJSONResponseSerializer serializer].removesKeysWithNullValues = YES;
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    [mgr.requestSerializer setTimeoutInterval:30.0];
    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [securityPolicy setValidatesDomainName:NO];
    mgr.securityPolicy = securityPolicy;
    [mgr.securityPolicy setAllowInvalidCertificates:YES];
    // 1、设置http -head参数
    NSString *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *session = [[NSUserDefaults standardUserDefaults] objectForKey:@"session"];
    NSString  *appversion = @"1.0";

    if ([user length]>0&&[session length]>0) {
        
        [mgr.requestSerializer setValue:user forHTTPHeaderField:@"user"];
        [mgr.requestSerializer setValue:session forHTTPHeaderField:@"session"];
        [mgr.requestSerializer setValue:appversion forHTTPHeaderField:@"app-version"];

    }

    [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params withTimeoutInterval:(NSTimeInterval)timeoutInterval success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    [AFJSONResponseSerializer serializer].removesKeysWithNullValues = YES;
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    [mgr.requestSerializer setTimeoutInterval:timeoutInterval];
    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [securityPolicy setValidatesDomainName:NO];
    mgr.securityPolicy = securityPolicy;
    [mgr.securityPolicy setAllowInvalidCertificates:YES];
    // 1、设置http -head参数
    NSString *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *session = [[NSUserDefaults standardUserDefaults] objectForKey:@"session"];
    NSString  *appversion = @"1.0";
    
    if ([user length]>0&&[session length]>0) {
        
        [mgr.requestSerializer setValue:user forHTTPHeaderField:@"user"];
        [mgr.requestSerializer setValue:session forHTTPHeaderField:@"session"];
        [mgr.requestSerializer setValue:appversion forHTTPHeaderField:@"app-version"];
        
    }
    
    [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)postWithUrl:(NSString *)url parameters:(id)parameters fileDate:(NSData *)data psnId:(NSString *)psnId success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
   
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [securityPolicy setValidatesDomainName:NO];
    mgr.securityPolicy = securityPolicy;
    [mgr.securityPolicy setAllowInvalidCertificates:YES];

    // 1、设置http -head参数
    NSString *user = [[[NSUserDefaults alloc] init] objectForKey:@"userId"];
    NSString *session = [[[NSUserDefaults alloc] init] objectForKey:@"session"];
    NSString  *appversion = @"1.0";

    if ([user length]>0&&[session length]>0) {
        
        [mgr.requestSerializer setValue:user forHTTPHeaderField:@"user"];
        [mgr.requestSerializer setValue:session forHTTPHeaderField:@"session"];
        [mgr.requestSerializer setValue:appversion forHTTPHeaderField:@"app-version"];

    }

    [mgr POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg",psnId];
        [formData appendPartWithFileData:data name:@"txFile" fileName:fileName mimeType:@"image/jpg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  发送一个POST请求
 *
 *  @param url                       请求路径
 *  @param parameters                请求参数
 *  @param constructingBodyWithBlock 文件
 *  @param success                   请求成功后的回调
 *  @param failure                   请求失败后的回调
 */
+ (void)postWithUrl:(NSString *)url param:(NSDictionary *)param constructingBodyWithBlock:(void (^)(id formData))constructingBodyWithBlock success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    // 1.创建请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *user = [[[NSUserDefaults alloc] init] objectForKey:@"userId"];
    NSString *session = [[[NSUserDefaults alloc] init] objectForKey:@"session"];
    NSString  *appversion = @"1.0";
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];

    [manager.requestSerializer setValue:user forHTTPHeaderField:@"user"];
    [manager.requestSerializer setValue:session forHTTPHeaderField:@"session"];
    [manager.requestSerializer setValue:appversion forHTTPHeaderField:@"app-version"];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [securityPolicy setValidatesDomainName:NO];
    manager.securityPolicy = securityPolicy;
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    // 2.发送请求
    [manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (constructingBodyWithBlock) {
            constructingBodyWithBlock(formData);
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success)
        {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(error);
        }
    }];
}



@end
