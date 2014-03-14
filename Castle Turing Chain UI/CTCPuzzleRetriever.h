//
//  CTCPuzzleRetriever.h
//  Castle Turing Chain UI
//
//  Created by samgrigg on 3/13/14.
//  Copyright (c) 2014 Grigg Brothers Produce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTCPuzzleRetriever : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (atomic) NSInteger *currentPuzzleIndex;
@property (readonly, atomic) NSDictionary *currentPuzzleDictionary;

- (void)requestFirstPuzzle;
- (void)requestPuzzleAtIndex:(NSNumber *)puzzleIndex;

@end
