//
//  ViewController.h
//  CycleAssist
//
//  Created by 荻原由佳 on 2014/08/18.
//  Copyright (c) 2014年 荻原大輔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    // CycleAssist OR Howtoを選ぶためのSegmented Controlのインスタンス
    IBOutlet UISegmentedControl *selector;
}
@property (nonatomic,retain)UISegmentedControl *selector;

//segmentedControlをタップしたときに呼ばれるメゾット
- (IBAction)WindowChange:(id)sender;

@end


