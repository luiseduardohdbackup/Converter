//
//  ConverterViewController.m
//  Converter
//
//  Created by Oliver Foggin on 14/06/2013.
//  Copyright (c) 2013 Oliver Foggin. All rights reserved.
//

#import "ConverterViewController.h"
#import "Converter.h"
#import "ConverterPickerViewController.h"

@interface ConverterViewController () <UITextFieldDelegate, ConverterPickerViewDelegate>

@property (nonatomic, strong) Converter *converter;

@property (weak, nonatomic) IBOutlet UILabel *converterNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *toNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *convertedValueLabel;

@end

@implementation ConverterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.converter = [[Converter alloc] initWithConverterName:@"Celsius to Farenheit"
                                                     fromName:@"Celsius"
                                                       toName:@"Fahrenheit"
                                              conversionBlock:^float(float input) {
                                                  return input * 9 / 5 + 32;
                                              }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setConverter:(Converter *)converter
{
    _converter = converter;
    
    self.converterNameLabel.text = self.converter.converterName;
    self.fromNameLabel.text = self.converter.fromName;
    self.toNameLabel.text = self.converter.toName;
    self.textField.text = @"0";
    
    [self convertButtonPressed:nil];
}

- (IBAction)convertButtonPressed:(id)sender {
    float input = [self.textField.text floatValue];
    
    float result = [self.converter convert:input];
    
    self.convertedValueLabel.text = [NSString stringWithFormat:@"%f", result];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ConverterPickerViewController *controller = segue.destinationViewController;
    
    controller.delegate = self;
}

- (void)convertPickerDidPickConverter:(Converter *)converter
{
    self.converter = converter;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
