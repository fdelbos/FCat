//
//  FCatCfgParser.m
//  FCat
//
//  Created by Frederic Delbos on 11/10/11.
//  Copyright (c) 2011 Delbos Consulting. All rights reserved.
//

#import "FCatCfgParser.h"
#import "FCatWebView.h"

@implementation FCatCfgParser

@synthesize application;

-(id) init
{
    if ((self = [super init]))
    {
        _nodesWithAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"addRoute", @"route", 
                                @"addView", @"view",
                                @"addGroup", @"group",
                                @"addDecorator", @"decorator",
                                nil];
        _nodesWithValue = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"setApplicationTitle", @"title",
                           @"setupGroupRoot", @"group",
                           @"setTextInputScroller", @"textInputScroller",
                           @"addTextInputField", @"textInputField",
                           nil];
        _fcatViews = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"setupWebView", @"FCatWebView", nil];
    }
    return self;
}

-(void)setApplicationTitle
{
    application.title = _currentString;
}

-(void)addRoute
{
    [_currentView.routes setObject:[_attributes objectForKey:@"destination"] 
                            forKey:[_attributes objectForKey:@"action"]];
}

-(void)setupWebView
{
    NSString *html = [_attributes objectForKey:@"html"];
    if (html == nil)
        [NSException raise:@"FCat: FCatCfgParser" 
                    format:@"FCatWebView should have html attribute: for view name %@", _currentView.name];
    ((FCatWebView*)_currentView.controllerView).htmlFile = html;
    NSString *up = [_attributes objectForKey:@"up"];
    if([up isEqualToString:@"yes"])
        ((FCatWebView*)_currentView.controllerView).upButton = YES;
}

-(void)addView
{
    NSString *className = [_attributes objectForKey:@"class"];
    _currentView = [[FCatView alloc] initWithGroup:_currentGroup];
    _currentView.name = [_attributes objectForKey:@"name"];
    _currentView.title = [_attributes objectForKey:@"title"];
    _currentView.controllerName = className;
    _currentView.routes = [[NSMutableDictionary alloc] init];
    UIViewController *c = [[NSClassFromString(className) alloc] 
                           initWithNibName:_currentView.controllerName bundle:nil];
    if(c == nil)
        [NSException raise:@"FCat: FCatCfgParser" 
                    format:@"Cannot instantiate view of type %@", className];

    [c.navigationItem setTitle:_currentView.title];
    _currentView.controllerView = c;
    _currentGroup.top = (_currentGroup.top == nil) ? _currentView : _currentGroup.top;
    [_currentGroup.views setObject:_currentView forKey:_currentView.name];
    NSString *function;
    if((function = [_fcatViews objectForKey:className]))
    {
        SEL selector = NSSelectorFromString(function);
        [self performSelector:selector];
    }
}

-(void)setupGroupRoot
{
    [_currentGroup setNavigationRoot];
}

-(void)addGroup
{
    _currentGroup = [[FCatGroup alloc] init];
    _currentGroup.top = [_attributes objectForKey:@"top"];
    _currentGroup.name = [_attributes objectForKey:@"name"];
    _currentGroup.views = [[NSMutableDictionary alloc] init];
    [application.groups addObject:_currentGroup];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (_currentString)
        [_currentString appendString:string];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
 namespaceURI:(NSString *)namespaceURI 
qualifiedName:(NSString *)qName 
   attributes:(NSDictionary *)attributeDict
{
    _attributes = attributeDict;
    NSString *function;
    if((function = [_nodesWithAttributes objectForKey:elementName]))
    {
        SEL selector = NSSelectorFromString(function);
        [self performSelector:selector];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
 namespaceURI:(NSString *)namespaceURI 
qualifiedName:(NSString *)qName
{
    NSString *function;
    if((function = [_nodesWithValue objectForKey:elementName]))
    {
        SEL selector = NSSelectorFromString(function);
        [self performSelector:selector];
    }
}

-(void)parseConfig:(NSString*)configFile
{
    application = [[FCatApplication alloc] init];
    _currentString = [[NSMutableString alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:configFile ofType:@"xml"];
    NSData *content = [NSData dataWithContentsOfFile:path];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:content];

    [parser setDelegate:self];
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    
    [parser parse];
    if ([parser parserError])
    {
        [NSException raise:@"FCat: FCatCfgParser" 
                    format:@"Failed to parse config file: %@\n%@ -> %@",
         configFile,
         [[parser parserError] localizedFailureReason],
         [[parser parserError] localizedDescription]];
    }
    [parser release];
    if (_currentView)
        [_currentView release];
    if (_currentGroup)
        [_currentGroup release];
}

- (void)dealloc
{
    [application release];
    [super dealloc];
}


@end
