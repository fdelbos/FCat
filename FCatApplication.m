//
//  FCatApplication.m
//  CMA
//
//  Created by Frederic Delbos on 11/10/11.
//  Copyright (c) 2011 Delbos Consulting. All rights reserved.
//

#import "FCatApplication.h"
#import "FCatGroup.h"

@implementation FCatApplication

@synthesize title, groups;

-(id) init
{
    if ((self = [super init]))
    {
        _tabBar = [[UITabBarController alloc] init];
    }
    return self;
}

-(UIViewController*) getApplicationTopView
{
    if ([groups count] > 1)
    {
        _tabBar = [[UITabBarController alloc] init];
    }
    return ((FCatGroup*)[groups objectAtIndex:0]).top.controllerView;
}

- (void)dealloc
{
    [_tabBar release];
    [title release];
    [groups release];
    [super dealloc];
}


@end
