//
//  ViewController.m
//  CycleAssist
//
//  Created by 荻原由佳 on 2014/08/18.
//  Copyright (c) 2014年 荻原大輔. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize selector;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)WindowChange:(id)sender{
    //Cycle assistが選択された場合
    if(selector.selectedSegmentIndex==0){
    //Howtoが選択された場合
    }else if(selector.selectedSegmentIndex==1){
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
