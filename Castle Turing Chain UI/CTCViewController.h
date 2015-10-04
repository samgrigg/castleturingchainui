//
//  CTCViewController.h
//  Castle Turing Chain UI
//
//  Created by pairapps on 1/10/14.
//  Copyright (c) 2014 Grigg Brothers Produce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTCCountingNode.h"
#import "CTCPuzzleRetriever.h"
#import "CTCPuzzle.h"

@interface CTCViewController : UIViewController <UIGestureRecognizerDelegate> {
    NSArray *countingNodes;
    NSInteger count;
    BOOL submittingAnswer;
    CTCPuzzle *currentPuzzle;
    
    IBOutlet CTCCountingNode *firstNode;
    IBOutlet CTCCountingNode *secondNode;
    IBOutlet CTCCountingNode *thirdNode;
    IBOutlet CTCCountingNode *fourthNode;
    IBOutlet CTCCountingNode *fifthNode;
    IBOutlet CTCCountingNode *sixthNode;
    IBOutlet CTCCountingNode *seventhNode;
    IBOutlet CTCCountingNode *eighthNode;
    
    IBOutlet UIView *modalRewardView;
    
    IBOutlet UIButton *submitAnswerButton;
    IBOutlet UIButton *cheatButton;
    IBOutlet UIButton *startOverButton;
    IBOutlet UILabel *intLabel;
    IBOutlet UILabel *instructionLabel;
    IBOutlet UILabel *feedbackLabel;
//    IBOutlet UILabel *charLabel;
    
    IBOutlet UIActivityIndicatorView *puzzleLoadingProgress;
    
    CTCPuzzleRetriever *puzzleRetriever;
}

- (NSString *)binarify:(NSInteger)num;
- (void)initSwipeRecognizer:(UISwipeGestureRecognizer *)swiper forDirection:(UISwipeGestureRecognizerDirection)direction withCountingNode:(CTCCountingNode *)countingNode;
- (void)initTapRecognizer:(UITapGestureRecognizer *)tapper withCountingNode:(CTCCountingNode *)countingNode;
- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer;
- (void)reportNumber;

- (void)puzzleReady:(NSNotification *)notification;
- (void)requestCurrentPuzzle;

- (IBAction)submitButtonTap:(id)sender;
- (IBAction)startOverTap:(id)sender;
- (IBAction)cheatButtonTap:(id)sender;

@end
