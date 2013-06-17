//
//  EditConverterViewController.m
//  Converter
//
//  Created by Oliver Foggin on 17/06/2013.
//  Copyright (c) 2013 Oliver Foggin. All rights reserved.
//

#import "EditConverterViewController.h"

#import "Converter.h"

@interface EditConverterViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *converterNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *unitsFromTextField;
@property (weak, nonatomic) IBOutlet UITextField *unitsToTextField;
@property (weak, nonatomic) IBOutlet UITextField *multipleTextField;
@property (weak, nonatomic) IBOutlet UITextField *constantTextField;

@end

@implementation EditConverterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if (self.converter != nil) {
        self.converterNameTextField.text = self.converter.converterName;
        self.unitsFromTextField.text = self.converter.fromName;
        self.unitsToTextField.text = self.converter.toName;
        self.multipleTextField.text = [NSString stringWithFormat:@"%@", self.converter.multiple];
        self.constantTextField.text = [NSString stringWithFormat:@"%@", self.converter.constant];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonPressed:(id)sender {
    self.cancelBlock();
}

- (IBAction)doneButtonPressed:(id)sender {
    if (self.converter == nil) {
        self.converter = [[Converter alloc] initWithConverterName:self.converterNameTextField.text
                                                         fromName:self.unitsFromTextField.text
                                                           toName:self.unitsToTextField.text
                                                         multiple:[NSNumber numberWithFloat:[self.multipleTextField.text floatValue]]
                                                         constant:[NSNumber numberWithFloat:[self.constantTextField.text floatValue]]];
    } else {
        self.converter.converterName = self.converterNameTextField.text;
        self.converter.fromName = self.unitsFromTextField.text;
        self.converter.toName = self.unitsToTextField.text;
        self.converter.multiple = [NSNumber numberWithFloat:[self.multipleTextField.text floatValue]];
        self.converter.constant = [NSNumber numberWithFloat:[self.constantTextField.text floatValue]];
    }
    
    self.doneBlock(self.converter);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
