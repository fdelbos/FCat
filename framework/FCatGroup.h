//
//  FCatGroup.h
//  CMA
//
//  Created by Frederic Delbos on 11/11/11.
//  Copyright (c) 2011 Delbos Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FCatView.h"

@interface FCatGroup : NSObject
{
    UINavigationController *_navigation;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSMutableDictionary *views;
@property (nonatomic, retain) FCatView *top;

@end
