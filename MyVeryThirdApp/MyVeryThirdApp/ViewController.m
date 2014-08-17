//
//  ViewController.m
//  MyVeryThirdApp
//
//  Created by 荻原由佳 on 2014/08/17.
//  Copyright (c) 2014年 荻原大輔. All rights reserved.
//

#import "ViewController.h"
#import "stdio.h"

@interface ViewController ()

@end

@implementation ViewController
{
    //入力金額を扱う変数
    double input;
    //換算後の金額を扱う変数
    double result;
    //変換レートを扱う変数
    double rate;
    //入力値の通貨の単位を表示するラベル（円 or ドル）
    IBOutlet UILabel *inputCurrency;
    //換算後の通貨の単位を表示するラベル（円 or ドル）
    IBOutlet UILabel *resultCurrency;
    //通貨レートを表示するラベル
    IBOutlet UILabel *rateLabel;
    //換算後の金額を表示するラベル
    IBOutlet UILabel *resultLabel;
    //『ドル→円』or『円→ドル』どちらなのかを記録するbool変数
    //『円→ドル』ならば『TRUE』、『ドル→円』ならば『FALSE』
    bool isYenToDollar;
    // 「ドル→円」or「円→ドル」を選ぶためのSegmented Controlのインスタンス
    IBOutlet UISegmentedControl *selector;
    // 金額を入力するテキストフィールドのインスタンス
    IBOutlet UITextField *inputField;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //変換レート設定（1ドルあたり80.5円）
    rate=80.5;
    //inputとresultを0に初期化
    input=0;
    result=0;
    
    //rateLabelの値をrateの値に応じて変更
    [rateLabel setText:[NSString stringWithFormat:@"%.1f",rate ]];
    //
    isYenToDollar=TRUE;
    // inputFieldのDelegate通知をViewControllerで受け取る
    inputField.delegate=self;
    
}

//通貨換算における計算処理
- (void)convert{
    //円→ドル変換の場合
    if(isYenToDollar==TRUE){
        //ドルの金額　＝　円の入力値を変換レートで割った値
        result=input/rate;
        //小数点以下2桁までのみをresultLabelに表示
        [resultLabel setText:[NSString stringWithFormat:@"%.2f",result]];
        //ドル→円変換の場合
    }else if(isYenToDollar==FALSE){
     //円の金額＝ドルの入力値を変換レートで掛けた値
        result=input*rate;
        //小数点以下2桁までのみをresultLabelに表示
        [resultLabel setText:[NSString stringWithFormat:@"%.0f",result]];
    }
    }

- (IBAction)ChangeCalcMethod:(id)sender{
    //左側（円→ドル）が選択された場合（selectorの値が「0」のとき）
    if(selector.selectedSegmentIndex==0){
        isYenToDollar=TRUE;
        [inputCurrency setText:@"円"];
        [resultCurrency setText:@"ドル"];
        //右側（ドル→円）が選択された場合（selectorの値が「1」のとき）
    }else if(selector.selectedSegmentIndex==1){
        isYenToDollar=FALSE;
        [inputCurrency setText:@"ドル"];
        [resultCurrency setText:@"円"];
    }
    //通貨を変換
    [self convert];
}

// UITextFieldのキーボード上の「Return」ボタンが押された時に呼ばれる処理
- (BOOL)textFieldShouldReturn:(UITextField *)sender{
    //受け取った入力値（NSString型の文字列）をdoubleに変換し、inputに代入
    input=[sender.text doubleValue];
    //キーボードを閉じる
    [sender resignFirstResponder];
    //通貨を変換
    [self convert];
    return TRUE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
