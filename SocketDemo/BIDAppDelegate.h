//
//  BIDAppDelegate.h
//  SocketDemo
//
//  Created by MAC on 12-11-22.
//  Copyright (c) 2012年 edu.zju.cst.wh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BIDViewController;
@class BIDSocketEngine;

@interface BIDAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) BIDViewController *viewController;

@property (strong, nonatomic) BIDSocketEngine *socketEngine;
@property (strong, nonatomic) NSString *globalString;

@end
