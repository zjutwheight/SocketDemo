//
//  BIDSocketEngine.m
//  SocketDemo
//
//  Created by MAC on 12-11-22.
//  Copyright (c) 2012年 edu.zju.cst.wh. All rights reserved.
//

#import "BIDSocketEngine.h"

@implementation BIDSocketEngine

@synthesize inputStream;
@synthesize outputStream;
@synthesize currentViewController;

-(void) initNetworkCommunication {
    CFReadStreamRef readStream;
	CFWriteStreamRef writeStream;
	CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)SERVER_ADDRESS, SERVER_PORT, &readStream, &writeStream);
	
	inputStream = (NSInputStream *)readStream;
	outputStream = (NSOutputStream *)writeStream;
	[inputStream setDelegate:self];
	[outputStream setDelegate:self];
	[inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	[outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	[inputStream open];
	[outputStream open];
}

-(void) disconnet{
    [inputStream close];
    [inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream release];
    
    [outputStream close];
    [outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream release];
    
    [currentViewController dealDataPackage:@"-1"];
}

-(void) sendDataPackage:(NSData *)dataPackage{
    [outputStream write:[dataPackage bytes] maxLength:[dataPackage length]];
}

- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
	switch (streamEvent) {
		case NSStreamEventOpenCompleted:
			NSLog(@"Stream opened");
            [currentViewController dealDataPackage:@"1"];
			break;
		case NSStreamEventHasBytesAvailable:
			if (theStream == inputStream) {
				uint8_t buffer[1024];
				int len;
                NSMutableString* response = [[NSMutableString alloc] init];
				while ([inputStream hasBytesAvailable]) {
					len = [inputStream read:buffer maxLength:sizeof(buffer)];
					if (len > 0) {
						NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
						if (nil != output) {
							[response appendString:output];
						}
					}
				}
                NSLog(@"server said: %@", response);
                [currentViewController dealDataPackage:response];
                NSLog(@"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			}
			break;
		case NSStreamEventErrorOccurred:
			NSLog(@"Can not connect to the host!");
            [currentViewController dealDataPackage:@"2"];
			break;
		case NSStreamEventEndEncountered:
            NSLog(@"Stream Event end!");
            [theStream close];
            [theStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            [theStream release];
            theStream = nil;
            [currentViewController dealDataPackage:@"-1"];
			break;
		default:
			NSLog(@"Unknown event");
	}
}

- (void)dealloc{
    [inputStream release];
    [outputStream release];
    [currentViewController release];
    [super dealloc];
}

@end
