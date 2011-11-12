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
        groups = [[NSMutableArray alloc] init];
    }
    return self;
}

-(UIViewController*) getApplicationTopView
{
    if ([groups count] > 1 && _tabBar == nil)
    {
        _tabBar = [[UITabBarController alloc] init];
    }
    FCatGroup *group = [groups objectAtIndex:0];
    return group.navigation;
}

- (void)dealloc
{
    //[_tabBar release];
    //[title release];
    [super dealloc];
}


@end
