//
//  CTCCountingNode.h
//  Castle Turing Chain UI
//
//  Created by pairapps on 1/10/14.
//  Copyright (c) 2014 Grigg Brothers Produce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTCCountingNode : UIView

@property (nonatomic, strong) UIColor *onColor;
@property (nonatomic, strong) UIColor *offColor;
@property (nonatomic) BOOL isOn;
@property (nonatomic) int index;

- (void) turnOn;
- (void) turnOff;

@end
