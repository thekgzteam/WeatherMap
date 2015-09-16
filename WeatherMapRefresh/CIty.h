//
//  CIty.h
//  WeatherMapRefresh
//
//  Created by Edil Ashimov on 7/21/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface City : NSObject
@property NSString *name;
@property NSString *zip;
@property CLLocationCoordinate2D coordinates;
@property NSString *temp;
@property NSString *hi;
@property NSString *lo;
@property NSString *main;
@property NSString *conditions;
@end
