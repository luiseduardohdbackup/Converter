//
//  Converter.m
//  Converter
//
//  Created by Oliver Foggin on 14/06/2013.
//  Copyright (c) 2013 Oliver Foggin. All rights reserved.
//

#import "Converter.h"

@implementation Converter

- (id)initWithConverterName:(NSString *)converterName
                   fromName:(NSString *)fromName
                     toName:(NSString *)toName
                   multiple:(NSNumber *)multiple
                   constant:(NSNumber *)constant
{
    self = [super init];
    if (self) {
        self.converterName = converterName;
        self.fromName = fromName;
        self.toName = toName;
        self.multiple = multiple;
        self.constant = constant;
    }
    return self;
}

- (float)convert:(float)value
{
    return value * [self.multiple floatValue] + [self.constant floatValue];
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.converterName forKey:@"converterName"];
    [encoder encodeObject:self.fromName forKey:@"fromName"];
    [encoder encodeObject:self.toName forKey:@"toName"];
    [encoder encodeObject:self.multiple forKey:@"multiple"];
    [encoder encodeObject:self.constant forKey:@"constant"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        //decode properties, other class vars
        self.converterName = [decoder decodeObjectForKey:@"converterName"];
        self.fromName = [decoder decodeObjectForKey:@"fromName"];
        self.toName = [decoder decodeObjectForKey:@"toName"];
        self.multiple = [decoder decodeObjectForKey:@"multiple"];
        self.constant = [decoder decodeObjectForKey:@"constant"];
    }
    return self;
}

@end
