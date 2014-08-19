//
//  SecondViewController.m
//  CycleAssist
//
//  Created by 荻原由佳 on 2014/08/18.
//  Copyright (c) 2014年 荻原大輔. All rights reserved.
//

#import "SecondViewController.h"
@interface SecondViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic)NSMutableArray *nanapilist;

@end

#define NANAPI_API_URL @"http://api.nanapi.jp/v1/recipeSearchDetails/?key=4b542e23e43f6&format=json&query=%E3%82%B5%E3%82%A4%E3%82%AF%E3%83%AA%E3%83%B3%E3%82%B0%20%E8%87%AA%E8%BB%A2%E8%BB%8A%20%E3%83%90%E3%82%A4%E3%82%AF"
@implementation SecondViewController{


    //最新ニュースを格納する配列
    NSMutableArray* elementList;
    
    //Table Viewインスタンス
    IBOutlet UITableView *table;
}
//Safariに渡すURL
NSURL *urlForSafari;

@synthesize selector01;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    selector01.selectedSegmentIndex=1;
        // デリゲート初期化
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    
    //JSONの取得コール
    [self getJson];
}

- (void)getJson
{
        NSURL *url = [NSURL URLWithString:NANAPI_API_URL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
                // JSON形式のデータをNSDictへ
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
                // リスト管理するプロパティへ挿入
                self.nanapilist = [[dict objectForKey:@"response"] objectForKey:@"recipes"];
        
                // データ取得後テーブルを再描画
            [self.tableView reloadData];
            }];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        // 表示は3件のみ
        return 3.f;
    }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        // セクションはいらない
        return 1.f;
    }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        NSDictionary *recipe = [self.nanapilist objectAtIndex:indexPath.row];
        cell.textLabel.text = [recipe objectForKey:@"title"];
        return cell;
    }

//フロント側でテーブルを更新
- (void) refreshTableOnFront {
    [self performSelectorOnMainThread:@selector(refreshTable) withObject:self waitUntilDone:TRUE];
}

//テーブルの内容をセット
- (void)refreshTable {
    
    //ステータスバーのActivity Indicatorを停止
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //最新の内容にテーブルをセット
    [table reloadData];
}

//リスト中のお気に入りアイテムが選択された時の処理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //選択された項目のURLを参照
    News *n = [elementList objectAtIndex:[indexPath row]];
    NSString *selectedURL = n.url;
    
    urlForSafari = [NSURL URLWithString:selectedURL];
 
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

- (IBAction)ChangeWindow:(id)sender{
    //Cycle assistが選択された場合
    if(selector01.selectedSegmentIndex==0){
    //Howtoが選択された場合
    }else if(selector01.selectedSegmentIndex==1){
    }
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
