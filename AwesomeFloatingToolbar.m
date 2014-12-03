//
//  AwesomeFloatingToolbar.m
//  BlocBrowser
//
//  Created by Rohan on 20/11/14.
//  Copyright (c) 2014 Rohan Khara. All rights reserved.
//

#import "AwesomeFloatingToolbar.h"

@interface AwesomeFloatingToolbar ()

@property (nonatomic, strong) NSArray *currentTitles;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSArray *labels;
@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, weak) UILabel *currentLabel;
@property(nonatomic, weak) UIButton *currentButton;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) UIPinchGestureRecognizer *pinchGesture;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;

@end


@implementation AwesomeFloatingToolbar


-(instancetype) initWithFourTitles:(NSArray *)titles

{


    self = [super init];
     
     if (self)
    
    {
    
        self.currentTitles = titles;
        
        self.colors = @[[UIColor colorWithRed:199/366.0 green:158/255.0 blue:203/255.0 alpha:1],
                        [UIColor colorWithRed:255/255.0 green:105/255.0 blue:97/255.0 alpha:1],
                        [UIColor colorWithRed:222/255.0 green:165/255.0 blue:164/255.0 alpha:1],
                        [UIColor colorWithRed:255/255.0 green:179/255.0 blue:71/255.0 alpha:1]];
        
    
        NSMutableArray *labelsArray = [[NSMutableArray alloc] init];
        
        
        
        // Make the 4 buttons
        
   NSMutableArray *buttonsArray = [NSMutableArray new];
   
   for (NSString *currentTitle in self.currentTitles)
            
        {
        
            UIButton *button = [UIButton new];
            [button setEnabled:NO];
            
            NSUInteger currentTitleIndex = [self.currentTitles indexOfObject: currentTitle];
            NSString *titleForThisButton = [self.currentTitles objectAtIndex:currentTitleIndex];
            UIColor *colorForThisButton = [self.colors objectAtIndex:currentTitleIndex];
            
            [button setTitle:titleForThisButton forState:UIControlStateNormal];
             button.backgroundColor = colorForThisButton;
            [buttonsArray addObject:button];
            
        }
        
        self.buttons = buttonsArray;
        for (UIButton *thisButton in self.buttons)
            
        {
            
            if ([thisButton.currentTitle isEqual:@"Back"] && thisButton.isSelected)
            {
                
                if ([self.delegate respondsToSelector:@selector(floatingToolbar:didSelectButtonWithTitle:)])
                    
                {
                    [self.delegate floatingToolbar:self didSelectButtonWithTitle:@"Back"];
                    
                }
                
            }
            
            
            
            if ([thisButton.currentTitle isEqual:@"Refresh"] && thisButton.isSelected)
            {
                
                if ([self.delegate respondsToSelector:@selector(floatingToolbar:didSelectButtonWithTitle:)])
                    
                {
                    [self.delegate floatingToolbar:self didSelectButtonWithTitle:@"Refresh"];
                    
                }
                
            }

            
            
            if ([thisButton.currentTitle isEqual:@"Forward"] && thisButton.isSelected)
            {
                
                if ([self.delegate respondsToSelector:@selector(floatingToolbar:didSelectButtonWithTitle:)])
                    
                {
                    [self.delegate floatingToolbar:self didSelectButtonWithTitle:@"Forward"];
                    
                }
                
            }

            
            if ([thisButton.currentTitle isEqual:@"Stop"] && thisButton.isSelected)
            {
                
              
                
                
                 if ([self.delegate respondsToSelector:@selector(floatingToolbar:didSelectButtonWithTitle:)])
                    
                {
                    [self.delegate floatingToolbar:self didSelectButtonWithTitle:@"Stop"];
                    
                }
                
            }
            
            [self addSubview:thisButton];
        }
        
        
        
        
        
         // Make the 4 labels
        
         for (NSString *currentTitle in self.currentTitles)
            
        {
        
        
            UILabel *label = [UILabel new];
            label.userInteractionEnabled = NO;
            label.alpha = 0.25;
            
            NSUInteger currentTitleIndex = [self.currentTitles indexOfObject: currentTitle];
            NSString *titleForThisLabel = [self.currentTitles objectAtIndex:currentTitleIndex];
            UIColor *colorForThisLabel = [self.colors objectAtIndex:currentTitleIndex];
            
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:10];
            // label.text = titleForThisLabel;
            label.text = titleForThisLabel;
            label.backgroundColor = colorForThisLabel;
            label.textColor = [UIColor whiteColor];
            
            [labelsArray addObject:label];
            
        }
        
        self.labels = labelsArray;
        
        for (UILabel *thisLabel in self.labels)
            
            {
        
                [self addSubview:thisLabel];
            }
        
            
        
       
       self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFired:)];
        [self addGestureRecognizer:self.tapGesture];
        
        
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panFired:)];
        [self addGestureRecognizer:self.panGesture];
        
        self.pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchFired:)];
        [self addGestureRecognizer:self.pinchGesture];
        
        self.longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressFired:)];
        [self addGestureRecognizer:self.longPressGesture];
        
        }
    
    return self;
    
}


-(void) layoutSubviews

{
    
    

/* for (UIButton *thisButton in self.buttons)
        
    {
        
        NSUInteger currentButtonIndex = [self.buttons indexOfObject:thisButton];
        CGFloat buttonHeight = CGRectGetHeight (self.bounds) / 2;
        CGFloat buttonWidth = CGRectGetWidth(self.bounds) / 2;
        CGFloat buttonX = 0;
        CGFloat buttonY = 0;
        
        if (currentButtonIndex < 2)
            
        {
            
            buttonY = 0;
            
        }
        
        else
            
        {
            buttonY = CGRectGetHeight(self.bounds)/2;
            
        }
        
        
        if (currentButtonIndex %2 == 0)
            
        {
            buttonX = 0;
            
        }
        
        else
            
        {
            
            buttonX = CGRectGetWidth(self.bounds) / 2;
            
        }
        
        thisButton.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
    } */
    



    
    for (UILabel *thisLabel in self.labels)
        
    {
        
        NSUInteger currentLabelIndex = [self.labels indexOfObject:thisLabel];
        CGFloat labelHeight = CGRectGetHeight (self.bounds) / 2;
        CGFloat labelWidth = CGRectGetWidth(self.bounds) / 2;
        CGFloat labelX = 0;
        CGFloat labelY = 0;
        
        if (currentLabelIndex < 2)
            
        {
            
            labelY = 0;
            
        }
        
        else
            
        {
            labelY = CGRectGetHeight(self.bounds)/2;
            
        }
        
        
        if (currentLabelIndex %2 == 0)
            
        {
            labelX = 0;
            
        }
        
        else
            
        {
            
            labelX = CGRectGetWidth(self.bounds) / 2;
            
        }
        
        thisLabel.frame = CGRectMake(labelX, labelY, labelWidth, labelHeight);
        
    }
    
}




#pragma mark - Touch Handling

/* - (UILabel *) labelFromTouches: (NSSet *) touches withEvent: (UIEvent *) event


{

    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    UIView *subview = [self hitTest:location withEvent:event];
    return (UILabel *) subview;

} */





 -(void) tapFired: (UITapGestureRecognizer *) recognizer

{
    
    if (recognizer.state == UIGestureRecognizerStateRecognized)
        
    {
        CGPoint location = [recognizer locationInView:self];
        UIView *tappedView = [self hitTest:location withEvent:nil];
        
        if ([self.labels containsObject:tappedView])
            
        {
            
            if ([self.delegate respondsToSelector:@selector(floatingToolbar:didSelectButtonWithTitle:)])
                
            {
                
                [self.delegate floatingToolbar:self didSelectButtonWithTitle:((UILabel *) tappedView).text];
                
            }
            
            
        }
        
    }
    
    
}


-(void) longPressFired: (UILongPressGestureRecognizer *) recognizer

{
    
    
    if (recognizer.state == UIGestureRecognizerStateRecognized)
        
    {

        NSMutableArray *colors1 = [NSMutableArray new];

        [colors1 addObject:self.colors[1]];
        [colors1 addObject:self.colors[2]];
        [colors1 addObject:self.colors[3]];
        [colors1 addObject:self.colors[0]];
        
        NSMutableArray *labelsArray2 = [[NSMutableArray alloc] init];
        
        for (int i=0; i<self.colors.count; i++)
            
        {
            
            UILabel *newLabel = [UILabel new];
            newLabel.text = self.currentTitles[i];
            newLabel.textAlignment = NSTextAlignmentCenter;
            newLabel.font = [UIFont systemFontOfSize:10];
            newLabel.backgroundColor = colors1[i];
            newLabel.textColor = [UIColor whiteColor];
            [labelsArray2 addObject:newLabel];
        }
        
        self.labels = labelsArray2;
        
        for (UILabel *thisLabel in self.labels)
            
        {
            
            [self addSubview:thisLabel];
        }
        
        
        self.colors = colors1;
        
    }
    
    
}


-(void) panFired: (UIPanGestureRecognizer *) recognizer

{
    
    if (recognizer.state == UIGestureRecognizerStateChanged)
        
    {
    
    
        CGPoint translation = [recognizer translationInView:self];
        NSLog(@"New translation: %@", NSStringFromCGPoint(translation));
        
        if ([self.delegate respondsToSelector:@selector(floatingToolbar:didTryToPanWithOffset:)])
            
        {
            [self.delegate floatingToolbar:self didTryToPanWithOffset:translation];
        
        }
    
        [recognizer setTranslation:CGPointZero inView:self];
        
    }
    
    
}


 -(void) pinchFired: (UIPinchGestureRecognizer *) recognizer


{

    
        
    if (recognizer.state == UIGestureRecognizerStateChanged)
    
    {
        
       
        if ([self.delegate respondsToSelector:@selector(floatingToolbar:didTryToPinchWithScale:)])
            
        {
            [self.delegate floatingToolbar:self didTryToPinchWithScale:recognizer.scale];
            
        }
        
        
    }


}


/* -(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{

    UILabel *label = [self labelFromTouches:touches withEvent:event];
    self.currentLabel = label;
    self.currentLabel.alpha = 0.5;

}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event

{

    UILabel *label = [self labelFromTouches:touches withEvent:event];
    
    if (self.currentLabel !=label)
        
    {
    
        self.currentLabel.alpha = 1;
    
    }
    
    else
    
    {
        self.currentLabel.alpha = 0.5;
    
    }

}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event

{
    UILabel *label = [self labelFromTouches:touches withEvent:event];
    
    if (self.currentLabel == label)
        
        {
            NSLog(@"Label tapped: %@", self.currentLabel.text);
            
        
    
    if ([self.delegate respondsToSelector:@selector(floatingToolbar:didSelectButtonWithTitle:)])
        
    {
    
    
        [self.delegate floatingToolbar:self didSelectButtonWithTitle: self.currentLabel.text];
    }
}

    self.currentLabel.alpha = 1;
    self.currentLabel = nil;

}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    self.currentLabel.alpha = 1;
    self.currentLabel = nil;
}
*/

-(void) setEnabled: (BOOL) enabled forButtonWithTitle: (NSString *) title

{

    NSUInteger index = [self.currentTitles indexOfObject:title];
    
    if (index != NSNotFound)
        
    {
        UILabel *label = [self.labels objectAtIndex:index];
        label.userInteractionEnabled = enabled;
        label.alpha = enabled ? 1:0.25;
    
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
