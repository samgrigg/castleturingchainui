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

@synthesize firstNode = _firstNode, secondNode = _secondNode, thirdNode = _thirdNode;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.firstNode turnOn];
    [self.secondNode turnOff];
    [self.thirdNode turnOff];
    
    [firstNodeTapRecognizer addTarget:self action:@selector(handleGesture:)];
    [secondNodeTapRecognizer addTarget:self action:@selector(handleGesture:)];
    [thirdNodeTapRecognizer addTarget:self action:@selector(handleGesture:)];
    
    [self.firstNode addGestureRecognizer:firstNodeTapRecognizer];
    [self.secondNode addGestureRecognizer:secondNodeTapRecognizer];
    [self.thirdNode addGestureRecognizer:thirdNodeTapRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Gesture Recognition

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer {
    CTCCountingNode *tappedNode = (CTCCountingNode *)gestureRecognizer.view;
    
    if (tappedNode.isOn) {
        [tappedNode turnOff];
    } else {
        [tappedNode turnOn];
    }
}

@end
