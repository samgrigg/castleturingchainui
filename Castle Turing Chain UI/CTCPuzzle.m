//
//  CTCPuzzle.m
//  Castle Turing Chain UI
//
//  Created by samgrigg on 3/14/14.
//  Copyright (c) 2014 Grigg Brothers Produce. All rights reserved.
//

#import "CTCPuzzle.h"

//Puzzle Data: {
//    ErrorCount = 0;
//    IsCorrect = 0;
//    NextUri = "http://theduke.azurewebsites.net/api/bytepuzzle/0";
//    PuzzleId = 0;
//    ResponseText = "Check the boxes to create a string that represents 1 in binary.";
//    Step = 0;
//}

@implementation CTCPuzzle
@synthesize puzzleID = _puzzleID, responseText = _responseText, errorCount = _errorCount, isCorrect = _isCorrect, nextURL = _nextURL, stepNumber = _stepNumber, backingDictionary = _backingDictionary;

+ (CTCPuzzle *)puzzleFromDictionary:(NSDictionary *)sourceDictionary {
    CTCPuzzle *puzz = [[CTCPuzzle alloc] init];
    NSNumber *isCorrectNumber = [sourceDictionary objectForKey:@"IsCorrect"];
    
    puzz.errorCount = [sourceDictionary objectForKey:@"ErrorCount"];
    puzz.isCorrect = [isCorrectNumber boolValue];
    puzz.nextURL = [NSURL URLWithString:[sourceDictionary objectForKey:@"NextUri"]];
    puzz.puzzleID = [sourceDictionary objectForKey:@"PuzzleId"];
    puzz.responseText = [sourceDictionary objectForKey:@"ResponseText"];
    puzz.stepNumber = [sourceDictionary objectForKey:@"Step"];
    
    puzz.backingDictionary = sourceDictionary;
    
    return puzz;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *resultDictionary;
    
    if (self.backingDictionary) {
        resultDictionary = [self.backingDictionary mutableCopy];
    } else {
        NSString *urlString = self.nextURL.absoluteString;

        resultDictionary = [[NSMutableDictionary alloc] init];
        [resultDictionary setObject:self.errorCount forKey:@"ErrorCount"];
        [resultDictionary setObject:[NSNumber numberWithBool:self.isCorrect] forKey:@"IsCorrect"];
        [resultDictionary setObject:urlString forKey:@"NextUri"];
        [resultDictionary setObject:self.puzzleID forKey:@"PuzzleId"];
        [resultDictionary setObject:self.responseText forKey:@"ResponseText"];
        [resultDictionary setObject:self.stepNumber forKey:@"Step"];
        
//        resultDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
//                            self.errorCount, @"ErrorCount",
//                            self.isCorrect, @"IsCorrect",
//                            urlString, @"NextUri",
//                            self.puzzleID, @"PuzzleId",
//                            self.responseText, @"ResponseText",
//                            self.stepNumber, @"Step",
//                            nil];
    }
    
    return resultDictionary ;
}

@end
