//
//  FCatDecoratorBase.m
//  FCat
//
//  Created by Frederic Delbos on 11/13/11.
//  Copyright (c) 2011 Delbos Consulting. All rights reserved.
//

#import "FCatDecoratorBase.h"

@implementation FCatDecoratorBase

@synthesize controller, elemFunctionsValues, elemFunctionsAttributes, attributes, value;

-(void)addElement:(NSString*)elementName withAttribues:(NSDictionary*)attributes
{
    NSString *function;
    if((function = [elemFunctionsAttributes objectForKey:elementName]))
    {
        self.attributes = attributes;
        SEL selector = NSSelectorFromString(function);
        [self performSelector:selector];
    }
}

-(void)endElement:(NSString*)elementName withValue:(NSString*)value
{
    NSString *function;
    if((function = [elemFunctionsValues objectForKey:elementName]))
    {
        self.value = value;
        SEL selector = NSSelectorFromString(function);
        [self performSelector:selector];
    }
}


@end
