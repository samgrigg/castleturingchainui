//
//  CTCPuzzle.h
//  Castle Turing Chain UI
//
//  Created by samgrigg on 3/14/14.
//  Copyright (c) 2014 Grigg Brothers Produce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTCPuzzle : NSObject

@property (strong, nonatomic) NSNumber *puzzleID;
@property (strong, nonatomic) NSString *responseText;
@property (strong, nonatomic) NSNumber *errorCount;
@property (nonatomic) BOOL isCorrect;
@property (strong, nonatomic) NSURL *nextURL;
@property (strong, nonatomic) NSNumber *stepNumber;
@property (strong, nonatomic) NSDictionary *backingDictionary;

+ (CTCPuzzle *)puzzleFromDictionary:(NSDictionary *)sourceDictionary;
- (NSDictionary *)toDictionary;

@end
