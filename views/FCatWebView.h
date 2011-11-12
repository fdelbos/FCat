//
//  FCatWebView.h
//  CMA
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

-(void)setTopButton;
-(void)displayHtml:(NSString*)fileName;

@end
