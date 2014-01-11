//
//  CTCCountingNode.m
//  Castle Turing Chain UI
//
//  Created by pairapps on 1/10/14.
//  Copyright (c) 2014 Grigg Brothers Produce. All rights reserved.
//

#import "CTCCountingNode.h"

@implementation CTCCountingNode

@synthesize onColor = _onColor, offColor = _offColor, isOn = _isOn;

- (void) awakeFromNib {
    UIColor *grayColor = [UIColor grayColor];
    UIColor *yellowColor = [UIColor yellowColor];
    
    [self setOnColor:yellowColor];
    [self setOffColor:grayColor];
    
    [self turnOff];
}

- (void) turnOn {
    [self setBackgroundColor:self.onColor];
    [self setIsOn:YES];
    
    [self setNeedsDisplay];
}

- (void) turnOff {
    [self setBackgroundColor:self.offColor];
    [self setIsOn:NO];
    
    [self setNeedsDisplay];
}

@end
