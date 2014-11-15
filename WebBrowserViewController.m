//
//  WebBrowserViewController.m
//  BlocBrowser
//
//  Created by Rohan on 15/11/14.
//  Copyright (c) 2014 Rohan Khara. All rights reserved.
//

#import "WebBrowserViewController.h"

@interface WebBrowserViewController () <UIWebViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UIWebView *webview;
@property (nonatomic, strong) UITextField *textField;


@end

@implementation WebBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

-(void) loadView

{

    UIView *mainView = [UIView new];
    
    
    //Allocating & initializing  the properties
    self.webview = [UIWebView new];
    self.textField = [UITextField new];

    
    

    //Creating the delegates
    self.webview.delegate = self;
    self.textField.delegate = self;
    
    
    self.textField.keyboardType = UIKeyboardTypeURL;
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.placeholder = NSLocalizedString(@"Website URL", @"Placeholder text for web browser URL field");
    self.textField.backgroundColor = self.textField.backgroundColor = [UIColor colorWithWhite:220/255.0f alpha:1];
    
    
    
    
    //Adding the sub-views
    [mainView addSubview:self.webview];
    [mainView addSubview:self.textField];
    
    
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
    CGFloat browserHeight = CGRectGetHeight(self.view.bounds) - itemHeight;
    
    // Now, assign the frames
    self.textField.frame = CGRectMake(0, 0, width, itemHeight);
    self.webview.frame = CGRectMake(0, CGRectGetMaxY(self.textField.frame), width, browserHeight);
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    NSString *URLString = textField.text;
    
    NSURL *URL = [NSURL URLWithString:URLString];
    
    if (URL) {
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        [self.webview loadRequest:request];
    }
    
    return NO;
}


@end
