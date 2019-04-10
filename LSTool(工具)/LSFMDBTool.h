//
//  LSFMDBTool.h
//  ZKTD
//
//  Created by senlin on 15/6/23.
//  Copyright (c) 2015年 chanjing. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDB.h"


@interface LSFMDBTool : NSObject


+(void)initializeWithName:(NSString *)name;//初始化


+(void)createFMDBLibWithUserName:(NSString *)name;//创建数据库


#pragma mark-查询、加载数据
//取出资料表内容
+(NSArray *)getDataFromMaterialTable;

//取出好友表内容
+(NSArray *)getDataFromFriendsTable;

//取出消息表内容
//+(NSArray *)getDataFromMessageTableWithFromId:(NSString *)fromId andToId:(NSString *)toId andPage:(NSInteger)page;

//--sisiliu-取出消息表内容
+(NSArray *)getDataFromMessageTableWithFromId:(NSString *)fromId andToId:(NSString *)toId andPage:(NSInteger)page andMethod:(NSString *)mesMethod;

//取出消息表中flag为-1的消息
+(NSArray *)getSendingMessageFromMessageTable;

//根据消息id取出toid
+(NSString *)getFriendIDWithMsgID:(NSString *)msgID;

//取出联系人表内容
+(NSArray *)getDataFromContactTable;//liu

//模糊查询消息表
+(NSArray *)getMsgWithKeyWord:(NSString *)keyWord andFriendID:(NSString *)friendID;

#pragma mark-检测资料表是否有数据

//检测消息表是否有相同数据
+(BOOL)checkOutMessageTableHaveSameDataWithArray:(NSArray*)messageArray;

//检测资料表是否有数据
+(int)checkOutMaterialDataWithFriendId:(NSString *)FriendId;

//获取用户名
+(NSString *)getNameformMaterialWithFriendId:(NSString *)FriendId;

//获取用户头像
+(NSString *)getIconURlformMaterialWithFriendId:(NSString *)FriendId;

//获取好友的flag，根据此值判断置顶，免打扰
+(NSString *)getContactFlagWithFriendId:(NSString *)friendId andType:(NSString *)type;

//从联系人表获得用户名
+(NSString *)getNameformContactWithFriendId:(NSString *)friendId;

//从联系人表获取好友的头像
+(NSString *)getIconURlformContactWithFriendId:(NSString *)friendId;

//检测联系人表是否有数据
+(int)chekOutContactDataWithContactId:(NSString *)contactId;//liu

//检查联系人表是否有相同数据
+(BOOL)checkOutContactTableHaveSameDataWithArray:(NSArray*)messageArray;

#pragma mark-插入数据
//向资料表中插入数据
+(void)AddMaterialTableWithArray:(NSArray *)materialArray;

//向好友表中插入数据
+(void)AddChatedFriendsWithArray:(NSArray *)friendsArray msgArray:(NSArray *)msgArray;

//向消息表中插入数据
+(void)AddMessageWithArray:(NSArray *)messageArray;

//向联系人表中插入数据
+(void)addContactTableWithArray:(NSArray *)contactArray;//liu

#pragma mark-删除数据
//删除资料表内容
+(void)deleteDataFromMaterialWithFriendId:(NSString *)friendId;

//删除好友表内容
+(void)deleteDataFromFriendWithFriendId:(NSString *)friendId;

//删除消息表内容
+(void)deleteDataFromMessageWithContentId:(NSString *)contentId;

//删除和某个好友的所有消息记录
+(void)deleteAllMessageWithFriendId:(NSString *)friendId;

//删除表内容
+(void)deleteDataFromContactWithContactId:(NSString *)contactId;//liu

//清空消息记录
+(void)clearDataFromMessageWithFriendId:(NSString *)friendId SelfId:(NSString *)selfId Method:(NSString *)msgMethod;//liu

#pragma mark-更新数据

//更新好友表内容
+(void)placeSetFlag:(NSString *)flag withFriendId:(NSString *)friendId;

//更新好友表内容
+(void)updateUnreadWithFriendId:(NSString *)friendId;

//更新好友表最后一条数据
+(void)updateLastestWithMsg:(NSString *)msg WithFriendId:(NSString *)friendId;

//更新好友表时间
+(void)updateLastTime:(NSString *)time WithFriendId:(NSString *)friendId;

//更新资料表内容
+(void)updateMaterialTableContentWithFriendArray:(NSArray *)friendArray;

//更新聊天表内容
+(void)updateMessageWithContenId:(NSString *)contentId withFromId:(NSString *)fromId setFlag:(NSString *)flag setTime:(NSString *)time;

//更新语音文件本地路径
+(void)updateMessageWithContenId:(NSString *)contentId withFromId:(NSString *)fromId
                    setLocalPath:(NSString *)localPath;

//更新表内容
+(void)updateContactsWithContactArray:(NSArray *)contactarray;//liu

//更新联系人表中的flag和raltion
+(void)updateContactFlagWithFriendId:(NSString *)friendId AndFlag:(NSString *)flag AndRelation:(NSString *)relation AndReason:(NSString *)reason AndType:(NSString *)type AndGroupId:(NSString *)groupId
;//liu

#pragma mark-查询好友表中总的未读消息数目
+(int)getTotalUnreadNumberFromFriendTable;

#pragma mark-关闭数据库
+(void)closeDataBaseWhenLogout;
@end
