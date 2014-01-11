//
//  CTCViewController.m
//  Castle Turing Chain UI
//
//  Created by pairapps on 1/10/14.
//  Copyright (c) 2014 Grigg Brothers Produce. All rights reserved.
//

#import "CTCViewController.h"

@interface CTCViewController ()

@end

@implementation CTCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [firstNode turnOn];
    [secondNode turnOff];
    [thirdNode turnOff];
    
    [self initSwipeRecognizer:swipeRecognizer forDirection:UISwipeGestureRecognizerDirectionUp withCountingNode:firstNode];
    [self initSwipeRecognizer:swipeRecognizer forDirection:UISwipeGestureRecognizerDirectionDown withCountingNode:firstNode];
    [self initSwipeRecognizer:swipeRecognizer forDirection:UISwipeGestureRecognizerDirectionUp withCountingNode:secondNode];
    [self initSwipeRecognizer:swipeRecognizer forDirection:UISwipeGestureRecognizerDirectionDown withCountingNode:secondNode];
    [self initSwipeRecognizer:swipeRecognizer forDirection:UISwipeGestureRecognizerDirectionUp withCountingNode:thirdNode];
    [self initSwipeRecognizer:swipeRecognizer forDirection:UISwipeGestureRecognizerDirectionDown withCountingNode:thirdNode];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSwipeRecognizer:(UISwipeGestureRecognizer *)swiper forDirection:(UISwipeGestureRecognizerDirection)direction withCountingNode:(CTCCountingNode *)countingNode {
    //initialize the gesture recognizer
    swiper = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    
    //set properties
    [swiper setNumberOfTouchesRequired:1];
    [swiper setDirection:direction];
    
    //add recognizer to node
    [countingNode addGestureRecognizer:swiper];
}

#pragma mark - Gesture Recognition

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer {
    UISwipeGestureRecognizer *swipe = (UISwipeGestureRecognizer *)gestureRecognizer;
    CTCCountingNode *tappedNode = (CTCCountingNode *)gestureRecognizer.view;
    
    NSLog(@"SWIPE");
    
    UISwipeGestureRecognizerDirection dir = swipe.direction;
    
    if (dir == UISwipeGestureRecognizerDirectionDown) {
        [tappedNode turnOff];
    } else {
        [tappedNode turnOn];
    }
}

@end
