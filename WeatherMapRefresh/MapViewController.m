//
//  ViewController.m
//  WeatherMapRefresh
//
//  Created by Edil Ashimov on 7/21/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "WeatherTableViewController.h"

@interface MapViewController () <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet MKMapView *mapview;
@property MKPointAnnotation *annotation;
@property WeatherTableViewController<MapViewControllerProtocol> *target;


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = self;
    self.annotation = [MKPointAnnotation new];
    [self.mapview addAnnotation:self.annotation];
    self.target = [self.storyboard instantiateViewControllerWithIdentifier:@"ForecastID"];
    self.delegate = self.target;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self loadWeather:searchBar.text];
}

-(void)loadWeather:(NSString *)zip{
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@,us", zip];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];

        City *city = [self.delegate parseCityData:json zipCode:zip];

        self.annotation.coordinate = city.coordinates;
        self.navigationItem.title = city.name;
        self.annotation.title = city.name;

        MKCoordinateRegion region;
        region.center = self.annotation.coordinate;
        region.span.latitudeDelta = 0.1;
        region.span.longitudeDelta = 0.1;
        [self.mapview setRegion:region animated:YES];
    }];
}


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc]initWithAnnotation:self.annotation reuseIdentifier:nil];
    pin.canShowCallout = YES;
    pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    pin.pinColor = MKPinAnnotationColorPurple;
    return pin;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{

    [self.navigationController pushViewController:self.target animated:YES];
}

@end
