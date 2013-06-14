//
//  ConverterPickerViewController.m
//  Converter
//
//  Created by Oliver Foggin on 14/06/2013.
//  Copyright (c) 2013 Oliver Foggin. All rights reserved.
//

#import "ConverterPickerViewController.h"
#import "Converter.h"

@interface ConverterPickerViewController ()

@property (nonatomic, strong) NSArray *converters;

@end

@implementation ConverterPickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.converters = @[
                        @{@"name": @"Temperature",
                          @"converters" : @[
                                  [[Converter alloc] initWithConverterName:@"Celsius to Farenheit"
                                                                  fromName:@"Celsius"
                                                                    toName:@"Fahrenheit"
                                                           conversionBlock:^float(float input) {
                                                               return input * 9 / 5 + 32;
                                                           }],
                                  [[Converter alloc] initWithConverterName:@"Fahrenheit to Celsius"
                                                                  fromName:@"Fahrenheit"
                                                                    toName:@"Celsius"
                                                           conversionBlock:^float(float input) {
                                                               return (input - 32) * 5 / 9;
                                                           }]
                                  ]},
                        @{@"name": @"Distance",
                          @"converters" : @[
                                  [[Converter alloc] initWithConverterName:@"Metres to Feet"
                                                                  fromName:@"Metres"
                                                                    toName:@"Feet"
                                                           conversionBlock:^float(float input) {
                                                               return input * 3.2808399;
                                                           }],
                                  [[Converter alloc] initWithConverterName:@"Feet to Metres"
                                                                  fromName:@"Feet"
                                                                    toName:@"Metres"
                                                           conversionBlock:^float(float input) {
                                                               return input / 3.2808399;
                                                           }],
                                  [[Converter alloc] initWithConverterName:@"Miles to KM"
                                                                  fromName:@"Miles"
                                                                    toName:@"KM"
                                                           conversionBlock:^float(float input) {
                                                               return input * 1.609344;
                                                           }],
                                  [[Converter alloc] initWithConverterName:@"KM to Miles"
                                                                  fromName:@"KM"
                                                                    toName:@"Miles"
                                                           conversionBlock:^float(float input) {
                                                               return input / 1.609344;
                                                           }]
                                  ]}
                        ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.converters count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSDictionary *sectionDictionary = self.converters[section];
    
    return [sectionDictionary[@"converters"] count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *sectionDictionary = self.converters[section];
    
    return sectionDictionary[@"name"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *sectionDictionary = self.converters[indexPath.section];
    
    NSArray *converters = sectionDictionary[@"converters"];
    
    Converter *converter = converters[indexPath.row];
    
    cell.textLabel.text = converter.converterName;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *sectionDictionary = self.converters[indexPath.section];
    
    NSArray *converters = sectionDictionary[@"converters"];
    
    Converter *converter = converters[indexPath.row];
    
    [self.delegate convertPickerDidPickConverter:converter];
}

@end
