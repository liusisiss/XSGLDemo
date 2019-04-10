//
//  LSBigFileRequest.h
//  FilePreviewDemo
//
//  Created by senlin on 15/9/24.
//  Copyright (c) 2015年 senlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol  BigFileManagerDelegate<NSObject>

-(void)downLoadFinishiedWithFileName:(NSString *)fileName;

@end

@interface LSBigFileRequest : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSMutableData *dataM;
// 保存在沙盒中的文件路径
@property (nonatomic, strong) NSString *cachePath;
// 文件总长度
@property (nonatomic, assign) long long fileLength;
// 当前下载的文件长度
@property (nonatomic, assign) long long currentLength;
//消息的ID
@property (nonatomic, copy) NSString *  contentID;
//from的ID
@property (nonatomic, copy) NSString *  fromID;

@property(nonatomic,copy) NSString *fileName;
@property(nonatomic,weak) id<BigFileManagerDelegate> delegate;

- (void)downloadWithURL:(NSURL *)url  andMsgID:(NSString *)msgID andFromID:(NSString *)fromeID;

@end
