//
//  WebBrowserViewController.m
//  BlocBrowser
//
//  Created by Rohan on 15/11/14.
//  Copyright (c) 2014 Rohan Khara. All rights reserved.
//

#import "WebBrowserViewController.h"

@interface WebBrowserViewController () <UIWebViewDelegate, UITextFieldDelegate, UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webview;
@property (nonatomic, strong) UITextField *textField;
@property(nonatomic, strong) UIButton *backButton;
@property(nonatomic, strong) UIButton *forwardButton;
@property(nonatomic, strong) UIButton *stopButton;
@property(nonatomic, strong) UIButton *refreshButton;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, assign) NSUInteger *frameCount;
// @property (nonatomic, assign) BOOL isLoading;


@end



@implementation WebBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    // [self.activityIndicator startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator];
    
}

#pragma mark - UIViewController

-(void) loadView

{

    UIView *mainView = [UIView new];
    
    
    //Allocating & initializing  the properties
    self.webview = [UIWebView new];
    self.textField = [UITextField new];
   /* self.backButton = [UIButton new];
    self.forwardButton = [UIButton new];
    self.stopButton = [UIButton new];
    self.refreshButton = [UIButton new];*/
    
    

    //Creating the delegates
    self.webview.delegate = self;
    self.textField.delegate = self;
    
    
    // self.textField.keyboardType = UIKeyboardTypeURL;
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.placeholder = NSLocalizedString(@"Enter URL or your search query", @"Placeholder text for web browser URL field or google search box");
    self.textField.backgroundColor = self.textField.backgroundColor = [UIColor colorWithWhite:220/255.0f alpha:1];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.stopButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.forwardButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.refreshButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.backButton setEnabled:NO];
    [self.stopButton setEnabled:NO];
    [self.forwardButton setEnabled:NO];
    [self.refreshButton setEnabled:NO];
    
    [self.backButton setTitle:NSLocalizedString(@"Back", @"Back command") forState:(UIControlStateNormal)];
//    [self.backButton addTarget:self.webview action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    [self.stopButton setTitle:NSLocalizedString(@"Stop", @"Stop command") forState: (UIControlStateNormal)];
  //  [self.stopButton addTarget:self.webview action:@selector(stopLoading) forControlEvents:UIControlEventTouchUpInside];
    
    [self.refreshButton setTitle: NSLocalizedString(@"Refresh", "Refresh comand") forState:UIControlStateNormal];
    //[self.refreshButton addTarget:self.webview action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
    
    [self.forwardButton setTitle:NSLocalizedString(@"Forward", @"Forward command") forState:UIControlStateNormal];
    // [self.forwardButton addTarget:self.webview action:@selector(goForward) forControlEvents:UIControlEventTouchUpInside];
    
    // Adding the sub-views one by one
   // [mainView addSubview:self.webview];
  // [mainView addSubview:self.textField];
    
    //Adding the sub-views via a loop
    for (UIView *viewToAdd in @[self.webview, self.textField, self.refreshButton, self.backButton, self.stopButton, self.forwardButton])
        
    {
        [mainView addSubview:viewToAdd];
    
    }
    
    self.view = mainView;
    
    
    
    
   /*  NSString *urlString = @"http://www.quikr.com";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webview loadRequest:request];*/

}


-(void) viewWillLayoutSubviews

{
    // self.webview.frame = self.view.frame;
    
    static const CGFloat itemHeight = 50;
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat browserHeight = CGRectGetHeight(self.view.bounds) - itemHeight - itemHeight;

    //calculating button's width
    CGFloat buttonWidth1 = CGRectGetWidth(self.view.bounds)/4;
    
    /* Alternate way of calculating button's width
     
     CGFloat buttonWidth = CGRectGetMaxX(self.view.frame)/4;
     NSLog(@"buttonWidth: %f", buttonWidth);
     */
    
   
    
    
    // Now, assign the frames
    self.textField.frame = CGRectMake(0, 0, width, itemHeight);
    self.webview.frame = CGRectMake(0, CGRectGetMaxY(self.textField.frame), width, browserHeight);
    CGFloat currentButton = 0;
    
    for (UIButton *button in @[self.backButton, self.stopButton, self.refreshButton, self.forwardButton])
        
    {
    
        button.frame = CGRectMake(currentButton, CGRectGetMaxY(self.webview.frame), buttonWidth1, itemHeight);
        currentButton += buttonWidth1;
    
    }
    
    
    
    
}

#pragma mark - TextFieldDelegate

-(BOOL) textFieldShouldReturn:(UITextField *)tf
{

    [tf resignFirstResponder];
    NSMutableString *URLString = [tf.text mutableCopy];
  
    
    NSRange chokeRange = [URLString rangeOfString:@" "];
    
    if (chokeRange.location != NSNotFound)
        
    {
   NSString *modifiedURL = [URLString stringByReplacingOccurrencesOfString:@" " withString: @"+"];
    NSString *newURL = [@"http://www.google.com/search?q=" stringByAppendingString:modifiedURL];
        // NSString *escapedURL = [newURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *URL = [NSURL URLWithString:newURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        NSLog(@"%@", request);
    [self.webview loadRequest:request];
    }
    
    NSURL *URL = [NSURL URLWithString:URLString];
    
    if (URL)
    {
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [self.webview loadRequest:request];
    }
    
    
    
    if (!URL.scheme)
        
    {
        

        // NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",URLString]];
        NSString *newURL = [@"http://" stringByAppendingString:URLString];
        NSURL *URL = [NSURL URLWithString:newURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        [self.webview loadRequest:request];
    
    }
    
    
    return NO;
}

#pragma mark - UIWebViewDelegate

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (error.code != -999)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error")
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                              otherButtonTitles:nil];
        [alert show];
        
        [self updateButtonsAndTitle];
        self.frameCount--;
    }
}

-(void) webViewDidFinishLoad:(UIWebView *)webView

{
    // self.isLoading = YES;
    
    [self updateButtonsAndTitle];
    self.frameCount--;

}

-(void) webViewDidStartLoad:(UIWebView *)webView
{
   // self.isLoading = NO;
    [self updateButtonsAndTitle];
    self.frameCount++;

}


#pragma mark Miscellaneous

-(void) updateButtonsAndTitle

{
    NSString *webPageTitle = [self.webview stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    if (webPageTitle)
    {
        self.title = webPageTitle;
    
    }
    
    else
    {
    
        self.title = self.webview.request.URL.absoluteString;
    }
    
    self.backButton.enabled = [self.webview canGoBack];
    self.forwardButton.enabled = [self.webview canGoForward];
    self.stopButton.enabled = self.frameCount > 0;
    self.refreshButton.enabled = self.frameCount == 0;
    
    
    if (self.frameCount > 0) {
        [self.activityIndicator startAnimating];
    } else {
        [self.activityIndicator stopAnimating];
    }
    
}

-(void) resetWebView

{

    [self.webview removeFromSuperview];
    UIWebView *newWebView = [[UIWebView alloc]init];
    newWebView.delegate = self;
    [self.view addSubview:newWebView];
     
     self.webview = newWebView;
     [self addButtonTargets];
     self.textField.text = nil;
     [self updateButtonsAndTitle];


}

- (void) addButtonTargets {
    for (UIButton *button in @[self.backButton, self.forwardButton, self.stopButton, self.refreshButton]) {
        [button removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.backButton addTarget:self.webview action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.forwardButton addTarget:self.webview action:@selector(goForward) forControlEvents:UIControlEventTouchUpInside];
    [self.stopButton addTarget:self.webview action:@selector(stopLoading) forControlEvents:UIControlEventTouchUpInside];
    [self.refreshButton addTarget:self.webview action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
}


@end
