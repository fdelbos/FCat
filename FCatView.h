//
//  FCatView.h
//  CMA
//
//  Created by Frederic Delbos on 11/10/11.
//  Copyright (c) 2011 Delbos Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FCatView : NSObject
{

}

@property (nonatomic, retain) UIViewController *controllerView;
@property (nonatomic, retain) NSString *controllerName;
@property (nonatomic, retain) NSMutableDictionary *routes;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *title;

@end
