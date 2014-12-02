//
//  AwesomeFloatingToolbar.h
//  BlocBrowser
//
//  Created by Rohan on 20/11/14.
//  Copyright (c) 2014 Rohan Khara. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AwesomeFloatingToolbar;
@protocol AwesomeFloatingToolbarDelegate <NSObject>

@optional

-(void) floatingToolbar: (AwesomeFloatingToolbar *)toolbar didSelectButtonWithTitle: (NSString *) title;
-(void) floatingToolbar:(AwesomeFloatingToolbar *)toolbar didTryToPanWithOffset:(CGPoint) offset;
-(void) floatingToolbar:(AwesomeFloatingToolbar *)toolbar didTryToPinchWithScale:(CGFloat) scale;



@end


@interface AwesomeFloatingToolbar : UIView

- (instancetype) initWithFourTitles: (NSArray *) titles;
- (void) setEnabled: (BOOL) enabled forButtonWithTitle: (NSString *) title;

@property (nonatomic, weak) id <AwesomeFloatingToolbarDelegate> delegate;
@end
