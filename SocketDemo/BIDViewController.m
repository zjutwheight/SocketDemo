//
//  BIDViewController.m
//  SocketDemo
//
//  Created by MAC on 12-11-22.
//  Copyright (c) 2012年 edu.zju.cst.wh. All rights reserved.
//

#import "BIDViewController.h"
#import "BIDAppDelegate.h"
#import "BIDSocketEngine.h"
#import "BIDSocketProtocol.h"
#import "JSONKit.h"

@interface BIDViewController ()

- (void) dealSynchronizeSkillLibraryVersion:(NSDictionary*) responseBody;

@end

@implementation BIDViewController

@synthesize sockStatus;
@synthesize receivedInfoTable;
@synthesize connectButton;
@synthesize disconnectButton;
@synthesize sendDataButton;

@synthesize messageList;

BIDSocketProtocol *socketProtocol;


- (void)viewDidLoad
{
    [super viewDidLoad];
    messageList = [[NSMutableArray alloc] initWithCapacity:10];
    socketProtocol = [[BIDSocketProtocol alloc] init];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setSockStatus:nil];
    [self setReceivedInfoTable:nil];
    [self setConnectButton:nil];
    [self setDisconnectButton:nil];
    [self setSendDataButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)connect:(id)sender {
    BIDAppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [appDelegate.socketEngine initNetworkCommunication];
}

- (IBAction)disconnect:(id)sender {
    BIDAppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [appDelegate.socketEngine disconnet];

}

- (IBAction)sendTestData:(id)sender {
    //NSString *response = [NSString stringWithFormat:@"{\"type\":990001, \"test\":\"test\"}"];
    //NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSUTF8StringEncoding]];
    
//    NSString *testString = [[NSString alloc] initWithString:@"test string"];
//    NSMutableDictionary *testDictionary = [[NSMutableDictionary alloc] init];
//    [testDictionary setValue:@"aaaaaaaa" forKey:@"test1"];
//    [testDictionary setValue:@"bbbbbbbb" forKey:@"test2"];
//    [testDictionary setValue:@"cccccccc" forKey:@"test3"];
//    NSData *data = [socketProtocol encapsulateTestDataPackageWithTestString:testString
//                                                          AndTestDictionary:testDictionary];
    NSData *data = [socketProtocol encapsulateSynchronizeSkillLibraryVersionPackage];
    BIDAppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [appDelegate.socketEngine sendDataPackage:data];
}

- (void) dealDataPackage:(NSString *)packageContent{
    [super dealDataPackage:packageContent];
    if ([packageContent isEqualToString:@"1"]) {
        sockStatus.text = @"已连接！";
        sockStatus.textColor = [UIColor redColor];
        connectButton.hidden = true;
        disconnectButton.hidden = false;
        sendDataButton.hidden = false;
        messageList = [[NSMutableArray alloc] initWithCapacity:10];
        [receivedInfoTable reloadData];
    } else if ([packageContent isEqualToString:@"-1"]) {
        sockStatus.text = @"已断开！";
        sockStatus.textColor = [UIColor blueColor];
        connectButton.hidden = false;
        disconnectButton.hidden = true;
        sendDataButton.hidden = true;
    } else if ([packageContent isEqualToString:@"2"]) {
        sockStatus.text = @"服务器不可用！";
        sockStatus.textColor = [UIColor redColor];
    } else {
        NSLog(@"package content:%@", packageContent);
        NSData *data = [packageContent dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseDataDictionary = [data objectFromJSONData];
        NSNumber *responseType = [responseDataDictionary valueForKey:K_RES_TYPE];
        NSDictionary *responseBody = [responseDataDictionary valueForKey:K_RES_BODY];
        int type = [responseType intValue];
        if (type == 30002) {
            [self dealSynchronizeSkillLibraryVersion:responseBody];
        }
//        NSString *currentTime = [[NSString alloc] initWithFormat:@"%@", [NSDate date]];
//        [messageList addObject:currentTime];
//        NSData *data = [packageContent dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary *responseDataDictionary = [data objectFromJSONData];
//        NSNumber *responseType = [responseDataDictionary valueForKey:@"rep_t"];
//        NSNumber *responseCode = [responseDataDictionary valueForKey:@"rep_c"];
//        NSDictionary *responseBody = [responseDataDictionary valueForKey:@"rep_b"];
//        NSString *title = [[NSString alloc]
//                           initWithFormat:@"type:%@, code:%@", responseType, responseCode];
//        NSString *content = [responseBody valueForKey:@"value"];
//        [messageList addObject:title];
//        [messageList addObject:content];
//        NSArray *contentList = [responseBody valueForKey:@"list_value"];
//        for (int i= 0; i < [contentList count]; i++) {
//            NSDictionary *listElement = [contentList objectAtIndex:i];
//            NSString *element1 = [listElement valueForKey:@"t_rep_1"];
//            NSString *element2 = [listElement valueForKey:@"t_rep_2"];
//            NSString *element3 = [listElement valueForKey:@"t_rep_3"];
//            [messageList addObject:element1];
//            [messageList addObject:element2];
//            [messageList addObject:element3];
//        }
//        [receivedInfoTable reloadData];
    }
}

- (void) dealSynchronizeSkillLibraryVersion:(NSDictionary*) responseBody {
    NSArray* skillList = [responseBody valueForKey:@"s_l"];
    for (int i = 0; i < [skillList count]; i++) {
        NSDictionary* skill = [skillList objectAtIndex:i];
        NSString* skillName = [skill valueForKey:@"s_n"];
        NSString* skillDescription = [skill valueForKey:@"s_d"];
        [messageList addObject:skillName];
        [messageList addObject:skillDescription];
    }
    [receivedInfoTable reloadData];
}

- (void)dealloc {
    [sockStatus release];
    [receivedInfoTable release];
    [connectButton release];
    [disconnectButton release];
    [sendDataButton release];
    [super dealloc];
}

#pragma mark- Table View Data Source Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [messageList count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:SimpleTableIdentifier]; }
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [messageList objectAtIndex:row];
    
    return cell;
}
#pragma mark- Table View Delegate Methods

@end
