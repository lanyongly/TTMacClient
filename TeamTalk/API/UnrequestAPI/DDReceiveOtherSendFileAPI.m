//
//  DDReceiveOtherSendFileAPI.m
//  Duoduo
//
//  Created by 独嘉 on 14-5-12.
//  Copyright (c) 2014年 zuoye. All rights reserved.
//

#import "DDReceiveOtherSendFileAPI.h"
#import "FileTransferEntity.h"
@implementation DDReceiveOtherSendFileAPI
/**
 *  数据包中的serviceID
 *
 *  @return serviceID
 */
- (int)responseServiceID
{
    return MODULE_ID_FILETRANSFER;
}

/**
 *  数据包中的commandID
 *
 *  @return commandID
 */
- (int)responseCommandID
{
    return CMD_FILE_RECEIVE_FILE_SEND_REQ;
}

/**
 *  解析数据包
 *
 *  @return 解析数据包的block
 */
- (UnrequestAPIAnalysis)unrequestAnalysis
{
    UnrequestAPIAnalysis analysis = (id)^(NSData* data)
    {
        DataInputStream* bodyData = [DataInputStream dataInputStreamWithData:data];
        NSString *fromUserId = [bodyData readUTF];
        NSString *toUserId = [bodyData readUTF];
        NSString *fileName = [bodyData readUTF];
        uint32_t fileSize = [bodyData readInt];
        NSString* taskID = [bodyData readUTF];
        NSString* ip = [bodyData readUTF];
        UInt8 port = [bodyData readInt];
        
        FileTransferEntity* entity = [[FileTransferEntity alloc] init];
        entity.fromUserId = fromUserId;
        entity.toUserId = toUserId;
        entity.fileName = fileName;
        entity.fileSize = fileSize;
        return entity;
    };
    return analysis;
}
@end
