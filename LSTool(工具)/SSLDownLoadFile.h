//
//  SSLDownLoadFile.h
//  XSGL
//
//  Created by mac on 17/1/10.
//  Copyright © 2017年 senlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol  DownLoadFileDelegate<NSObject>

-(void)downLoadFinishiedWithFileName:(NSString *)fileName;

@end

@interface SSLDownLoadFile : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSMutableData *dataM;
// 保存在沙盒中的文件路径
@property (nonatomic, strong) NSString *cachePath;
// 文件总长度
@property (nonatomic, assign) long long fileLength;
// 当前下载的文件长度
@property (nonatomic, assign) long long currentLength;

@property(nonatomic,copy) NSString *fileName;
@property(nonatomic,weak) id<DownLoadFileDelegate> delegate;

- (void)downloadWithURL:(NSURL *)url;

@end
