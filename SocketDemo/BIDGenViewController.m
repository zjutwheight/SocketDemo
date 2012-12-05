//
//  BIDGenViewController.m
//  SocketDemo
//
//  Created by MAC on 12-11-22.
//  Copyright (c) 2012年 edu.zju.cst.wh. All rights reserved.
//

#import "BIDGenViewController.h"

@interface BIDGenViewController ()

@end

@implementation BIDGenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealDataPackage:(NSString *)packageContent{
    NSLog(@"*************************************************************");
}

@end
