//
//  BIDViewController.h
//  SocketDemo
//
//  Created by MAC on 12-11-22.
//  Copyright (c) 2012年 edu.zju.cst.wh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BIDGenViewController.h"

@interface BIDViewController : BIDGenViewController <UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UILabel *sockStatus;
@property (retain, nonatomic) IBOutlet UITableView *receivedInfoTable;
@property (retain, nonatomic) IBOutlet UIButton *connectButton;
@property (retain, nonatomic) IBOutlet UIButton *disconnectButton;
@property (retain, nonatomic) IBOutlet UIButton *sendDataButton;

@property (retain, nonatomic) NSMutableArray *messageList;

- (IBAction)connect:(id)sender;
- (IBAction)disconnect:(id)sender;
- (IBAction)sendTestData:(id)sender;

@end
