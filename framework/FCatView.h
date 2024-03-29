//
//  FCatView.h
//  FCat
//
//  Created by Frederic Delbos on 11/10/11.
//  Copyright (c) 2011 Delbos Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FCatGroup;

@interface FCatView : NSObject
{
    FCatGroup *_group;
    NSMutableDictionary *_eventLinks;  /* obj: UIControl, key: dest */
}

@property (nonatomic, retain) UIViewController *controllerView;
@property (nonatomic, copy) NSString *controllerName;
@property (nonatomic, retain) NSMutableDictionary *routes; /* obj: destination, key: action */
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSMutableArray *decorators;

-(id) initWithGroup:(FCatGroup*)group;
-(void)moveOnSelect:(id)sender event:(id)event;
-(void)controllerIsDisplayed;

@end
