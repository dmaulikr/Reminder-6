//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by John  on 4/6/14.
//  Copyright (c) 2014 Crescendo. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@interface BNRHypnosisViewController () <UITextFieldDelegate>
@property (nonatomic, weak) UITextField *textField;
@end

@implementation BNRHypnosisViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self) {
        // Set the tab bar item's title
        self.tabBarItem.title = @"Hypnotize";
        // Create a UIImage from a file
        // This will use Hypno@2x.png on retina display devices
        UIImage *i = [UIImage imageNamed:@"Hypno.png"];
        // Put that image on the tab bar item
        self.tabBarItem.image = i;
    }
    return self;
}

- (void)loadView
{
    // Create a view
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] init];
    // Set it as *the* view of this view controller
    self.view = backgroundView;
    
    CGRect textFieldRect = CGRectMake(40, 70, 240, 30);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];
    // Setting the border style on the text field will allow us to see it more easily
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Hypnotize me";
    textField.returnKeyType = UIReturnKeyDone;
    // There will be a warning on this line. We will discuss it shortly.
    textField.delegate = self;
    self.textField = textField;
    [backgroundView addSubview:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self drawHypnoticMessage:textField.text];
    [textField resignFirstResponder];
    return YES;
}

- (void)drawHypnoticMessage:(NSString *)message
{
    for (int i = 0; i < 20; i++) {
        UILabel *messageLabel = [[UILabel alloc] init];
        // Configure the label's colors and text
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.text = message;
        // This method resizes the label, which will be relative
        // to the text that it is displaying
        [messageLabel sizeToFit];
        // Get a random x value that fits within the hypnosis view's width
        int width =
        (int)(self.view.bounds.size.width -
              messageLabel.bounds.size.width);
        int x = arc4random() % width;
        // Get a random y value that fits within the hypnosis view's height
        int height =
        (int)(self.view.bounds.size.height -
              messageLabel.bounds.size.height);
        int y = arc4random() % height;
        // Update the label's frame
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;
        // Add the label to the hierarchy
        [self.view addSubview:messageLabel];
        
        // Set the label's initial alpha
        messageLabel.alpha = 0.0;
        // Animate the alpha to 1.0
        [UIView animateWithDuration:0.5 animations:^{
            messageLabel.alpha = 1.0;
        }];
        
        [UIView animateKeyframesWithDuration:1.0 delay:0.0 options:0
                                  animations:^{
                                      [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.8
                                                                    animations:^{
                                                                        messageLabel.center = self.view.center;
                                                                    }];
                                      [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2
                                                                    animations:^{
                                                                        int x = arc4random() % width;
                                                                        int y = arc4random() % height;
                                                                        messageLabel.center = CGPointMake(x, y);
                                                                    }];
                                  } completion:NULL];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:1.5
                          delay:0.0
         usingSpringWithDamping:0.25
          initialSpringVelocity:0.0
                        options:0
                     animations:^{
                         CGRect frame = CGRectMake(40, 70, 240, 80);
                         self.textField.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"Animation finished");
                     }];
}

@end
