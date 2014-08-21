//
//  FirstViewController.m
//  CycleAssist!
//
//  Created by 荻原由佳 on 2014/08/20.
//  Copyright (c) 2014年 荻原大輔. All rights reserved.
//

#import "FirstViewController.h"
@interface FirstViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *Weather;
@end

#define kLatitudeShibuya 35.658987
#define kLongitudeShibuya 139.702776
#define kLatitudeRoppongi 35.665213
#define kLongitudeRoppongi 139.730011
#define NANAPI_API_URL @"http://api.openweathermap.org/data/2.5/weather?q=Tokyo"

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];


	// Do any additional setup after loading the view, typically from a nib.
    //位置情報を作成（現在地：渋谷）
    CLLocationCoordinate2D fromCoordinate = CLLocationCoordinate2DMake(kLatitudeShibuya, kLongitudeShibuya);
    
    //位置情報を作成（目的地：六本木）
    CLLocationCoordinate2D toCoordinate = CLLocationCoordinate2DMake(kLatitudeRoppongi, kLongitudeRoppongi);
    
    //位置情報をもとに、100m四方で表示
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(fromCoordinate, 5000, 5000);
    [self.mapView setRegion:region];
    
    
    //デリゲート設定
    [self.mapView setDelegate:self];
    //ビルなどの表示
    [self.mapView setShowsBuildings:YES];
    //目的になる建物の表示
    [self.mapView setShowsPointsOfInterest:YES];
    // ユーザーの現在地表示プロパティ（シュミレーターでは正常に動かない)
    [self.mapView setShowsUserLocation:YES];
    
    // CLLocationCoordinate2D から MKPlacemark を生成
    MKPlacemark *fromPlacemark = [[MKPlacemark alloc] initWithCoordinate:fromCoordinate
                                  addressDictionary:nil];
    MKPlacemark *toPlacemark   = [[MKPlacemark alloc] initWithCoordinate:toCoordinate
                                  addressDictionary:nil];
    
    // MKPlacemark から MKMapItem を生成
    MKMapItem *fromItem = [[MKMapItem alloc] initWithPlacemark:fromPlacemark];
    MKMapItem *toItem   = [[MKMapItem alloc] initWithPlacemark:toPlacemark];
    
    // MKMapItem をセットして MKDirectionsRequest を生成
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source=fromItem;
    request.destination=toItem;
    request.requestsAlternateRoutes = YES;
    
    // MKDirectionsRequest から MKDirections を生成
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    //経路検索を実行
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error){
        if(error) return;
        
        if([response.routes count]>0){
            MKRoute *route =[response.routes objectAtIndex:0];
            NSLog(@"distance:%.2f meter",route.distance);
            
            //地図上にルートを描写
            [self.mapView addOverlay:route.polyline];
        }
    }];
    
    [self getJson];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

//地図上に描画するルートの色などを設定（重要）
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView
           rendererForOverlay:(id<MKOverlay>)overlay{
    if ([overlay isKindOfClass:[MKPolyline class]]){
         MKPolyline *route = overlay;
        MKPolylineRenderer *routeRenderer = [[MKPolylineRenderer alloc] initWithPolyline:route];
        routeRenderer.lineWidth=5.0;
        routeRenderer.strokeColor=[UIColor redColor];
        return routeRenderer;
    }else{
        return nil;
    }
}

- (void)getJson
{
        NSURL *url = [NSURL URLWithString:NANAPI_API_URL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
                // JSON形式のデータをNSDictへ
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
                // リスト管理するプロパティへ挿入
                self.Weather = [dict objectForKey:@"weather"];
            
            [self.tableView reloadData];
        
            }];
    


}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [[self.Weather objectAtIndex:indexPath.row] objectForKey:@"main"];
    return cell;
}

@end