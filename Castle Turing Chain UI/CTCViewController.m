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
    
    instructionLabel.text = @"Loading";
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    puzzleRetriever = [[CTCPuzzleRetriever alloc] init];
    [puzzleRetriever requestFirstPuzzle];
    
    [nc addObserver:self selector:@selector(showPuzzle:) name:@"PuzzleDataReceived" object:puzzleRetriever];
    
    count = 0;
    [self reportNumber];
//    [firstNode turnOn];
    
    countingNodes = [NSArray arrayWithObjects:eighthNode, seventhNode, sixthNode, fifthNode, fourthNode, thirdNode, secondNode, firstNode, nil];
    
    int i = 7;
    UISwipeGestureRecognizer *swipeRecognizer;
    UITapGestureRecognizer *tapRecognizer;
    for (CTCCountingNode *node in countingNodes) {
        node.index = i--;
        [self initSwipeRecognizer:swipeRecognizer forDirection:UISwipeGestureRecognizerDirectionUp withCountingNode:node];
        [self initSwipeRecognizer:swipeRecognizer forDirection:UISwipeGestureRecognizerDirectionDown withCountingNode:node];
        [self initTapRecognizer:tapRecognizer withCountingNode:node];
    }
}

- (void)showPuzzle:(NSNotification *)puzzleNotification {
    [puzzleLoadingProgress stopAnimating];
    
    NSDictionary *puzzleData = puzzleRetriever.currentPuzzleDictionary;
    NSString *instructions = [puzzleData objectForKey:@"ResponseText"];
    
    instructionLabel.text = instructions;
    [instructionLabel setHidden:NO];
    [self.view setNeedsDisplay];
}

- (NSString *)binarify:(NSInteger)num {
    NSString *renderedBinary = @"";
    
    //right now hard-coded at 8 bits.
    int numBits = 8;
    for (int i = 0; i<numBits; i++) {
        NSInteger bit = (num>>i)&1;
        NSString *bit_string = [NSString stringWithFormat:@"%d", bit];
        
        renderedBinary = [bit_string stringByAppendingString:renderedBinary];
    }
    
    return renderedBinary;
}

- (void)reportNumber {
    NSNumber *num = [NSNumber numberWithInt:count];
    //char charVal = [num charValue];
    
    intLabel.text = [num stringValue];
    //charLabel.text = [NSString stringWithFormat:@"%c", charVal];
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

- (void)initTapRecognizer:(UITapGestureRecognizer *)tapper withCountingNode:(CTCCountingNode *)countingNode {
    //initialize the gesture recognizer
    tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    
    //set properties
    [tapper setNumberOfTapsRequired:1];
    
    //add recognizer to node
    [countingNode addGestureRecognizer:tapper];
}

#pragma mark - Gesture Recognition

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer {
    //UISwipeGestureRecognizer *swipe = (UISwipeGestureRecognizer *)gestureRecognizer;
    CTCCountingNode *tappedNode = (CTCCountingNode *)gestureRecognizer.view;
    NSNumber *tappedIndex = [NSNumber numberWithInteger:tappedNode.index];
    
    double delta = pow(2.0, [tappedIndex doubleValue]);
    
    if (tappedNode.isOn) {
        count -= delta;
        [tappedNode turnOff];
    } else if (!tappedNode.isOn) {
        count += delta;
        [tappedNode turnOn];
    }
    
    [self reportNumber];
}

@end
