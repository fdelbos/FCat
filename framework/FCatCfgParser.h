//
//  FCatCfgParser.h
//  CMA
//
//  Created by Frederic Delbos on 11/10/11.
//  Copyright (c) 2011 Delbos Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCatApplication.h"
#import "FCatView.h"
#import "FCatGroup.h"

@interface FCatCfgParser : NSObject <NSXMLParserDelegate>
{
    NSMutableString *_currentString;
    FCatView *_currentView;
    FCatGroup *_currentGroup;
    NSDictionary *_nodesWithAttributes;
    NSDictionary *_nodesWithValue;
    NSDictionary *_attributes;
}

@property (nonatomic, retain) FCatApplication *application;

-(void)parseConfig:(NSString*)configFile;

@end
