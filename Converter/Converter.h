//
//  Converter.h
//  Converter
//
//  Created by Oliver Foggin on 14/06/2013.
//  Copyright (c) 2013 Oliver Foggin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Converter : NSObject

@property (nonatomic, strong) NSString *converterName;
@property (nonatomic, strong) NSString *fromName;
@property (nonatomic, strong) NSString *toName;

- (id)initWithConverterName:(NSString *)converterName
                   fromName:(NSString *)fromName
                     toName:(NSString *)toName
            conversionBlock:(float (^)(float))conversionBlock;

- (float)convert:(float)value;

@end
