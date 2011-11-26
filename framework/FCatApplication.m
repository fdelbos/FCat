//
//  FCatApplication.m
//  FCat
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
        _currentGroup = 0;
    }
    return self;
}

-(UIViewController*) getApplicationTopView
{
    if ([groups count] > 1 && _tabBar == nil)
    {
        _tabBar = [[UITabBarController alloc] init];
        int i = 0;
        NSMutableArray *tabs = [[NSMutableArray alloc] init];
        for (FCatGroup *group in groups)
        {
            UITabBarItem *tab = [[UITabBarItem alloc] initWithTitle:group.title 
                                                              image:[UIImage imageNamed:group.image] 
                                                                tag:i];
            [group.navigation setTabBarItem:tab];
            [tabs addObject:group.navigation];
        }
        [_tabBar setViewControllers:tabs animated:YES];
        [tabs release];
        _tabBar.selectedIndex = 0;
        return _tabBar;
    }
    FCatGroup *group = [groups objectAtIndex:_currentGroup];
    return group.navigation;
}

-(FCatGroup*)getCurrentGroup
{
    return [groups objectAtIndex:_currentGroup];
}

- (void)dealloc
{
    [groups release];
    [_tabBar release];
    [super dealloc];
}


@end
