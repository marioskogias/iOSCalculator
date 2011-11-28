//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Marios Kogias on 11/27/11.
//  Copyright (c) 2011 marioskogias@hotmail.com. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain() 
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain
@synthesize operandStack = _operandStack;
@synthesize piPressed = _piPressed;

- (NSMutableArray *) operandStack
{
    if (!_operandStack) {
        _operandStack = [[NSMutableArray alloc] init];    
    }
    return _operandStack;
}

-(void) pushOperand:(double)operand
{
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
}

-(double) popOperand 
{
    NSNumber * operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

-(double) performOperation: (NSString *)operation
{
    double result = 0;
   if ([operation isEqualToString:@"+"])
   {
       result = [self popOperand] + [self popOperand];
   } else if ([operation isEqualToString:@"*"])
   {
       result = [self popOperand] * [self popOperand];
   } else if ([operation isEqualToString:@"-"])
   {
       double subtrahend = [self popOperand];
       result = [self popOperand] - subtrahend;
   } else if ([operation isEqualToString:@"/"])
   {
       double divisor = [self popOperand];
       if (divisor) {result = [self popOperand] / divisor; }
   } else if ([operation isEqualToString:@"sqrt"])
   {
       result = sqrt([self popOperand]);
   } else if ([operation isEqualToString:@"sin"])
   {
       result = sin([self popOperand]);
   } else if ([operation isEqualToString:@"cos"])
   {
       result = cos([self popOperand]);
   }
    
    [self pushOperand:result];
    return result;
}

-(void) piCalculate
{
    double pi = acos(-1.0);
    [self pushOperand:pi];
    self.piPressed = YES;
    
    
}
@end
