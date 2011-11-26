//
//  FCatWebView.m
//  FCat
//
//  Created by Frederic Delbos on 11/12/11.
//  Copyright (c) 2011 Delbos Consulting. All rights reserved.
//

#import "FCatWebView.h"

@implementation FCatWebView

@synthesize webView;
@synthesize upButton;
@synthesize htmlFile;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.webView.delegate = self;
        self.webView.scalesPageToFit = YES;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)backToTop
{
    CGPoint topOffset = CGPointMake(0, 0);
    [[[webView subviews] lastObject] setContentOffset:topOffset animated:YES];
}

-(void)setTopButton
{
    UIBarButtonItem *top = [[UIBarButtonItem alloc]
            initWithImage:[UIImage imageNamed:@"fcat_up.png"]
            style:UIBarButtonItemStyleBordered
            target:self
            action:@selector(backToTop)];
    self.navigationItem.rightBarButtonItem = top;
    [top release];
}

-(void)displayHtml
{
    NSString *path = [[NSBundle mainBundle] pathForResource:htmlFile ofType:@"html"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (data == nil)
        [NSException raise:@"FCat: FCatWebView" 
                    format:@"can't find file to display: %@.html", htmlFile];

    NSString *bpath = [[NSBundle mainBundle] bundlePath];
    [webView    loadData:data
                MIMEType:@"text/html"
        textEncodingName:@"UTF-8"
                 baseURL:[NSURL fileURLWithPath:bpath]];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([upButton isEqualToString:@"yes"])
        [self setTopButton];
    if (htmlFile)
        [self displayHtml];
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [webView release];
    [super dealloc];
}
@end
