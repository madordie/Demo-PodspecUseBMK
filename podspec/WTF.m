//
//  WTF.m
//  Pods
//
//  Created by 孙继刚 on 2017/4/28.
//
//

#import "WTF.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <UMMobClick/MobClick.h>

@implementation WTF

- (void)map {
    NSLog([BMKMapView new].description);
    NSLog([UMAnalyticsConfig sharedInstance].description);
}

@end
