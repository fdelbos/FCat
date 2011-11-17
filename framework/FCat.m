//
//  FCat.m
//  FCat
//
//  Created by Frederic Delbos on 11/10/11.
//  Copyright (c) 2011 Delbos Consulting. All rights reserved.
//

#import "FCat.h"
#import "FCatCfgParser.h"

@implementation FCat

static FCat *_instance;


+(FCat*) get
{
    @synchronized([FCat class])
    {
        if(!_instance)
            [[self alloc] init];
        return _instance;
    }
    return  nil;
}

+(id) alloc
{
    @synchronized([FCat class])
    {
        NSAssert(_instance == nil, @"FCat : Attempt to allocate another instance of FCat");
        _instance = [super alloc];
        return _instance;
    }
    return nil;
}

-(id) init
{
    if ((self = [super init]))
    {
    
    }
    return self;
}

-(void) startWithFile:(NSString*)configFile andWindow:(UIWindow*) window
{
    FCatCfgParser *parser = [[FCatCfgParser alloc] init];
    [parser parseConfig:configFile];
    _application = parser.application;
    [_application retain];
    window.rootViewController = [_application getApplicationTopView];
    [window makeKeyAndVisible];
    [parser release];
}

-(void)moveToView:(NSString*)name
{
    [[_application getCurrentGroup] moveToView:name];
}

-(FCatView*)getViewByName:(NSString*)name
{
    return [[_application getCurrentGroup].views objectForKey:name];
}

@end
