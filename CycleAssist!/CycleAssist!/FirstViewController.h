//
//  FirstViewController.h
//  CycleAssist!
//
//  Created by 荻原由佳 on 2014/08/20.
//  Copyright (c) 2014年 荻原大輔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FirstViewController : UIViewController
<MKMapViewDelegate>{
    //地図表示用
     MKMapView *myMapView;
    //　現在地取得用
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
