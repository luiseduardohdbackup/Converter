//
//  EditConverterViewController.h
//  Converter
//
//  Created by Oliver Foggin on 17/06/2013.
//  Copyright (c) 2013 Oliver Foggin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Converter;

@interface EditConverterViewController : UIViewController

@property (nonatomic, strong) Converter *converter;

@property (nonatomic, strong) void (^cancelBlock)();
@property (nonatomic, strong) void (^doneBlock)(Converter *converter);

@end
