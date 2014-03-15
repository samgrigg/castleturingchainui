//
//  CTCPuzzleRetriever.h
//  Castle Turing Chain UI
//
//  Created by samgrigg on 3/13/14.
//  Copyright (c) 2014 Grigg Brothers Produce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTCPuzzle.h"

@interface CTCPuzzleRetriever : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic) NSInteger currentPuzzleIndex;
@property (strong, nonatomic) CTCPuzzle *currentPuzzle;

- (void)requestFirstPuzzle;
- (void)requestCurrentPuzzle;
- (void)requestPuzzleAtIndex:(NSNumber *)puzzleIndex;
- (void)submitAnswer:(NSNumber *)answerCandidate;

- (void)handleAsyncPuzzleResponse:(NSData *)puzzleData;

@end
