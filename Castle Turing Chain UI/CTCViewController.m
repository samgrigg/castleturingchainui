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
    
    submittingAnswer = NO;
    puzzleRetriever = [[CTCPuzzleRetriever alloc] init];
    [puzzleRetriever requestFirstPuzzle];
    
    [nc addObserver:self selector:@selector(puzzleReady:) name:@"PuzzleDataReceived" object:puzzleRetriever];
    
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

- (void)requestCurrentPuzzle {
    [puzzleLoadingProgress startAnimating];
    [puzzleRetriever requestCurrentPuzzle];
}

- (IBAction)submitButtonTap:(id)sender {
    [puzzleLoadingProgress startAnimating];
    submittingAnswer = YES;
    [puzzleRetriever submitAnswer:[self binarify:count]];
}

- (IBAction)startOverTap:(id)sender {
    submittingAnswer = NO;
    puzzleRetriever = nil;
    puzzleRetriever = [[CTCPuzzleRetriever alloc] init];
    [puzzleRetriever requestFirstPuzzle];
}

- (IBAction)cheatButtonTap:(id)sender {
    if (intLabel.isHidden) {
        [intLabel setHidden:NO];
        [cheatButton setTitle:@"Stop Cheating" forState:UIControlStateNormal];
    } else {
        [intLabel setHidden:YES];
        [cheatButton setTitle:@"Cheat" forState:UIControlStateNormal];
    }
}

- (void)puzzleReady:(NSNotification *)notification {
    [puzzleLoadingProgress stopAnimating];
    
    CTCPuzzle *puzzleToShow = puzzleRetriever.currentPuzzle;
    NSString *instructions = puzzleToShow.responseText;
    
    if (submittingAnswer) {
        submittingAnswer = NO;
        
        feedbackLabel.text = instructions;
        [feedbackLabel setHidden:NO];
        
        if (puzzleToShow.isCorrect) {
            
            [instructionLabel setHidden:YES];
            
            [self requestCurrentPuzzle];
        }
    } else {
        instructionLabel.text = instructions;
        [instructionLabel setHidden:NO];
    }
    
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
