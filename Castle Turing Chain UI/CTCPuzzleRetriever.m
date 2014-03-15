#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define kPuzzleBaseURLString @"http://theduke.azurewebsites.net/api/bytepuzzle/"
//
//  CTCPuzzleRetriever.m
//  Castle Turing Chain UI
//
//  Created by samgrigg on 3/13/14.
//  Copyright (c) 2014 Grigg Brothers Produce. All rights reserved.
//

#import "CTCPuzzleRetriever.h"

@implementation CTCPuzzleRetriever

@synthesize currentPuzzleIndex = _currentPuzzleIndex;

- (void)requestFirstPuzzle {
    [self requestPuzzleAtIndex:[NSNumber numberWithInt:0]];
}

- (void)requestCurrentPuzzle {
    [self requestPuzzleAtIndex:[NSNumber numberWithInt:self.currentPuzzleIndex]];
}

- (void)requestPuzzleAtIndex:(NSNumber *)puzzleIndex {
    NSString *indexString = [puzzleIndex stringValue];
    NSString *puzzleStringForIndex = [kPuzzleBaseURLString stringByAppendingString:indexString];
    NSURL *puzzleURL = [NSURL URLWithString:puzzleStringForIndex];
    
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    
    NSURLRequest *apiRequest = [NSURLRequest requestWithURL:puzzleURL];
    NSMutableURLRequest *mutableAPIRequest = [apiRequest mutableCopy];
    mutableAPIRequest.HTTPMethod = @"POST";
    
    [NSURLConnection sendAsynchronousRequest:mutableAPIRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *puzzleData, NSError *error){
        if ([puzzleData length] > 0 && error == nil) {
            [self handleAsyncPuzzleResponse:puzzleData];
        }
    }];
}

- (void)submitAnswer:(NSNumber *)answerCandidate {
    NSString *indexString = [[NSNumber numberWithInt:self.currentPuzzleIndex] stringValue];
    NSString *answerCandidateString = [answerCandidate stringValue];
    NSString *puzzleStringForIndexWithAnswer = [kPuzzleBaseURLString stringByAppendingString:indexString];
    puzzleStringForIndexWithAnswer = [puzzleStringForIndexWithAnswer stringByAppendingString:@"?candidate="];
    puzzleStringForIndexWithAnswer = [puzzleStringForIndexWithAnswer stringByAppendingString:answerCandidateString];
    
    NSURL *candidateURL = [NSURL URLWithString:puzzleStringForIndexWithAnswer];
    NSURLRequest *answerRequest = [NSURLRequest requestWithURL:candidateURL];
    NSMutableURLRequest *mutableAnswerRequest = [answerRequest mutableCopy];
    mutableAnswerRequest.HTTPMethod = @"POST";
    
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    
    [NSURLConnection sendAsynchronousRequest:mutableAnswerRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *puzzleData, NSError *error) {
        if ([puzzleData length] > 0 && error == nil) {
            [self handleAsyncPuzzleResponse:puzzleData];
        }
    }];
}

-(void)handleAsyncPuzzleResponse:(NSData *)puzzleData {
    NSError *jsonError;
    NSDictionary *jsonPuzzle = [NSJSONSerialization JSONObjectWithData:puzzleData options:kNilOptions error:&jsonError];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    if (jsonError == nil) {
        NSDictionary *puzzleData = [jsonPuzzle objectForKey:@"Data"];
        self.currentPuzzle = [CTCPuzzle puzzleFromDictionary:puzzleData];
        
        NSNotification *puzzleDataReceivedNotification = [NSNotification notificationWithName:@"PuzzleDataReceived" object:self];
        
        [nc postNotification:puzzleDataReceivedNotification];
    } else {
        NSLog(@"Something wrong with JSON from server: %@", jsonError);
        
        NSNotification *puzzleDataErrorNotification = [NSNotification notificationWithName:@"PuzzleDataError" object:self];
        
        [nc postNotification:puzzleDataErrorNotification];
    }
}


#pragma mark NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed: %@", error);
}

#pragma mark NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"Did recieve response: %@", response);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"Did recieve data!!! %@", data);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Did finish loading");
}

@end
