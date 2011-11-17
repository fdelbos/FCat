//
//  FCatGroup.h
//  FCat
//
//  Created by Frederic Delbos on 11/11/11.
//  Copyright (c) 2011 Delbos Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FCatView.h"

@interface FCatGroup : NSObject <UINavigationControllerDelegate>

@property (nonatomic, retain) UINavigationController *navigation;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) NSMutableDictionary *views; /* obj: view, key: name */
@property (nonatomic, retain) FCatView *top;
@property (nonatomic, retain) NSString *image;
@property (nonatomic, retain) NSString *title;

-(void) setNavigationRoot;
-(void) moveToView:(NSString*)dest;

@end
