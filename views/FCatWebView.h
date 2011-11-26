//
//  FCatWebView.h
//  FCat
//
//  Created by Frederic Delbos on 11/12/11.
//  Copyright (c) 2011 Delbos Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCatWebView : UIViewController <UIWebViewDelegate>
{
    UIBarButtonItem *_top;
}

@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NSString *upButton;
@property (nonatomic, retain) NSString *htmlFile;

-(void)backToTop;

@end
