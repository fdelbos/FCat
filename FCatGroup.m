//
//  FCatGroup.m
//  CMA
//
//  Created by Frederic Delbos on 11/11/11.
//  Copyright (c) 2011 Delbos Consulting. All rights reserved.
//

#import "FCatGroup.h"

@implementation FCatGroup

@synthesize name, views, top;

-(id) init
{
    if((self = [super init]))
    {
        _navigation = [[UINavigationController alloc] init];
        
    }
    return self;
}

- (void)dealloc
{
    [_navigation release];
    [name release];
    [views release];
    [top release];
    [super dealloc];
}

@end
