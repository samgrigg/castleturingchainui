//
//  PuzzleTestCase.m
//  Castle Turing Chain UI
//
//  Created by samgrigg on 5/1/14.
//  Copyright (c) 2014 Grigg Brothers Produce. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CTCPuzzle.h"

@interface PuzzleTestCase : XCTestCase

@end

@implementation PuzzleTestCase

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreatePuzzleFromDictionary
{
    NSDictionary *protoPuzzle = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"value1", @"PuzzleId",
                                 @"value2", @"ResponseText",
                                 @"value3", @"ErrorCount",
                                 @"YES", @"IsCorrect",
                                 @"value5", @"NextUri",
                                 @"value6", @"Step"
                                 , nil];
    CTCPuzzle *puzz = [CTCPuzzle puzzleFromDictionary:protoPuzzle];
    XCTAssertEqual(@"value2", puzz.responseText, @"Puzzle not created correctly from dictionary");
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

- (void)testCreateDictionaryFromPuzzle
{
    CTCPuzzle *puzz = [[CTCPuzzle alloc] init];
    
    puzz.puzzleID = 0;
    puzz.responseText = @"Foo bar";
    puzz.errorCount = 0;
    puzz.isCorrect = NO;
    puzz.nextURL = [NSURL URLWithString:@"http://google.com"];
    puzz.stepNumber = 0;
    
    NSDictionary *puzzleDict = [puzz toDictionary];
    NSString *responseText = [puzzleDict objectForKey:@"ResponseText"];
    
    XCTAssertEqual(@"Foo bar", responseText, @"Dictionary not created correctly from puzzle");
    //    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}


@end
