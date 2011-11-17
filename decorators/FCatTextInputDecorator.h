//
//  FCatTextInputDecorator.h
//  FCat
//
//  Created by Frederic Delbos on 11/13/11.
//  Copyright (c) 2011 Delbos Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCatDecorator.h"
#import "FCatDecoratorBase.h"

@interface FCatTextInputDecorator : FCatDecoratorBase <FCatDecorator, UITextViewDelegate, UITextFieldDelegate>
{
    NSMutableArray *_inputs;
    UIScrollView *_scrollView;
    NSString *_scrollerName;
    UITextField *_currentTextField;
    UITextView *_currentTextView;
}

-(void)pushInput;
-(void)setScrollerName;


@end
