//
//  SecondViewController.h
//  CycleAssist
//
//  Created by 荻原由佳 on 2014/08/18.
//  Copyright (c) 2014年 荻原大輔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController{
    // CycleAssist OR Howtoを選ぶためのSegmented Controlのインスタンス
    IBOutlet UISegmentedControl *selector01;
}

@property (nonatomic, retain)UISegmentedControl *selector01;

//segmentedControlをタップしたときに呼ばれるメゾット
- (IBAction)ChangeWindow:(id)sender;

@end