//
//  BIDSocketEngine.h
//  SocketDemo
//
//  Created by MAC on 12-11-22.
//  Copyright (c) 2012年 edu.zju.cst.wh. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BIDGenViewController.h"

#define SERVER_ADDRESS @"localhost"
#define SERVER_PORT 5550

@interface BIDSocketEngine : NSObject<NSStreamDelegate>

@property (nonatomic, retain) NSInputStream *inputStream;
@property (nonatomic, retain) NSOutputStream *outputStream;
@property (nonatomic, retain) BIDGenViewController *currentViewController;

-(void) initNetworkCommunication;
-(void) disconnet;
-(void) sendDataPackage:(NSData *)dataPackage;

@end
