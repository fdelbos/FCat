//
//  FCat.h
//  CMA
//
//  Created by Frederic Delbos on 11/10/11.
//  Copyright (c) 2011 Delbos Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FCatApplication.h"

@interface FCat : NSObject
{
    UIWindow *_window;
    FCatApplication *_application;
}

+(FCat*) get;
-(void) startWithFile:(NSString*)configFile andWindow:(UIWindow*) window;

@end
