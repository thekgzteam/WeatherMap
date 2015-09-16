//
//  ViewController.h
//  WeatherMapRefresh
//
//  Created by Edil Ashimov on 7/21/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"
@protocol MapViewControllerProtocol <NSObject>

-(City *)parseCityData:(NSDictionary *)json zipCode:(NSString *)zip;

@end

@interface MapViewController : UIViewController

@property id <MapViewControllerProtocol> delegate;

@end

