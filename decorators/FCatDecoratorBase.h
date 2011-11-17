//
//  FCatDecoratorBase.h
//  FCat
//
//  Created by Frederic Delbos on 11/13/11.
//  Copyright (c) 2011 Delbos Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCatDecoratorBase : NSObject


@property (nonatomic, retain) NSDictionary *elemFunctionsValues;
@property (nonatomic, retain) NSDictionary *elemFunctionsAttributes;
@property (nonatomic, retain) UIViewController *controller;
@property (nonatomic, retain) NSDictionary *attributes;
@property (nonatomic, retain) NSString *value;

-(void)addElement:(NSString*)elementName withAttribues:(NSDictionary*)attributes;
-(void)endElement:(NSString*)elementName withValue:(NSString*)value;


@end
