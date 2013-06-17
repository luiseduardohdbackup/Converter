//
//  ConverterPickerViewController.m
//  Converter
//
//  Created by Oliver Foggin on 14/06/2013.
//  Copyright (c) 2013 Oliver Foggin. All rights reserved.
//

#import "ConverterPickerViewController.h"
#import "Converter.h"
#import "EditConverterViewController.h"

@interface ConverterPickerViewController ()

@property (nonatomic, strong) NSArray *converters;

@end

@implementation ConverterPickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadConverters];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadConverters
{
    NSData *encodedConverters = [[NSUserDefaults standardUserDefaults] objectForKey:@"Converters"];
    self.converters = (NSArray *)[NSKeyedUnarchiver unarchiveObjectWithData:encodedConverters];
    
    if (self.converters == nil
        || [self.converters count] == 0) {
        self.converters = @[
                            [[Converter alloc] initWithConverterName:@"Celsius to Fahrenheit"
                                                            fromName:@"Celsius"
                                                              toName:@"Fahrenheit"
                                                            multiple:@(9.0/5.0)
                                                            constant:@32.0],
                            [[Converter alloc] initWithConverterName:@"Fahrenheit to Celsius"
                                                            fromName:@"Fahrenheit"
                                                              toName:@"Celsius"
                                                            multiple:@(5.0/9.0)
                                                            constant:@(-32.0/1.8)],
                            [[Converter alloc] initWithConverterName:@"Metres to Feet"
                                                            fromName:@"Metres"
                                                              toName:@"Feet"
                                                            multiple:@3.2808399
                                                            constant:@0],
                            [[Converter alloc] initWithConverterName:@"Feet to Metres"
                                                            fromName:@"Feet"
                                                              toName:@"Metres"
                                                            multiple:@0.3047999995
                                                            constant:@0],
                            [[Converter alloc] initWithConverterName:@"Miles to KM"
                                                            fromName:@"Miles"
                                                              toName:@"KM"
                                                            multiple:@1.609344
                                                            constant:@0],
                            [[Converter alloc] initWithConverterName:@"KM to Miles"
                                                            fromName:@"KM"
                                                              toName:@"Miles"
                                                            multiple:@0.6213711922
                                                            constant:@0]
                            ];
    }
}

- (void)saveConverters
{
    NSData *encodedConverters = [NSKeyedArchiver archivedDataWithRootObject:self.converters];
    [[NSUserDefaults standardUserDefaults] setObject:encodedConverters forKey:@"Converters"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.converters count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Converter *converter = self.converters[indexPath.row];
    
    cell.textLabel.text = converter.converterName;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Converter *converter = self.converters[indexPath.row];
    
    [self.delegate convertPickerDidPickConverter:converter];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    Converter *converter = self.converters[indexPath.row];
    
    [self performSegueWithIdentifier:@"updateConverter" sender:converter];
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"updateConverter"]) {
        Converter *selectedConverter = (Converter *)sender;
        
        EditConverterViewController *controller = segue.destinationViewController;
        
        controller.converter = selectedConverter;
        [controller setCancelBlock:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [controller setDoneBlock:^(Converter *converter) {
            [self saveConverters];
            [self dismissViewControllerAnimated:YES completion:^{
                [self.tableView reloadData];
            }];
        }];
    } else {
        EditConverterViewController *controller = segue.destinationViewController;
        
        [controller setCancelBlock:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [controller setDoneBlock:^(Converter *converter) {
            self.converters = [self.converters arrayByAddingObject:converter];
            
            [self saveConverters];
            [self dismissViewControllerAnimated:YES completion:^{
                [self.tableView reloadData];
            }];
        }];
    }
}

@end
