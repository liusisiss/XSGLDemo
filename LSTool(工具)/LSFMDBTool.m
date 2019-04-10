//
//  LSFMDBTool.m
//  ZKTD
//
//  Created by senlin on 15/6/23.
//  Copyright (c) 2015年 chanjing. All rights reserved.
//

#import "LSFMDBTool.h"

#import "LSHttpTool.h"


#define MATERIALTABLE   @"ChatMaterial"

#define CMFRIENDID      @"CMFriendID"
#define CMICON             @"CMIcon"
#define FTYPEID            @"FTypeID"
#define CMNAME          @"CMName"

#define CONTYPE   @"CONType"
#define CONID   @"CONId"
#define CONFIRSRLET   @"CONFirstLet"
#define CONNAME   @"CONName"
#define CONPICTURE   @"CONPicture"
#define CONRELATION   @"CONRelation"
#define CONREASON   @"CONReason"
#define CONGROUPID   @"CONGroupId"
#define CONLASTSYN   @"CONLastSyn"


#define FRIENDSTABLE  @"Friends"

#define FMETHOD       @"FMethod"
#define FLASTMESSAGE  @"FLastMessage"
#define FLASTTIME     @"FLastTime"
#define FTOID     @"FToID"
#define FUNREAD  @"FUnread"
#define FFLAG  @"FFlag"


#define MESSAGETABLE   @"Message"

#define MTOID                   @"MToID"
#define MCONTENTID     @"MContentID"
#define MMESSAGE        @"MMessage"
#define MLOCALPATH     @"MLocalPath"
#define MFLAG                @"MFlag"
#define MFROMTIME      @"MFromTime"
#define MTYPEID            @"MTypeID"
#define MFROMID         @"MFromID"
#define MMETHOD        @"MMethod"


#define CONTACTSTABLE @"Contacts"

#define CONTYPE   @"CONType"
#define CONID   @"CONId"
#define CONFIRSRLET   @"CONFirstLet"
#define CONNAME   @"CONName"
#define CONPICTURE   @"CONPicture"
#define CONRELATION   @"CONRelation"
#define CONREASON   @"CONReason"
#define CONGROUPID   @"CONGroupId"
#define CONLASTSYN   @"CONLastSyn"
#define CONFLAG   @"CONFlag"

@implementation LSFMDBTool



static FMDatabaseQueue *_dbQueue;
static FMDatabase *_db;



+(void)initializeWithName:(NSString *)name
{
    NSString *path = [self  getFMDBTableAdressWithName:name];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path])
    {
        [self createFMDBLibWithUserName:name];
    }
}

//创建数据库
+(void)createFMDBLibWithUserName:(NSString *)name
{
//    //拼接数据库名称
    NSString *path = [self getFMDBTableAdressWithName:name];
    _db = [FMDatabase databaseWithPath:path];
    //创建线程队列
    [self setUpDataBaseQueueWithName:name];
     //创建三张表
    [self createMaterialTable];
    [self createFriendTable];
    [self createMessageTable];
    //创建联系人表
    [self createContactsTable];
}


#pragma mark-创建数据库

//获取数据库地址
+(NSString *)getFMDBTableAdressWithName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

    NSString *path = [documentsDirectory stringByAppendingPathComponent:name];
    
    return path;
 
}
//FMDB数据库线程队列queue
+ (void)setUpDataBaseQueueWithName:(NSString *)name
{
    if (_dbQueue == nil) {
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:[self getFMDBTableAdressWithName:name]];
    }
    else
    {
        _dbQueue = nil;
        _dbQueue =  [FMDatabaseQueue databaseQueueWithPath:[self getFMDBTableAdressWithName:name]];
    }
}
//数据表操作：增，删，改
//+(BOOL)executeUpdateWithFormat:(NSString*)formatStr
//{
//    
//    if ([_db open])
//    {
//        BOOL result = [_db executeUpdate:formatStr];
//        return result;
//    }
//    return nil;
//}

//数据表操作：查询
//+(FMResultSet *)executeQueryWithFormat:(NSString*)formatStr
//{
//    
//    if ([_db open])
//    {
//        
//        FMResultSet *result = [_db executeQuery:formatStr];
//        return result;
//        
//    }
//    return nil;
//}


#pragma mark -数据表操作

// 创建“资料表”
+(void)createMaterialTable
{
    
    
//    if ([_db open])
//    {
    BOOL res = [self isTableExistWithTableName:MATERIALTABLE];

        [_dbQueue inDatabase:^(FMDatabase *db) {
            
            NSString *createMaterialTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' (ID INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT,'%@' TEXT, '%@' TEXT, '%@' TEXT)",MATERIALTABLE,CMFRIENDID,CMICON,FTYPEID,CMNAME];
//            NSLog(@"createMaterialTable = %@",createMaterialTable);
            
            
            if (!res)
            {
                [db executeUpdate:createMaterialTable];
                
//                NSLog(@"资料表创建成功");
                
            }
            else
            {
//                NSLog(@"资料表已经存在");
            }
            

        }];
//           }
    
}

// 创建“好友表”
+(void)createFriendTable
{
    
    
//    if ([_db open])
//    {
    BOOL res = [self isTableExistWithTableName:FRIENDSTABLE];

        [_dbQueue inDatabase:^(FMDatabase *db) {
            NSString *createFriendTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' (ID INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT,'%@' TEXT,'%@' TEXT,'%@' TEXT,'%@' INTEGER,  '%@' TEXT)",FRIENDSTABLE,FLASTMESSAGE,FLASTTIME, FTOID, FMETHOD,FUNREAD ,FFLAG];
//            NSLog(@"createFriendTable = %@",createFriendTable);
            
            
            if (!res)
            {
                [db executeUpdate:createFriendTable];
                
//                NSLog(@"会话好友表创建成功");
                
            }
            else
            {
//                NSLog(@"好友表已经存在");
            }
            

        }];
//           }
    
}
// 创建“消息表”
+(void)createMessageTable
{
    
    
//    if ([_db open])
//    {
    BOOL res = [self isTableExistWithTableName:MESSAGETABLE];

        [_dbQueue inDatabase:^(FMDatabase *db) {
            NSString *createMessageTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' (ID INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' TEXT, '%@' TEXT,'%@' TEXT,'%@' TEXT,'%@' TEXT,'%@' TEXT,'%@' TEXT,'%@' TEXT)",MESSAGETABLE,MTOID,MCONTENTID,MMESSAGE,MFLAG,MMETHOD, MFROMTIME,MTYPEID,MFROMID,MLOCALPATH];
//            NSLog(@"createMessageTable = %@",createMessageTable);
            
            
            if (!res)
            {
                [db executeUpdate:createMessageTable];
                
                LSLog(@"消息表创建成功");
                
            }
            else
            {
                LSLog(@"消息表已经存在");
            }
            
        }];
//            }
    
}

//创建"联系人表"
+(void)createContactsTable
{
    BOOL res = [self isTableExistWithTableName:CONTACTSTABLE];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        
        NSString *createContactsTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' (ID INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT,'%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT,'%@' TEXT)",CONTACTSTABLE,CONTYPE,CONID,CONFIRSRLET,CONNAME,CONPICTURE,CONRELATION,CONREASON,CONGROUPID,CONFLAG];
        
        if (!res) {
            [db executeUpdate:createContactsTable];
            LSLog(@"联系人表创建成功");
        }else
        {
            LSLog(@"联系人表已经存在");
        }
    }];
}


#pragma mark-往数据表中插入数据
//向资料表中插入数据
+(void)AddMaterialTableWithArray:(NSArray *)materialArray
{
    
    __block BOOL isSame;
    for(NSDictionary *dic in materialArray)
    {
        NSString *friendId = [dic objectForKey:@"friendId"];
        NSString *icon = [dic objectForKey:@"icon"];
        NSString *typeId = [dic objectForKey:@"typeId"];
        NSString *name = [dic objectForKey:@"name"];
        
               //判断数据是否已经存在
        [_dbQueue inDatabase:^(FMDatabase *db) {
            
            NSString * sqlMessage = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = '%@'",MATERIALTABLE,CMFRIENDID,friendId];
            
            FMResultSet *rs = [db executeQuery:sqlMessage];

            if ([rs next])
            {
                isSame = YES;

            }
        else
        {
            isSame = NO;
        }
            //关闭结果集
            [rs close];
               }];
        
        if (!isSame && ![friendId isEqual:[NSNull null]] && [friendId length]>0)//数据不相同
        {

                [_dbQueue inDatabase:^(FMDatabase *db) {
                    NSString *insertMaterialSql= [NSString stringWithFormat:
                                                  @"INSERT INTO '%@' ('%@', '%@', '%@','%@') VALUES ('%@', '%@', '%@','%@')",
                                                  MATERIALTABLE, CMFRIENDID, CMICON, FTYPEID, CMNAME,friendId, icon, typeId,name];
                    
                    BOOL res = [db executeUpdate:insertMaterialSql];
                    
                    
                    if (!res)
                    {
//                        NSLog(@"error when insert ChatMaterial table");
                    }
                    else
                    {
//                        NSLog(@"success to insert ChatMaterial table");
                        
                    }

                }];
               

        }
        
    }
}
+(long)getTotalUnreadToId:(NSString *)toId readFlag:(NSString *)readFlag msgArray:(NSArray *)msgArray
{
    long totalUnread = 0;
    for (NSInteger i=0; i<[msgArray count]; i++)
    {
        NSDictionary *dic = [msgArray objectAtIndex:i];
        NSString * msgToID = [dic objectForKey:@"toID"];
        NSString *fromID          = [dic objectForKey:@"fromID"];
        
        if(([toId isEqualToString:msgToID] || [toId isEqualToString:fromID]) && [readFlag isEqualToString:@"0"]) totalUnread = totalUnread+1;
    }
    return totalUnread;
}
//向好友表中插入数据
+(void)AddChatedFriendsWithArray:(NSArray *)friendsArray msgArray:(NSArray *)msgArray
{
  
    __block BOOL haveData = NO;
    __block  long unread = 0;
    NSMutableArray *mySqlArray = [NSMutableArray new];

    for(NSDictionary *dic in friendsArray)
    {
        
        NSString *method          = [dic objectForKey:@"method"];
        NSString *lastMessage = [dic objectForKey:@"lastMessage"];
        NSString *lastTime       = [dic objectForKey:@"lastTime"];
        NSString *toID      = [dic objectForKey:@"toID"];
        NSString * unREAD                 =[dic objectForKey:@"unread"];
        NSString * flag                 =[dic objectForKey:@"flag"];
        
        //判断数据是否已经存在
        [_dbQueue inDatabase:^(FMDatabase *db) {
            NSString * sqlMessage = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = '%@'",FRIENDSTABLE,FTOID,toID];
        FMResultSet *rs = [db executeQuery:sqlMessage];
        
        
        if ([rs next])//数据库有该好友的数据
        {
            haveData = YES;
            unread = [rs intForColumn:FUNREAD];
            if (unread<99 && [unREAD isEqualToString:@"0"]) unread = unread + [self getTotalUnreadToId:toID readFlag:unREAD msgArray:msgArray];
            
            NSString *updateFriendSql = [NSString stringWithFormat:
                                         @"UPDATE %@ SET %@ = '%@' ,%@ = '%@' ,%@ = '%@' ,%@ = %ld  WHERE %@ = '%@'",
                                         FRIENDSTABLE ,FLASTMESSAGE,  lastMessage,FLASTTIME,lastTime,FFLAG,flag,FUNREAD,unread,FTOID,toID];
            
            [mySqlArray addObject:updateFriendSql];
        }
            
            else//数据库是空的，新的会话
            {
                
                haveData = NO;
                if ([unREAD isEqualToString:@"0"]) unread = unread + [self getTotalUnreadToId:toID readFlag:unREAD msgArray:msgArray];
                NSString *insertFriendSql= [NSString stringWithFormat:@"INSERT INTO '%@' ( '%@','%@', '%@','%@', '%@', '%@') VALUES ( '%@', '%@','%@','%@',%ld,%@)",FRIENDSTABLE, FMETHOD, FLASTMESSAGE, FLASTTIME,FTOID,FUNREAD,FFLAG,method, lastMessage, lastTime,toID,unread,flag];
                
                [mySqlArray addObject:insertFriendSql];
            }
            //关闭结果集
            [rs close];

        }];
    }
        for(NSDictionary *dic in msgArray)
        {
            NSArray *oneTempArr = [NSArray arrayWithObject:dic];
            BOOL haveData = [self checkOutMessageTableHaveSameDataWithArray:oneTempArr];
            
            NSString * toID                = [dic objectForKey:@"toID"];
            NSString * contentID       = [dic objectForKey:@"contentID"] ;
            NSString *message          = [dic objectForKey:@"message"];
            NSString *flag                  = [dic objectForKey:@"flag"];
            NSString *fromTime      = [dic objectForKey:@"fromTime"];
            NSString *typeID           = [dic objectForKey:@"typeID"];
            NSString *fromID          = [dic objectForKey:@"fromID"];
            NSString *method         = [dic objectForKey:@"method"];
            NSString *localPath         = [dic objectForKey:@"localPath"];
            
            NSString *insertMessageSql= [NSString stringWithFormat:
                                         @"INSERT INTO '%@' ('%@', '%@', '%@','%@','%@','%@','%@','%@','%@') VALUES ('%@', '%@', '%@','%@','%@','%@','%@','%@','%@')",
                                         MESSAGETABLE, MTOID, MCONTENTID, MMESSAGE,MFLAG,MMETHOD,MFROMTIME,MTYPEID,MFROMID,MLOCALPATH,toID, contentID, message,flag,method, fromTime,typeID,fromID,localPath];
            if (!haveData) [mySqlArray addObject:insertMessageSql];
        }
        [self commitSqliteCommandWith:mySqlArray];
}
# pragma mark-执行数据库事务---操作
+(void)commitSqliteCommandWith:(NSArray *)sqlArray
  {//提高效率，更加快速的更新数据库表
        if ([sqlArray count]>0)
        {
            BOOL flag = [_db open];
            if(!flag) return;
            BOOL rollback = NO;
            [_db beginTransaction];
            @try {
                
                for (NSInteger i=0; i<[sqlArray count]; i++)
                {
                    NSString *tempSql = [sqlArray objectAtIndex:i];
                    BOOL  rs = [_db executeUpdate:tempSql];
                    if(!rs) LSLog(@"rs = error when update/insert Session table");
                    
                }
                
            } @catch (NSException *exception) {
                
                LSLog(@"rollback = %@",exception.description);
                rollback = YES;
                [_db rollback];
                
            } @finally {
                
                if (!rollback)
                {
                    [_db commit];
                    LSLog(@"success to update/insert Session table");
                }
                else LSLog(@"rs = error when update/insert Session table");
            }
            [_db close];
        }
    }

//向消息表中插入数据
+(void)AddMessageWithArray:(NSArray *)messageArray
{
    
    NSMutableArray *insertSqlArray = [NSMutableArray new];
    for(NSDictionary *dic in messageArray)
    {
        NSArray *oneTempArr = [NSArray arrayWithObject:dic];
        BOOL haveData = [self checkOutMessageTableHaveSameDataWithArray:oneTempArr];
        
        NSString * toID                = [dic objectForKey:@"toID"];
        NSString * contentID       = [dic objectForKey:@"contentID"] ;
        NSString *message          = [dic objectForKey:@"message"];
        NSString *flag                  = [dic objectForKey:@"flag"];
        NSString *fromTime      = [dic objectForKey:@"fromTime"];
        NSString *typeID           = [dic objectForKey:@"typeID"];
        NSString *fromID          = [dic objectForKey:@"fromID"];
        NSString *method         = [dic objectForKey:@"method"];
        NSString *localPath         = [dic objectForKey:@"localPath"];
        
        NSString *insertMessageSql= [NSString stringWithFormat:
                                     @"INSERT INTO '%@' ('%@', '%@', '%@','%@','%@','%@','%@','%@','%@') VALUES ('%@', '%@', '%@','%@','%@','%@','%@','%@','%@')",
                                     MESSAGETABLE, MTOID, MCONTENTID, MMESSAGE,MFLAG,MMETHOD,MFROMTIME,MTYPEID,MFROMID,MLOCALPATH,toID, contentID, message,flag,method, fromTime,typeID,fromID,localPath];
        if (!haveData) [insertSqlArray addObject:insertMessageSql];
    }
    if([insertSqlArray count]>0) [self commitSqliteCommandWith:insertSqlArray];
}

//向联系人表中插入数据
+(void)addContactTableWithArray:(NSArray *)contactArray
{
    NSMutableArray *mySqlArray = [NSMutableArray new];
    for (NSDictionary *dic in contactArray)
    {
        NSArray *tempContactArray = [NSArray arrayWithObject:dic];
        
        NSString *type = [dic objectForKey:@"type"];
        NSString *contactId = [dic objectForKey:@"contactId"];
        NSString *firstLetter = [dic objectForKey:@"firstLetter"];
        NSString *name = [dic objectForKey:@"name"];
        NSString *picture = [dic objectForKey:@"pic"];
        NSString *relation = [dic objectForKey:@"relation"];
        NSString *reason = [dic objectForKey:@"reason"];
        
        NSString *groupId = [dic objectForKey:@"groupId"];
        NSString *flag = [NSString stringWithFormat:@"%@",[dic objectForKey:@"flag"]];
        
        if ([relation intValue] == 0)
        {
            NSString *deleteContactSql = [NSString stringWithFormat:
                                          @"DELETE FROM %@ WHERE %@ = '%@'",
                                          CONTACTSTABLE, CONID, contactId];
            NSString *deleteFriendSql = [NSString stringWithFormat:
                                         @"DELETE FROM %@ WHERE %@ = '%@'",
                                         FRIENDSTABLE, FTOID, contactId];
            NSString *deleteMessageSql = [NSString stringWithFormat:
                                          @"DELETE FROM %@ WHERE %@ = %@",
                                          MESSAGETABLE, MTOID, contactId ];
            [mySqlArray addObject:deleteContactSql];
            [mySqlArray addObject:deleteFriendSql];
            [mySqlArray addObject:deleteMessageSql];
        }
        else
        {
            BOOL haveSaveData = [self checkOutContactTableHaveSameDataWithArray:tempContactArray];
            if (!haveSaveData)
            {
                NSString *insertMessageSql = [NSString stringWithFormat:@"INSERT INTO '%@' ('%@','%@','%@', '%@','%@','%@','%@','%@','%@') VALUES ('%@','%@', '%@','%@','%@','%@','%@','%@','%@')",CONTACTSTABLE,CONFLAG,CONTYPE,CONID,CONFIRSRLET,CONNAME,CONPICTURE,CONRELATION,CONREASON,CONGROUPID,flag,type,contactId,firstLetter,name,picture,relation,reason,groupId];
                [mySqlArray addObject:insertMessageSql];
            }
            else
            {
                if ([type intValue] == 0 || [type intValue] == 1 ) {
                    NSString * updateContactSql = [NSString stringWithFormat:@"UPDATE %@ SET %@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@' WHERE %@ = '%@' AND %@ = '%@'",CONTACTSTABLE,CONFIRSRLET,firstLetter,CONNAME,name,CONPICTURE,picture,CONRELATION,relation,CONREASON,reason,CONGROUPID,groupId,CONFLAG,flag,CONID,contactId,CONTYPE,type];
                    [mySqlArray addObject:updateContactSql];
                    
                }
                else if ([type intValue] == 2 && [relation intValue]==3){//群组成员
                    NSString * updateContactSql = [NSString stringWithFormat:@"UPDATE %@ SET %@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@' WHERE %@ = '%@' AND %@ = '%@' AND %@ = '%@' AND %@ = %@",CONTACTSTABLE,CONFIRSRLET,firstLetter,CONNAME,name,CONPICTURE,picture,CONREASON,reason,CONFLAG,flag,CONID,contactId,CONTYPE,type,CONRELATION,relation,CONGROUPID,groupId];
                    [mySqlArray addObject:updateContactSql];
                }
            }
        }
    }
    [self commitSqliteCommandWith:mySqlArray];
}

#pragma mark-置顶
+(void)placeSetFlag:(NSString *)flag withFriendId:(NSString *)friendId
{
    //判断数据是否已经存在
    __block  NSString *flagDB;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString * sqlMessage = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = '%@'",FRIENDSTABLE,FTOID,friendId];
        FMResultSet *rs = [db executeQuery:sqlMessage];
        
        if ([rs next])//数据库有该好友的数据
        {
           flagDB = [rs objectForColumnName:FFLAG];
           
        }
        
        //关闭结果集
        [rs close];
        
    }];

    if ([SSLToolMethod isBlankString:flagDB])
    {
        [self doNeedUpdateFlagWith:flag andFriendId:friendId];
    }
    
}
//  确实需要更新flag
+(void)doNeedUpdateFlagWith:(NSString *)flag  andFriendId:(NSString *)friendId
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *updateFriendSql = [NSString stringWithFormat:
                                     @"UPDATE %@ SET %@ = %@ WHERE %@ = '%@'",
                                     FRIENDSTABLE,   FFLAG,  flag ,FTOID,  friendId];
        
        //            NSLog(@"updateSql = %@",updateFriendSql);
        BOOL res = [db executeUpdate:updateFriendSql];
        if (res) {
            //                NSLog(@"flag-成功");
        } else {
            //                NSLog(@"flag-失败");
        }
        
        
    }];

}
#pragma mark-更新表内容
//更新会话好友表内容
+(void)updateUnreadWithFriendId:(NSString *)friendId
{
    
 
    
        [_dbQueue inDatabase:^(FMDatabase *db) {
            NSString *updateFriendSql = [NSString stringWithFormat:
                                         @"UPDATE %@ SET %@ = %@ WHERE %@ = '%@'",
                                         FRIENDSTABLE,   FUNREAD,  @"0" ,FTOID,  friendId];
            
//            NSLog(@"updateSql = %@",updateFriendSql);
            BOOL res = [db executeUpdate:updateFriendSql];
            if (res) {
//                NSLog(@"更新未读数-成功");
            } else {
//                NSLog(@"更新未读数-失败");
            }
            
 
        }];
         
    
}

//更新好友表最后一条数据
+(void)updateLastestWithMsg:(NSString *)msg WithFriendId:(NSString *)friendId
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *updateFriendSql = [NSString stringWithFormat:
                                     @"UPDATE %@ SET %@ = '%@' WHERE %@ = '%@'",
                                     FRIENDSTABLE,   FLASTMESSAGE,  msg ,FTOID,  friendId];
        
        BOOL res = [db executeUpdate:updateFriendSql];
        if (res) {
            //                NSLog(@"更新未读数-成功");
        } else {
            //                NSLog(@"更新未读数-失败");
        }
        
        
    }];

}
//更新好友表时间
+(void)updateLastTime:(NSString *)time WithFriendId:(NSString *)friendId
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *updateFriendSql = [NSString stringWithFormat:
                                     @"UPDATE %@ SET %@ = '%@' WHERE %@ = '%@'",
                                     FRIENDSTABLE,   FLASTTIME,  time ,FTOID,  friendId];
        
//        NSLog(@"updateSql = %@",updateFriendSql);
        BOOL res = [db executeUpdate:updateFriendSql];
        if (res) {
//            NSLog(@"更新好友表时间-成功");
        } else {
//            NSLog(@"更新好友表时间-失败");
        }
        
        
    }];


}
//更新资料表内容
+(void)updateMaterialTableContentWithFriendArray:(NSArray *)friendArray
{
    for(NSDictionary *dict in friendArray)
    {
        NSString *friendId = [dict objectForKey:@"friendId"];
        NSString *icon = [dict objectForKey:@"icon"];
        NSString *name = [dict objectForKey:@"name"];
        [_dbQueue inDatabase:^(FMDatabase *db) {
            NSString *updateMaterialSql = [NSString stringWithFormat:
                                           @"UPDATE %@ SET %@ = '%@',%@ = '%@' WHERE %@ = '%@'",
                                           MATERIALTABLE,   CMNAME,  name ,CMICON,icon,CMFRIENDID,  friendId];
            
//            NSLog(@"updateSql = %@",updateMaterialSql);
            BOOL res = [db executeUpdate:updateMaterialSql];
            if (res) {
//                NSLog(@"资料-数据更新成功");
            } else {
//                NSLog(@"资料-数据更新失败");
            }
            
            
        }];

    }
    
    
}

//更新聊天表内容
+(void)updateMessageWithContenId:(NSString *)contentId withFromId:(NSString *)fromId setFlag:(NSString *)flag setTime:(NSString *)time
{
    BOOL flagOpen = [_db open];
    if(!flagOpen) return;
    
    NSString *updateMessageSql = [NSString stringWithFormat:
                                  @"UPDATE %@ SET %@ = '%@' ,%@ = '%@'  WHERE %@ = '%@' AND %@ = '%@'",
                                  MESSAGETABLE,   MFLAG,  flag ,MFROMTIME,time,MCONTENTID,  contentId ,MTOID,fromId];//
    
    [_db beginTransaction];
    @try {
        
        BOOL  rs = [_db executeUpdate:updateMessageSql];
        if(!rs) LSLog(@"rs = error when updateMessage table");
        
    } @catch (NSException *exception) {
        
        [_db rollback];
        
        
    } @finally {
        
        [_db commit];
        LSLog(@"success to updateMessage table");
    }
    [_db close];
}
//更新语音文件本地路径
+(void)updateMessageWithContenId:(NSString *)contentId withFromId:(NSString *)fromId
                    setLocalPath:(NSString *)localPath
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *updateMessageSql = [NSString stringWithFormat:
                                      @"UPDATE %@ SET %@ = '%@'  WHERE %@ = %@ AND %@=%@",
                                      MESSAGETABLE,   MLOCALPATH,  localPath ,MCONTENTID,  contentId ,MFROMID,fromId];
        
        //            NSLog(@"updateSql = %@",updateMessageSql);
        
        BOOL res = [db executeUpdate:updateMessageSql];
        
        if (res) {
            LSLog(@"消息表-localPath更新成功");
        } else {
            LSLog(@"消息表-localPath更新失败");
        }
        
    }];

}
//更新联系人表内容
+(void)updateContactsWithContactArray:(NSArray *)contactarray
{
    
    for (NSDictionary *dic in contactarray) {
        
        NSString *type = [dic objectForKey:@"type"];
        NSString *contactId = [dic objectForKey:@"contactId"];
        NSString *firstLetter = [dic objectForKey:@"firstLetter"];
        NSString *name = [dic objectForKey:@"name"];
        NSString *picture = [dic objectForKey:@"pic"];
        NSString *relation = [dic objectForKey:@"relation"];
        NSString *reason = [dic objectForKey:@"reason"];
        
        NSString *groupId = [dic objectForKey:@"groupId"];
        NSString *flag = [dic objectForKey:@"flag"];
        
        [_dbQueue inDatabase:^(FMDatabase *db) {
            
            NSString *updateContactSql;
            if ([type intValue] == 0 || [type intValue] == 1 ) {
                updateContactSql = [NSString stringWithFormat:@"UPDATE %@ SET %@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@' WHERE %@ = '%@' AND %@ = '%@'",CONTACTSTABLE,CONFIRSRLET,firstLetter,CONNAME,name,CONPICTURE,picture,CONRELATION,relation,CONREASON,reason,CONGROUPID,groupId,CONFLAG,flag,CONID,contactId,CONTYPE,type];
            }else if ([type intValue] == 2 && [relation intValue]==3){//群组成员
                 updateContactSql = [NSString stringWithFormat:@"UPDATE %@ SET %@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@' WHERE %@ = '%@' AND %@ = '%@' AND %@ = '%@' AND %@ = %@",CONTACTSTABLE,CONFIRSRLET,firstLetter,CONNAME,name,CONPICTURE,picture,CONREASON,reason,CONFLAG,flag,CONID,contactId,CONTYPE,type,CONRELATION,relation,CONGROUPID,groupId];
            }
            
            
            BOOL res = [db executeUpdate:updateContactSql];
            if (res) {
                LSLog(@"联系人数据更新成功");

            }else{
                LSLog(@"联系人数据更新失败");
            }
        }];
    }
}

//更新联系人表中的flag和raltion,reason
+(void)updateContactFlagWithFriendId:(NSString *)friendId AndFlag:(NSString *)flag AndRelation:(NSString *)relation AndReason:(NSString *)reason AndType:(NSString *)type AndGroupId:(NSString *)groupId
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *updateMessageSql;
        if ([type intValue] == 1) {//群组
            updateMessageSql = [NSString stringWithFormat:
                                @"UPDATE %@ SET %@ = '%@',%@ = '%@',%@ = '%@' WHERE %@ = %@ AND %@ = %@ AND %@ = %@",
                                CONTACTSTABLE, CONFLAG, flag,CONRELATION,relation,CONREASON,reason,CONID,friendId,CONTYPE,type,CONGROUPID,groupId];
        }else{
        updateMessageSql = [NSString stringWithFormat:
                                      @"UPDATE %@ SET %@ = '%@',%@ = '%@',%@ = '%@' WHERE %@ = %@ AND %@ = %@",
                                      CONTACTSTABLE, CONFLAG, flag,CONRELATION,relation,CONREASON,reason,CONID,friendId,CONTYPE,type];
        }
        //            NSLog(@"updateSql = %@",updateMessageSql);
        
        BOOL res = [db executeUpdate:updateMessageSql];
        
        if (res) {
            LSLog(@"Contact-flag,relation数据更新成功");
        } else {
            LSLog(@"Contact-flag,relation数据更新失败");
        }
        
    }];
}

#pragma mark-取出表内容
//取出资料表内容
+(NSArray *)getDataFromMaterialTable
{
//    NSString *ID = @"ID";
    NSMutableArray *dataArray = [NSMutableArray array];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString * sqlMaterial = [NSString stringWithFormat:
                                  @"SELECT * FROM %@",MATERIALTABLE];
//        FMResultSet * rs = [self executeQueryWithFormat:sqlMaterial];
        FMResultSet *rs = [db executeQuery:sqlMaterial];

        while ([rs next])
        {
//            int Id = [rs intForColumn:ID] ;
            
            NSString * name = [rs stringForColumn:CMFRIENDID];
            NSString * icon = [rs stringForColumn:CMICON];
            NSString * address = [rs stringForColumn:FTYPEID];
            NSString *friendId = [rs stringForColumn:CMFRIENDID];
            //将表内容存到字典里
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:name,@"name",icon,@"icon",address,@"address",friendId,@"friendId", nil];
            //将字典添加到数组
            [dataArray addObject:dict];
//            NSLog(@"id = %d, name = %@, icon = %@  address = %@,friendId=%@" , Id, name, icon, address,friendId);
        }
        //关闭结果集
        [rs close];

    }];
    NSArray *resultArray = [dataArray copy];
    return resultArray;
}

//取出会话好友表内容
+(NSArray *)getDataFromFriendsTable
{
//    NSString *ID = @"ID";
    NSMutableArray *dataArray = [NSMutableArray array];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString * sqlFriend = [NSString stringWithFormat:
                                @"SELECT * FROM %@ order by FFlag desc , FLastTime desc",FRIENDSTABLE];
        
        FMResultSet *rs = [db executeQuery:sqlFriend];

        while ([rs next])
        {
            
            NSString * method = [rs stringForColumn:FMETHOD] ;
            NSString * lastMessage = [rs stringForColumn:FLASTMESSAGE];
            NSString * lastTime = [rs stringForColumn:FLASTTIME];
            
            NSString * toID = [rs stringForColumn:FTOID];
            NSString * flag = [rs stringForColumn:FFLAG];
            NSString * unread = [rs stringForColumn:FUNREAD];
            
            //将表内容存到字典里
            NSMutableDictionary *dict = [NSMutableDictionary new];
            if (method && [method length]>0) {
                [dict setValue:method forKey:@"method"];
            }
            if (lastMessage && [lastMessage length]>0) {
                [dict setValue:lastMessage forKey:@"lastMessage"];
            }
            if (lastTime && [lastTime length]>0) {
                [dict setValue:lastTime forKey:@"lastTime"];
            }
            if (toID && [toID length]>0) {
                [dict setValue:toID forKey:@"toID"];
            }
            if (flag && [flag length]>0) {
                [dict setValue:flag forKey:@"flag"];
            }
            if (unread && [unread length]>0) {
                [dict setValue:unread forKey:@"unread"];
            }

            //将字典添加到数组
            [dataArray addObject:dict];
//            NSLog(@"id = %d, lastMessage = %@, lastTime = %@  ,toID = %@", Id, lastMessage, lastTime,toID);
        }
        //关闭结果集
        [rs close];

    }];
        NSArray *resultArray = [dataArray copy];
    return resultArray;
    
}
//取出消息表内容
+(NSArray *)getDataFromMessageTableWithFromId:(NSString *)fromId andToId:(NSString *)toId andPage:(NSInteger)page

{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString * sqlMessage = [NSString stringWithFormat:
                                 @"SELECT * FROM %@ order by MFromTime desc , MContentID desc",MESSAGETABLE];
        
        FMResultSet *rs = [db executeQuery:sqlMessage];

        while ([rs next])
        {
            
            NSString * toID = [rs stringForColumn:MTOID] ;
            
            NSString * contentID = [rs stringForColumn:MCONTENTID];
            NSString * message = [rs stringForColumn:MMESSAGE];
            NSString *flag = [rs stringForColumn:MFLAG];
            NSString * method = [rs stringForColumn:MMETHOD];
            NSString * fromTime = [rs stringForColumn:MFROMTIME];
            NSString * typeID = [rs stringForColumn:MTYPEID];
            NSString * fromID = [rs stringForColumn:MFROMID];
            NSString *localPath = [rs stringForColumn:MLOCALPATH];
            //将表内容存到字典里
            
            if (([toID isEqualToString:toId] &&[fromID isEqualToString:fromId]) || ([toID isEqualToString:fromId] &&[fromID isEqualToString:toId]))
            {
                NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:toID,@"toID",contentID,@"contentID",message,@"message",flag,@"flag",method,@"method",fromTime,@"fromTime",typeID,@"typeID",fromID,@"fromID",localPath,@"localPath",nil];
                //将字典添加到数组
                if ( [dataArray count] <= page*19)
                {
                    [dataArray addObject:dict];
                }
            }
            
            //        NSLog(@"belongID = %@, belongID = %@, contentID = %@  message = %@", belongID, belongID, contentID, message);
        }
        //关闭结果集
        [rs close];

    }];
    NSArray *resultArray = [dataArray copy];
    resultArray = [[resultArray reverseObjectEnumerator] allObjects];
    return resultArray;
    
}

//从消息表取出数据内容－－－sisiliu
+(NSArray *)getDataFromMessageTableWithFromId:(NSString *)fromId andToId:(NSString *)toId andPage:(NSInteger)page andMethod:(NSString *)mesMethod
{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString * sqlMessage = [NSString stringWithFormat:
                                 @"SELECT * FROM %@ order by MFromTime desc , MContentID desc",MESSAGETABLE];
        
        FMResultSet *rs = [db executeQuery:sqlMessage];
        
        while ([rs next])
        {
            
            NSString * toID = [rs stringForColumn:MTOID] ;
            
            NSString * contentID = [rs stringForColumn:MCONTENTID];
            NSString * message = [rs stringForColumn:MMESSAGE];
            NSString *flag = [rs stringForColumn:MFLAG];
            NSString * method = [rs stringForColumn:MMETHOD];
            NSString * fromTime = [rs stringForColumn:MFROMTIME];
            NSString * typeID = [rs stringForColumn:MTYPEID];
            NSString * fromID = [rs stringForColumn:MFROMID];
            NSString *localPath = [rs stringForColumn:MLOCALPATH];
            
            if ([mesMethod isEqualToString:@"gmsg"]) {
                if ([method isEqualToString:@"gmsg"] && [toID isEqualToString:toId]) {
                    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:toID,@"toID",contentID,@"contentID",message,@"message",flag,@"flag",method,@"method",fromTime,@"fromTime",typeID,@"typeID",fromID,@"fromID",localPath,@"localPath",nil];
                    //将字典添加到数组
                    if ( [dataArray count] <= page*19) {
                        
                        [dataArray addObject:dict];
                        
                    }
                }
                
            }else{
                //将表内容存到字典里
                if (([toID isEqualToString:toId] &&[fromID isEqualToString:fromId]) || ([toID isEqualToString:fromId] &&[fromID isEqualToString:toId]))
                {
                    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:toID,@"toID",contentID,@"contentID",message,@"message",flag,@"flag",method,@"method",fromTime,@"fromTime",typeID,@"typeID",fromID,@"fromID",localPath,@"localPath",nil];
                    //将字典添加到数组
                    if ( [dataArray count] <= page*19) {
                        
                        [dataArray addObject:dict];
                        
                    }
                }
            }
            
            
            //        NSLog(@"belongID = %@, belongID = %@, contentID = %@  message = %@", belongID, belongID, contentID, message);
        }
        //关闭结果集
        [rs close];
        
    }];
    NSArray *resultArray = [dataArray copy];
    resultArray = [[resultArray reverseObjectEnumerator] allObjects];
    return resultArray;
}
//取出联系人表内容
+(NSArray *)getDataFromContactTable
{
    NSString *ID = @"ID";
    NSMutableArray *dataArray = [NSMutableArray array];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString * sqlContact = [NSString stringWithFormat:
                                 @"SELECT * FROM %@",CONTACTSTABLE];
        FMResultSet *rs = [db executeQuery:sqlContact];
        while ([rs next]) {
//            int Id = [rs intForColumn:ID];
            
            NSString *type = [rs stringForColumn:CONTYPE];
            NSString *contactId = [rs stringForColumn:CONID];
            NSString *firstLetter = [rs stringForColumn:CONFIRSRLET];
            NSString *name = [rs stringForColumn:CONNAME];
            NSString *picture = [rs stringForColumn:CONPICTURE];
            NSString *relation = [rs stringForColumn:CONRELATION];
            NSString *reason = [rs stringForColumn:CONREASON];
            
            NSString *groupId = [rs stringForColumn:CONGROUPID];
            NSString *flag = [rs stringForColumn:CONFLAG];
            
            //将表内容存到字典里
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:type,@"type",contactId,@"contactId",firstLetter,@"firstLetter",name,@"name",picture,@"pic",relation,@"relation",reason,@"reason",groupId,@"groupId",flag,@"flag", nil];
            //将字典添加到数组
            [dataArray addObject:dict];
        }
        //关闭结果集
        [rs close];
    }];
    NSArray *resultArr = [dataArray copy];
    return resultArr;
}

#pragma mark- 模糊查询消息表
+(NSArray *)getMsgWithKeyWord:(NSString *)keyWord andFriendID:(NSString *)friendID
{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString * sqlMessage = [NSString stringWithFormat:
                                 @"SELECT * FROM %@ WHERE  %@= %@ AND %@ LIKE '%%%@%%'ORDER BY MFromTime desc",MESSAGETABLE,MTYPEID, @"0",MMESSAGE ,keyWord];
        
        FMResultSet *rs = [db executeQuery:sqlMessage];
        
        while ([rs next])
        {
            
            NSString * toID = [rs stringForColumn:MTOID] ;
            
            NSString * contentID = [rs stringForColumn:MCONTENTID];
            NSString * message = [rs stringForColumn:MMESSAGE];
            NSString *flag = [rs stringForColumn:MFLAG];
            NSString * method = [rs stringForColumn:MMETHOD];
            NSString * fromTime = [rs stringForColumn:MFROMTIME];
            NSString * typeID = [rs stringForColumn:MTYPEID];
            NSString * fromID = [rs stringForColumn:MFROMID];
            
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:toID,@"toID",contentID,@"contentID",message,@"message",flag,@"flag",method,@"method",fromTime,@"fromTime",typeID,@"typeID",fromID,@"fromID",nil];
            
            //将字典添加到数组
            //将表内容存到字典里
            if (([friendID isEqualToString:toID]  || [fromID isEqualToString:friendID]))
            {
                [dataArray addObject:dict];
            }
            
        }
        //关闭结果集
        [rs close];
        
    }];
    NSArray *resultArray = [dataArray copy];
    resultArray = [[resultArray reverseObjectEnumerator] allObjects];
    return resultArray;

}
#pragma mark-取出消息表中flag为-1的消息
+(NSArray *)getSendingMessageFromMessageTable
{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString * sqlMessage = [NSString stringWithFormat:
                                 @"SELECT * FROM %@ WHERE %@ = '%@' OR %@ = '%@'",MESSAGETABLE,MFLAG ,@"-1",MFLAG,@"0"];
        
        FMResultSet *rs = [db executeQuery:sqlMessage];

        while ([rs next])
        {
            
            NSString * toID = [rs stringForColumn:MTOID] ;
            
            NSString * contentID = [rs stringForColumn:MCONTENTID];
            NSString * message = [rs stringForColumn:MMESSAGE];
            NSString *flag = [rs stringForColumn:MFLAG];
            NSString * method = [rs stringForColumn:MMETHOD];
            NSString * fromTime = [rs stringForColumn:MFROMTIME];
            NSString * typeID = [rs stringForColumn:MTYPEID];
            NSString * fromID = [rs stringForColumn:MFROMID];
            NSString *localPath = [rs stringForColumn:MLOCALPATH];

            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:toID,@"toID",contentID,@"contentID",message,@"message",flag,@"flag",method,@"method",fromTime,@"fromTime",typeID,@"typeID",fromID,@"fromID",localPath,@"localPath",nil];
            
            //将字典添加到数组
            [dataArray addObject:dict];
            
        }
        //关闭结果集
        [rs close];

    }];
    NSArray *resultArray = [dataArray copy];
    resultArray = [[resultArray reverseObjectEnumerator] allObjects];
    return resultArray;

}

#pragma mark-根据消息id取出toid
+(NSString *)getFriendIDWithMsgID:(NSString *)msgID
{
    
    __block  NSString *friendID;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString * sqlMessage = [NSString stringWithFormat:
                                 @"SELECT * FROM %@ WHERE MContentID='%@'",MESSAGETABLE,msgID];
        
        FMResultSet *rs = [db executeQuery:sqlMessage];
        
        while ([rs next])
        {
            friendID = [rs stringForColumn:MTOID];
        }
        //关闭结果集
        [rs close];
        
    }];
    
    return friendID;
}

#pragma mark 根据好友ID,取出对应联系人表中的Flag
+(NSString *)getContactFlagWithFriendId:(NSString *)friendId andType:(NSString *)type
{
    __block  NSString *friendFlag;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString * sqlMessage = [NSString stringWithFormat:
                                 @"SELECT * FROM %@ WHERE %@='%@' AND %@ = '%@'",CONTACTSTABLE,CONID,friendId,CONTYPE,type];
        
        FMResultSet *rs = [db executeQuery:sqlMessage];
        
        while ([rs next])
        {
            friendFlag = [rs stringForColumn:CONFLAG];
        }
        //关闭结果集
        [rs close];
        
    }];
    
    return friendFlag;
}

#pragma mark-检测资料表是否有数据
//检测资料表是否有数据
+(int)checkOutMaterialDataWithFriendId:(NSString *)FriendId
{
   __block int  count ;
    //判断数据是否已经存在
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString * sqlMessage = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE CMFriendID = '%@'",MATERIALTABLE,FriendId];
        
//        FMResultSet * rs =  [self executeQueryWithFormat:sqlMessage];
        FMResultSet *rs = [db executeQuery:sqlMessage];

        if ([rs next])
        {
            
            count = 1;
            
        }
        else
        {
            count = 0;
        }
        
        [rs close];
    }];
    
    return count;
}

//检测消息表是否有数据
+(BOOL)checkOutMessageTableHaveSameDataWithArray:(NSArray*)messageArray
{
    __block BOOL  haveSameData = false ;
    //判断数据是否已经存在
    
    for(NSDictionary *dic in messageArray)
    {
        NSString * contentID       = [dic objectForKey:@"contentID"] ;
        NSString *fromID          = [dic objectForKey:@"fromID"];
        
        NSLock *myLock = [[NSLock alloc] init];
        [myLock lock];
        //判断数据是否已经存在
        [_dbQueue inDatabase:^(FMDatabase *db) {
            NSString * sqlMessage = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = '%@' AND %@ = '%@'",MESSAGETABLE,MCONTENTID,contentID,MFROMID,fromID];
            
            FMResultSet *rs = [db executeQuery:sqlMessage];
            
            if ([rs next])
            {
                
                haveSameData = YES;
                
//                NSLog(@"有相同数据");
            }
            else
            {
                haveSameData = NO;
                
            }
            //关闭结果集
            [rs close];
            
        }];
        [myLock unlock];
        
    }
    BOOL result = (BOOL)haveSameData;
    return result;
    
}

//检测联系人表是否有数据
+(int)chekOutContactDataWithContactId:(NSString *)contactId
{
    __block int  count ;
    
    //判断数据是否已经存在
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString * sqlMessage = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE CONID = '%@'",CONTACTSTABLE,contactId];
        FMResultSet *rs = [db executeQuery:sqlMessage];
        if ([rs next]) {
            count = 1;
        }else
        {
            count = 0;
        }
        [rs close];
        
    }];
    return count;
}
//检查联系人表是否有相同数据
+(BOOL)checkOutContactTableHaveSameDataWithArray:(NSArray*)messageArray
{
    __block BOOL  haveSameData = false ;
    //判断数据是否已经存在
    
    for(NSDictionary *dic in messageArray)
    {
        NSString * contactId       = [dic objectForKey:@"contactId"] ;
        NSString *type          = [dic objectForKey:@"type"];
//        NSString *relation    = [dic objectForKey:@"relation"];
        NSString *groupId  = [dic objectForKey:@"groupId"];
        
        NSLock *myLock = [[NSLock alloc] init];
        [myLock lock];
        //判断数据是否已经存在
        [_dbQueue inDatabase:^(FMDatabase *db) {
            
            NSString * sqlMessage;
            if ([type intValue] == 2) {//如果是群组成员
                sqlMessage = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = '%@' AND %@ = '%@' AND %@ = '%@'",CONTACTSTABLE,CONID,contactId,CONTYPE,type,CONGROUPID,groupId];
            }else{
                sqlMessage = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = '%@' AND %@ = '%@'",CONTACTSTABLE,CONID,contactId,CONTYPE,type];
            }
            
            
            FMResultSet *rs = [db executeQuery:sqlMessage];
            
            if ([rs next])
            {
                
                haveSameData = YES;
                
                LSLog(@"联系人表里有相同数据");
            }
            else
            {
                haveSameData = NO;
                LSLog(@"联系人表里没有相同数据");
                
            }
            //关闭结果集
            [rs close];
            
        }];
        [myLock unlock];
        
    }
    BOOL result = (BOOL)haveSameData;
    return result;
    
}
//从联系人表获得用户名
+(NSString *)getNameformContactWithFriendId:(NSString *)friendId
{
    __block NSString *name;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString * sqlMessage = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE CONId = '%@'",CONTACTSTABLE,friendId];
        
        FMResultSet *rs = [db executeQuery:sqlMessage];
        
        if ([rs next])
        {
            name = [rs stringForColumn:CONNAME];
            
        }
        //关闭结果集
        [rs close];
        
    }];
    
    
    if ([name length]>0) {
        return name;
    }
    return nil;

}
// 从联系人表获取好友的头像
+(NSString *)getIconURlformContactWithFriendId:(NSString *)friendId
{
    __block NSString *iconURL;
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString * sqlMessage = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE CONId = '%@'",CONTACTSTABLE,friendId];
        
        //        FMResultSet * rs =  [self executeQueryWithFormat:sqlMessage];
        FMResultSet *rs = [db executeQuery:sqlMessage];
        
        if ([rs next])
        {
            iconURL = [rs stringForColumn:CONPICTURE];
            
        }
        //关闭结果集
        [rs close];
        
    }];
    
    if ([iconURL length] > 0) {
        return iconURL;
    }
    return nil;

}

//获取用户名
+(NSString *)getNameformMaterialWithFriendId:(NSString *)FriendId
{
     __block NSString *name;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString * sqlMessage = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE CMFriendID = '%@'",MATERIALTABLE,FriendId];
        
        FMResultSet *rs = [db executeQuery:sqlMessage];

        if ([rs next])
        {
          name = [rs stringForColumn:CMNAME];
            
        }
        //关闭结果集
        [rs close];

    }];
    
    
    if ([name length]>0) {
        return name;
    }
        return nil;
}

//获取用户头像
+(NSString *)getIconURlformMaterialWithFriendId:(NSString *)FriendId
{
   __block NSString *iconURL;
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString * sqlMessage = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE CMFriendID = '%@'",MATERIALTABLE,FriendId];
        
//        FMResultSet * rs =  [self executeQueryWithFormat:sqlMessage];
        FMResultSet *rs = [db executeQuery:sqlMessage];

        if ([rs next])
        {
            iconURL = [rs stringForColumn:CMICON];
            
        }
        //关闭结果集
        [rs close];

    }];
    
    if ([iconURL length] > 0) {
        return iconURL;
    }
    return nil;

}
#pragma mark-删除各个表的内容
//删除资料表内容
+(void)deleteDataFromMaterialWithFriendId:(NSString *)friendId
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *deleteMaterialSql = [NSString stringWithFormat:
                                       @"DELETE FROM %@ WHERE %@ = '%@'",
                                       MATERIALTABLE, CMFRIENDID, friendId];
        
//        NSLog(@"deleteSql = %@",deleteMaterialSql);
        BOOL res = [db executeUpdate:deleteMaterialSql];

        if (!res) {
//            NSLog(@"error when delete Material table");
        } else {
//            NSLog(@"success to delete Material table");
        }

    }];
    
    
}
//删除好友表内容
+(void)deleteDataFromFriendWithFriendId:(NSString *)friendId
{
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *deleteFriendSql = [NSString stringWithFormat:
                                     @"DELETE FROM %@ WHERE %@ = '%@'",
                                     FRIENDSTABLE, FTOID, friendId];
        
//        NSLog(@"deleteSql = %@",deleteFriendSql);
        BOOL res = [db executeUpdate:deleteFriendSql];

        if (!res) {
//            NSLog(@"error when delete friendId table");
        } else {
//            NSLog(@"success to delete friendId table");
        }
        

    }];
    
}

//删除消息表内容
+(void)deleteDataFromMessageWithContentId:(NSString *)contentId
{
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *deleteMessageSql = [NSString stringWithFormat:
                                      @"DELETE FROM %@ WHERE %@ = '%@'",
                                      MESSAGETABLE, MCONTENTID, contentId ];
        
//        NSLog(@"deleteSql = %@",deleteMessageSql);
//        BOOL res = [self executeUpdateWithFormat:deleteMessageSql];
        BOOL res = [db executeUpdate:deleteMessageSql];

        if (!res) {
//            NSLog(@"error when delete message from table");
        } else {
//            NSLog(@"success to delete message from table");
        }

    }];
    
    
}

//删除和某个好友的所有消息记录
+(void)deleteAllMessageWithFriendId:(NSString *)friendId
{
    NSString *deleteMessageSql = [NSString stringWithFormat:
    @"DELETE FROM %@ WHERE %@ = %@ OR %@ = %@",MESSAGETABLE, MTOID, friendId ,MFROMID,friendId];
    NSMutableArray *deleteSqlArray = [NSMutableArray new];
    [deleteSqlArray addObject:deleteMessageSql];
    [self commitSqliteCommandWith:deleteSqlArray];
    
}
//删除表内容
+(void)deleteDataFromContactWithContactId:(NSString *)contactId
{
    NSMutableArray *mySqlArray = [NSMutableArray new];
    
    NSString *deleteContactSql = [NSString stringWithFormat:
                                  @"DELETE FROM %@ WHERE %@ = '%@'",
                                  CONTACTSTABLE, CONID, contactId];
    NSString *deleteFriendSql = [NSString stringWithFormat:
                                 @"DELETE FROM %@ WHERE %@ = '%@'",
                                 FRIENDSTABLE, FTOID, contactId];
    NSString *deleteMessageSql = [NSString stringWithFormat:
                                  @"DELETE FROM %@ WHERE %@ = %@",
                                  MESSAGETABLE, MTOID, contactId ];
    [mySqlArray addObject:deleteContactSql];
    [mySqlArray addObject:deleteFriendSql];
    [mySqlArray addObject:deleteMessageSql];
    
    BOOL flag = [_db open];
    if(!flag) return;
    [_db beginTransaction];
    @try {
        
        for (NSInteger i=0; i<[mySqlArray count]; i++)
        {
            NSString *tempSql = [mySqlArray objectAtIndex:i];
            BOOL  rs = [_db executeUpdate:tempSql];
            if(!rs) LSLog(@"error when delete Contact table");
        }
        
    } @catch (NSException *exception) {
        
        [_db rollback];
        
        
    } @finally {
        
        [_db commit];
        LSLog(@"success to delete Contact table");
    }
    [_db close];
}

//清空消息记录
+(void)clearDataFromMessageWithFriendId:(NSString *)friendId SelfId:(NSString *)selfId Method:(NSString *)msgMethod
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        
        NSString *deleteMessageSql;
        
        if ([msgMethod isEqualToString:@"msg"]) {//单聊
            deleteMessageSql = [NSString stringWithFormat:
                                @"DELETE FROM %@ WHERE (%@ = %@ AND %@ = '%@' AND %@ = %@) OR (%@ = %@ AND %@ = '%@' AND %@ = %@)",
                                MESSAGETABLE, MTOID, friendId,MMETHOD,msgMethod,MFROMID,selfId,MTOID,selfId,MMETHOD,msgMethod,MFROMID,friendId];
        }else{//群聊
            deleteMessageSql = [NSString stringWithFormat:
                                @"DELETE FROM %@ WHERE (%@ = %@ OR %@ = %@) AND %@ = '%@'",
                                MESSAGETABLE,MFROMID,friendId,MTOID,friendId,MMETHOD,msgMethod];
        }
        
        
       
        BOOL res = [db executeUpdate:deleteMessageSql];
        
        if (!res) {
                        LSLog(@"error when clear message from table");
        } else {
                        LSLog(@"success to clear message from table");
        }
        
    }];
}

#pragma mark-  判断数据表是否存在
+(BOOL)isTableExistWithTableName:(NSString *)tableName
{
    NSString *ID = @"ID";
   __block BOOL result = NO;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        
        NSString * sqlSelect = [NSString stringWithFormat:
                                @"SELECT * FROM %@",tableName];
//        FMResultSet * rs = [self executeQueryWithFormat:sqlSelect];
        FMResultSet *rs = [db executeQuery:sqlSelect];
        
        while ([rs next])
        {
            int Id = [rs intForColumn:ID];
            if (Id == 0)
            {
                result = NO;
            }
            else
            {
                result = YES;
                
            }
        }
        //关闭结果集
        [rs close];

    }];
    
        return result;
}

#pragma mark-查询好友表中总的未读消息数目
+(int)getTotalUnreadNumberFromFriendTable
{
    __block  int totalCount = 0;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString * sqlFriend = [NSString stringWithFormat:
                                @"SELECT * FROM %@ ",FRIENDSTABLE];
        
        FMResultSet *rs = [db executeQuery:sqlFriend];
        
        while ([rs next])
        {
             int unreadNum = [rs intForColumn:FUNREAD];
            totalCount = totalCount + unreadNum;
        }
        [rs close];
    } ];
//    if (totalCount>=99)
//    {
//        totalCount = 99;
//    }
   
     return totalCount;
   
}

#pragma mark-关闭数据库
+(void)closeDataBaseWhenLogout
{
[_dbQueue inDatabase:^(FMDatabase *db) {
    [db close];
}];
}
@end
