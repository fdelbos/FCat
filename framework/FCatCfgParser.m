//
//  FCatCfgParser.m
//  CMA
//
//  Created by Frederic Delbos on 11/10/11.
//  Copyright (c) 2011 Delbos Consulting. All rights reserved.
//

#import "FCatCfgParser.h"

@implementation FCatCfgParser

@synthesize application;

-(void)setApplicationTitle
{
    application.title = _currentString;
}

-(void)addRoute
{
    [_currentView.routes setObject:[_attributes objectForKey:@"destination"] 
                            forKey:[_attributes objectForKey:@"action"]];
}

-(void)addView
{
    _currentView = [[FCatView alloc] init];
    _currentView.name = [_attributes objectForKey:@"name"];
    _currentView.title = [_attributes objectForKey:@"title"];
    _currentView.controllerName = [_attributes objectForKey:@"class"];
    if ([(NSString*)[_attributes objectForKey:@"preload"] isEqual:@"1"]) 
        _currentView.controllerView = [[NSClassFromString(_currentView.controllerName) alloc] 
                                       initWithNibName:_currentView.controllerName bundle:nil];
    _currentGroup.top = _currentGroup.top == nil ? _currentGroup.top = _currentView : _currentGroup.top;
    [_currentGroup.views setObject:_currentView forKey:_currentView.name];
}

-(void)addGroup
{
    _currentGroup = [[FCatGroup alloc] init];
    _currentGroup.top = [_attributes objectForKey:@"top"];
    _currentGroup.name = [_attributes objectForKey:@"name"];
    _currentGroup.views = [[NSMutableDictionary alloc] init];
    [application.groups addObject:_currentView];
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
    _nodesWithAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                @"addRoute", @"route", 
                                                @"addView", @"view",
                                                @"addGroupe", @"groupe",
                                                nil];
    _nodesWithValue = [NSDictionary dictionaryWithObjectsAndKeys:
                                            @"setApplicationTitle", @"title", 
                                            nil];
    if (_currentString)
        [_currentString release];
    
    application = [[FCatApplication alloc] init];
    _currentString = [[NSMutableString alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:configFile ofType:@"xml"];
    NSData *content = [NSData dataWithContentsOfFile:path];
    [path release];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:content];
    [content release];
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
    [_nodesWithAttributes release];
    [_nodesWithValue release];
}

@end
