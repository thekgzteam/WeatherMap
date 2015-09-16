//
//  WeatherTableViewController.m
//  WeatherMapRefresh
//
//  Created by Edil Ashimov on 7/21/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "WeatherTableViewController.h"
#import "MapViewController.h"
#import "City.h"
@interface WeatherTableViewController () <MapViewControllerProtocol>
@property NSMutableArray *forecast;
@end

@implementation WeatherTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(City *)parseCityData:(NSDictionary *)json zipCode:(NSString *)zip{
    self.forecast = [NSMutableArray new];

    City *city = [City new];

    city.name = json[@"name"];
    city.zip = zip;

    NSDictionary *coordinate = json[@"coord"];
    NSArray *weather = json[@"weather"];
    NSDictionary *main = json[@"main"];

    double lat = [coordinate[@"lat"] doubleValue];
    double lon = [coordinate[@"lon"] doubleValue];

    city.coordinates = CLLocationCoordinate2DMake(lat, lon);

    city.temp = [self kelvinToFarenheit:main[@"temp"]];

    city.hi = [self kelvinToFarenheit:main[@"temp_max"]];
    city.lo = [self kelvinToFarenheit:main[@"temp_min"]];
    city.main = weather.firstObject[@"main"];
    city.conditions = weather.firstObject[@"description"];
    // parse weather data

    NSString *tempString = [NSString stringWithFormat:@"Current Temperature: %@", city.temp];
    NSString *hiString = [NSString stringWithFormat:@"Hi: %@", city.hi];
    NSString *loString = [NSString stringWithFormat:@"Lo: %@", city.lo];
    NSString *mainString = [NSString stringWithFormat:@"Currently: %@", city.main];
    NSString *conditionsString = [NSString stringWithFormat:@"Description: %@", city.conditions];

    [self kelvinToFarenheit:city.temp];

    [self.forecast addObject:mainString];
    [self.forecast addObject:conditionsString];
    [self.forecast addObject:tempString];
    [self.forecast addObject:hiString];
    [self.forecast addObject:loString];


    [self.tableView reloadData];

    return city;
}


- (NSString *)kelvinToFarenheit:(NSString *)temp {
    return [NSString stringWithFormat:@"%.0f°", ([temp doubleValue] - 273.15)* 1.8000 + 32.00];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.forecast.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = self.forecast[indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
