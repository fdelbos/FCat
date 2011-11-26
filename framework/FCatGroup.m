//
//  FCatGroup.m
//  FCat
//
//  Created by Frederic Delbos on 11/11/11.
//  Copyright (c) 2011 Delbos Consulting. All rights reserved.
//

#import "FCatGroup.h"

@implementation FCatGroup

@synthesize navigation, name, views, top, image, title;

-(void) setNavigationRoot
{
    navigation = [[UINavigationController alloc] initWithRootViewController:top.controllerView];
    navigation.delegate = self;
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    for (NSString* viewName in views)
    {
        FCatView *view = [views objectForKey:viewName];
        if (view.controllerView == viewController)
        {
            [view controllerIsDisplayed];
            return;
        }
    }
}

-(void)moveToView:(NSString*)dest
{
    FCatView *v = [views objectForKey:dest];
    if (v == nil)
        [NSException raise:@"FCat: FCatGroup" format:@"View named %@ could not be found!", dest];
    [navigation pushViewController:v.controllerView animated:YES];
}

- (void)dealloc
{
    if (navigation != nil)
        [navigation release];
    [super dealloc];
}

@end
