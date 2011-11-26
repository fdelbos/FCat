//
//  FCatView.m
//  FCat
//
//  Created by Frederic Delbos on 11/10/11.
//  Copyright (c) 2011 Delbos Consulting. All rights reserved.
//

#import "FCatView.h"
#import "Accueil.h"
#import "FCatGroup.h"
#import "FCatDecorator.h"
#import <Foundation/NSException.h>

@implementation FCatView

@synthesize controllerName, controllerView, routes, name, title, decorators;

-(id) initWithGroup:(FCatGroup*)group
{
    if ((self = [super init]))
    {
        _group = group;
        decorators = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)moveOnSelect:(id)sender event:(id)event
{
    for (NSString *dest in _eventLinks)
    {
        UIControl *c = [_eventLinks objectForKey:dest];
        if (c == sender)
            [_group moveToView:dest];
    }
}

-(void)addMoveAction:(NSString*)control move:(NSString*)dest
{
    UIControl *btn;
    @try
    {
        btn = [self.controllerView valueForKey:control];
    } @catch (NSException *e) {
        return;
    }
    [btn addTarget:self 
            action:@selector(moveOnSelect:event:) 
  forControlEvents:UIControlEventTouchUpInside];
    [_eventLinks setObject:btn forKey:dest];
}

-(void)controllerIsDisplayed
{
    if (_eventLinks == nil)
    {
        _eventLinks = [[NSMutableDictionary alloc] init];
        for (NSString *control in routes)
            [self addMoveAction:control move:[routes objectForKey:control]];
    }
    for (id <FCatDecorator> decorator in decorators)
        [decorator controllerIsDisplayed];
}

- (void)dealloc
{
    [decorators release];
    if(_eventLinks != nil)
        [_eventLinks release];
    [super dealloc];
}

@end
