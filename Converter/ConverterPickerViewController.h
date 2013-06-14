//
//  ConverterPickerViewController.h
//  Converter
//
//  Created by Oliver Foggin on 14/06/2013.
//  Copyright (c) 2013 Oliver Foggin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Converter;

@protocol ConverterPickerViewDelegate <NSObject>

- (void)convertPickerDidPickConverter:(Converter *)converter;

@end

@interface ConverterPickerViewController : UITableViewController

@property (nonatomic, weak) id <ConverterPickerViewDelegate> delegate;

@end
