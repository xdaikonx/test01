//
//  SecondViewController.m
//  CycleAssist!
//
//  Created by 荻原由佳 on 2014/08/20.
//  Copyright (c) 2014年 荻原大輔. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) NSArray *nanapilist1;
@property (strong,nonatomic) NSArray *nanapilist2;
@property (strong,nonatomic) NSArray *nanapilist3;
@property (nonatomic, strong) NSString *url;
@end



@implementation SecondViewController{

//Safariに渡すURL
NSURL *urlForSafari;
}
- (void)viewDidLoad

{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.nanapilist1 =@[
                       @{
                           @"title": @"       ■自転車についてのHowto■    ",
                           @"url": @"http://nanapi.jp/search/q:%E8%87%AA%E8%BB%A2%E8%BB%8A/theme_id:1476"
                           },
                       @{
                           @"title": @"自転車の電気は必ず点けよう！自転車でのマナー",
                           @"url": @"http://nanapi.jp/72882/"
                           },
                       @{
                           @"title": @"自転車豆知識",
                           @"url": @"http://nanapi.jp/18922/"
                           },
                       @{
                           @"title": @"自転車好きに！「自転車NAVITIME」のおすすめポイント",
                           @"url": @"http://nanapi.jp/18922/"
                           },
                       
                       ];
    self.nanapilist2=@[
                       @{
                           @"title": @"         ■旅行についてのHowto■   ",
                           @"url": @"http://nanapi.jp/search/q:%E6%97%85%E8%A1%8C%E3%80%80%E3%83%88%E3%83%A9%E3%83%96%E3%83%AB/theme_id:945"
                           },
                       @{
                           @"title": @"十分な準備をして…国内旅行でのトラブル",
                           @"url": @"http://nanapi.jp/63085/"
                           },
                       @{
                           @"title": @"泊まる部屋がない！国内旅行トラブル体験談",
                           @"url": @"http://nanapi.jp/90243/"
                           },
                       @{
                           @"title": @"楽しい旅行のトラブルを防ごう！財布をなくさない方法",
                           @"url": @"http://nanapi.jp/42101/"
                           },
                       
                       ];
    self.nanapilist3=@[
                       @{
                           @"title": @"       ■天気についてのHowto■   ",
                           @"url": @"http://nanapi.jp/search/q:%E5%A4%A9%E6%B0%97%E4%BA%88%E5%A0%B1"
                           },
                       @{
                           @"title": @"おすすめ天気予報アプリ",
                           @"url": @"http://nanapi.jp/59864/"
                           },
                       @{
                           @"title": @"iPhoneのSiriを使って今日の天気を聞く方法",
                           @"url": @"http://nanapi.jp/78482/"
                           },
                       @{
                           @"title": @"明日の天気を知る自然の法則・空の読み方",
                           @"url": @"http://nanapi.jp/24458/"
                           },
                       
                       ];


}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // セクション数
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 各セクションごとのcell数
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.textLabel.text = [[self.nanapilist1 objectAtIndex:indexPath.row] objectForKey:@"title"];
    } else if (indexPath.section == 1) {
        cell.textLabel.text = [[self.nanapilist2 objectAtIndex:indexPath.row] objectForKey:@"title"];
    } else if (indexPath.section == 2) {
        cell.textLabel.text = [[self.nanapilist3 objectAtIndex:indexPath.row] objectForKey:@"title"];
        
    }
    return cell;
}



    //リスト中のお気に入りアイテムが選択された時の処理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
         _url = [[self.nanapilist1 objectAtIndex:indexPath.row] objectForKey:@"url"];
    }else if(indexPath.section == 1){
       _url = [[self.nanapilist2 objectAtIndex:indexPath.row] objectForKey:@"url"];
    }else if(indexPath.section == 2){
         _url = [[self.nanapilist3 objectAtIndex:indexPath.row] objectForKey:@"url"];
    }

    
        urlForSafari = [NSURL URLWithString:_url];
        
        //Safariを起動するかどうかを確認
        [self goToSafari];
    }

//本当にSafariにを起動するかを確認するalert View表示
- (void)goToSafari {
    //メッセージを表示
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Safariの起動"
                          message:@"このニュースをSafariで開きますか？"
                          delegate:self cancelButtonTitle:@"いいえ"
                          otherButtonTitles:@"はい", nil];
    [alert show];
}

//alert View上のボタンがクリックされた時の処理
//「はい」が押されたときはSafariを起動
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"いいえ"]) {
        NSLog(@"Safari起動キャンセル");
    } else if([title isEqualToString:@"はい"]) {
        NSLog(@"Safari起動");
        //アプリからSafariを起動
        [[UIApplication sharedApplication] openURL:urlForSafari];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
