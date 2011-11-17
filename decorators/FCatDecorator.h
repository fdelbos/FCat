//
//  FCatDecorator.h
//  FCat
//
//  Created by Frederic Delbos on 11/13/11.
//  Copyright (c) 2011 Delbos Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FCatDecorator <NSObject>

-(id)initWithController:(UIViewController*)controller;
-(void)addElement:(NSString*)elementName withAttribues:(NSDictionary *)attributes;
-(void)endElement:(NSString*)elementName withValue:(NSString*)value;

@optional

-(void)controllerIsDisplayed;
-(void)controllerIsHidden;

@end
