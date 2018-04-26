//
//  WTF.m
//  Pods
//
//  Created by 孙继刚 on 2017/4/28.
//
//

#import "WTF.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <DeviceDNA/DeviceDNA.h>
#import <PLShortVideoKit/PLSImageSetting.h>
#import <UMMobClick/MobClick.h>

@implementation WTF

- (void)map {
    NSLog([DeviceDNA new].description);
    NSLog([BMKMapView new].description);
    NSLog([PLSImageSetting new].description);
    NSLog([UMAnalyticsConfig sharedInstance].description);
}

@end
