//
//  BIDSocketProtocol.m
//  SocketDemo
//
//  Created by MAC on 12-11-22.
//  Copyright (c) 2012年 edu.zju.cst.wh. All rights reserved.
//

#import "BIDSocketProtocol.h"

#import "JSONKit.h"

@implementation BIDSocketProtocol

- (NSData *) encapsulateTestDataPackageWithTestString:(NSString *)testString
                                         AndTestDictionary:(NSMutableDictionary *)testDictionary
{
    NSMutableDictionary *testDataDictionary = [[NSMutableDictionary alloc] init];
    NSNumber *cmdType = [[NSNumber alloc]initWithInteger:990001];
    [testDataDictionary setValue:cmdType forKey:K_REQ_TYPE];
    NSMutableDictionary *testDataBodyDictionary = [[NSMutableDictionary alloc] init];
    [testDataBodyDictionary setValue:testString forKey:@"testString"];
    [testDataBodyDictionary setValue:testDictionary forKey:@"testDictionary"];
    [testDataDictionary setValue:testDataBodyDictionary forKey:K_REQ_BODY];
    NSString *JSONString = [testDataDictionary JSONString];
    
    NSLog(@"test package data:%@", JSONString);
    return [self JSONString2NSData:JSONString];
}

-  (NSData *) encapsulateSynchronizeSkillLibraryVersionPackage{
    NSMutableDictionary *packetDictionary = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] init];
    NSNumber *cmdType = [[NSNumber alloc] initWithInteger:30001];
    [bodyDictionary setValue:@"0" forKey:@"s_l_v"];
    [bodyDictionary setValue:@"0" forKey:@"s_a_l_v"];
    [bodyDictionary setValue:@"0" forKey:@"s_t_l_v"];
    [bodyDictionary setValue:@"0" forKey:@"s_st_r_l_v"];
    [packetDictionary setValue:cmdType forKey:K_REQ_TYPE];
    [packetDictionary setValue:bodyDictionary forKey:K_REQ_BODY];
    NSString *JSONString = [packetDictionary JSONString];
    return [self JSONString2NSData:JSONString];
}

- (NSData *) JSONString2NSData:(NSString *)JSONString {
    NSData *data = [[NSData alloc] initWithData:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    return data;
}

@end
