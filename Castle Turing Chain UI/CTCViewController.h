//
//  CTCViewController.h
//  Castle Turing Chain UI
//
//  Created by pairapps on 1/10/14.
//  Copyright (c) 2014 Grigg Brothers Produce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTCCountingNode.h"

@interface CTCViewController : UIViewController <UIGestureRecognizerDelegate> {
    NSArray *countingNodes;
    IBOutlet UITapGestureRecognizer *firstNodeTapRecognizer;
    IBOutlet UITapGestureRecognizer *secondNodeTapRecognizer;
    IBOutlet UITapGestureRecognizer *thirdNodeTapRecognizer;
}

@property (nonatomic, strong) IBOutlet CTCCountingNode *firstNode;
@property (nonatomic, strong) IBOutlet CTCCountingNode *secondNode;
@property (nonatomic, strong) IBOutlet CTCCountingNode *thirdNode;

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer;

@end
