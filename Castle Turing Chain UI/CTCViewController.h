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
    UISwipeGestureRecognizer *swipeRecognizer;
    
    IBOutlet CTCCountingNode *firstNode;
    IBOutlet CTCCountingNode *secondNode;
    IBOutlet CTCCountingNode *thirdNode;
}

- (void)initSwipeRecognizer:(UISwipeGestureRecognizer *)swiper forDirection:(UISwipeGestureRecognizerDirection)direction withCountingNode:(CTCCountingNode *)countingNode;
- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer;

@end
