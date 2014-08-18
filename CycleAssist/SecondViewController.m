//
//  SecondViewController.m
//  CycleAssist
//
//  Created by 荻原由佳 on 2014/08/18.
//  Copyright (c) 2014年 荻原大輔. All rights reserved.
//

#import "SecondViewController.h"
#import "ViewController.h"
@interface SecondViewController ()

@end

@implementation SecondViewController{
    // 「ドル→円」or「円→ドル」を選ぶためのSegmented Controlのインスタンス
    IBOutlet UISegmentedControl *selector;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)ChangeWindow:(id)sender{
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
