//
//  BIDSocketProtocol.h
//  SocketDemo
//
//  Created by MAC on 12-11-22.
//  Copyright (c) 2012年 edu.zju.cst.wh. All rights reserved.
//

#import <Foundation/Foundation.h>

#define K_REQ_TYPE @"req_t"
#define K_REQ_BODY @"req_b"

#define K_RES_TYPE @"rep_t"
#define K_RES_CODE @"rep_c"
#define K_RES_BODY @"rep_b"

@interface BIDSocketProtocol : NSObject

- (NSData *) encapsulateTestDataPackageWithTestString:(NSString *)testString
                                         AndTestDictionary:(NSMutableDictionary *)testDictionary;
- (NSData *) encapsulateSynchronizeSkillLibraryVersionPackage;
@end
