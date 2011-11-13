//
//  FCatApplication.h
//  FCat
//
//  Created by Frederic Delbos on 11/10/11.
//  Copyright (c) 2011 Delbos Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FCatGroup.h"

@interface FCatApplication : NSObject
{
    UITabBarController *_tabBar;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSMutableArray *groups;

-(UIViewController*) getApplicationTopView;

@end
