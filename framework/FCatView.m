//
//  FCatView.m
//  CMA
//
//  Created by Frederic Delbos on 11/10/11.
//  Copyright (c) 2011 Delbos Consulting. All rights reserved.
//

#import "FCatView.h"
#import "Accueil.h"
#import "FCatGroup.h"

@implementation FCatView

@synthesize controllerName, controllerView, routes, name, title;

-(id) initWithGroup:(FCatGroup*)group
{
    if ((self = [super init]))
    {
        _group = group;
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
    UIControl *btn = [self.controllerView valueForKey:control];
    if (btn == nil)
        [NSException raise:@"FCat: FCatView" 
                    format:@"UIControl %@ not found in controller of type: %@ !", 
                    control, self.controllerName];
    [btn addTarget:self 
            action:@selector(moveOnSelect:event:) 
  forControlEvents:UIControlEventTouchUpInside];
    [_eventLinks setObject:btn forKey:dest];
}

-(void)setupView
{
    if (_eventLinks != nil)
        return;
    _eventLinks = [[NSMutableDictionary alloc] init];
    for (NSString *control in routes)
        [self addMoveAction:control move:[routes objectForKey:control]];
}

- (void)dealloc
{
    [super dealloc];
}

@end
