//
//  FCatView.m
//  CMA
//
//  Created by Frederic Delbos on 11/10/11.
//  Copyright (c) 2011 Delbos Consulting. All rights reserved.
//

#import "FCatView.h"

@implementation FCatView

@synthesize controllerName, controllerView, routes, name, title;



- (void)dealloc
{
    [controllerName release];
    [controllerView release];
    [routes release];
    [name release];
    [title release];
    [super dealloc];
}

@end
