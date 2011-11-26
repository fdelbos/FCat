//
//  FCatTextInputDecorator.m
//  FCat
//
//  Created by Frederic Delbos on 11/13/11.
//  Copyright (c) 2011 Delbos Consulting. All rights reserved.
//

#import "FCatTextInputDecorator.h"

@implementation FCatTextInputDecorator

-(id)initWithController:(UIViewController*)controller;
{
    if ((self = [super init]))
    {
        _inputs = [[NSMutableArray alloc] init];
        self.controller = controller;
        self.elemFunctionsValues = [NSDictionary dictionaryWithObjectsAndKeys: 
                               @"pushInput", @"input",
                               @"setScrollerName", @"scroller",
                               nil];
        self.elemFunctionsAttributes = nil;
        _currentTextField = nil;
        _currentTextView = nil;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWasShown:)
                                                     name:UIKeyboardDidShowNotification 
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillBeHidden:)
                                                     name:UIKeyboardWillHideNotification 
                                                   object:nil];
    }
    return self;
}

-(void)pushInput
{
    NSString *input = [self.value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [_inputs addObject:input];
}

-(void)setScrollerName
{
    _scrollerName = [[NSString alloc] 
                     initWithString:[self.value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
}

-(IBAction)dismissKeyboard:(id)sender
{
    [sender resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _currentTextField = textField;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _currentTextField = nil;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    CGRect aRect = self.controller.view.frame;
    aRect.size.height -= 300;
    if(self.controller.navigationController != nil && self.controller.navigationController.navigationBarHidden == NO)
        aRect.size.height -= 44;
    CGPoint scrollPoint = CGPointMake(0.0, (textView.frame.origin.y + textView.frame.size.height + 20) + 35);
        [_scrollView setContentOffset:scrollPoint animated:YES];
}

-(void)keyboardWasShown:(NSNotification*)aNotification
{
    if(_currentTextView == nil && _currentTextField == nil)
        return;
    UIView *view = (_currentTextField != nil) ? _currentTextField : _currentTextView;
    NSDictionary* info = [aNotification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.controller.view.frame;
    aRect.size.height -= keyboardSize.height;
    if(self.controller.navigationController != nil && self.controller.navigationController.navigationBarHidden == NO)
        aRect.size.height -= 44;
    if (!CGRectContainsPoint(aRect, view.frame.origin))
    {
        CGPoint scrollPoint = CGPointMake(0.0, (view.frame.origin.y + view.frame.size.height + 20) - keyboardSize.height);
        [_scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [_scrollView setContentOffset:CGPointMake(0.0, 0.0) 
                         animated:YES];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqual:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


-(void)controllerIsDisplayed
{
    if (_scrollView != nil)
        return;
    _scrollView = [self.controller valueForKey:_scrollerName];
    for (NSString *inputName in _inputs)
    {
        id rawInput = [self.controller valueForKey:inputName];
        if ([rawInput isKindOfClass:[UITextField class]])
        {
            UITextField *field = (UITextField*)rawInput;
            [field setDelegate:self];
            [field addTarget:self 
                      action:@selector(dismissKeyboard:) 
            forControlEvents:UIControlEventEditingDidEndOnExit];
        }
        else if([rawInput isKindOfClass:[UITextView class]])
        {
            UITextView *field = (UITextView*)rawInput;
            [field setDelegate:self];
        }
        
    }
}

@end
