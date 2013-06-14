//
//  Converter.m
//  Converter
//
//  Created by Oliver Foggin on 14/06/2013.
//  Copyright (c) 2013 Oliver Foggin. All rights reserved.
//

#import "Converter.h"

@interface Converter ()

@property (nonatomic, copy) float (^conversionBlock)(float inputValue);

@end

@implementation Converter

- (id)initWithConverterName:(NSString *)converterName
                   fromName:(NSString *)fromName
                     toName:(NSString *)toName
            conversionBlock:(float (^)(float))conversionBlock
{
    self = [super init];
    if (self) {
        self.converterName = converterName;
        self.fromName = fromName;
        self.toName = toName;
        self.conversionBlock = conversionBlock;
    }
    return self;
}

- (float)convert:(float)value
{
    return self.conversionBlock(value);
}

@end
