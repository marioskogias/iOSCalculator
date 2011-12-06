//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Marios Kogias on 11/27/11.
//  Copyright (c) 2011 marioskogias@hotmail.com. All rights reserved.
//
#import "CalculatorBrain.h"
/*
@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;
@end
*/
@implementation CalculatorBrain

@synthesize programStack = _programStack;
@synthesize piPressed = _piPressed;
@synthesize coma = _coma;
@synthesize usingVariables = _usingVariables;
@synthesize waitingVariable = _waitingVariable;

- (NSMutableArray *)programStack
{
    if (_programStack == nil) _programStack = [[NSMutableArray alloc] init];
    return _programStack;
}

- (id)program
{
    return [self.programStack copy];
}

+ (NSString *)descriptionOfProgram:(id)program
{
    return @"Implement this in Homework #2";
}

- (void)pushOperand:(double)operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
    self.coma = NO;
}

- (double)performOperation:(NSString *)operation
{
    [self.programStack addObject:operation];
    return [[self class] runProgram:self.program usingVariableValues:self.variableValues];
    
}

+ (double)popOperandOffProgramStack:(NSMutableArray *)stack
{
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]])
    {
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]])
    {
        NSString *operation = topOfStack;
        if ([operation isEqualToString:@"+"]) {
            result = [self popOperandOffProgramStack:stack] +
            [self popOperandOffProgramStack:stack];
        } else if ([@"*" isEqualToString:operation]) {
            result = [self popOperandOffProgramStack:stack] *
            [self popOperandOffProgramStack:stack];
        } else if ([operation isEqualToString:@"-"]) {
            double subtrahend = [self popOperandOffProgramStack:stack];
            result = [self popOperandOffProgramStack:stack] - subtrahend;
        } else if ([operation isEqualToString:@"/"]) {
            double divisor = [self popOperandOffProgramStack:stack];
            if (divisor) result = [self popOperandOffProgramStack:stack] / divisor;
        } else if ([operation isEqualToString:@"sqrt"]) {
            result = sqrt([self popOperandOffProgramStack:stack]);
        } else if ([operation isEqualToString:@"sin"]) {
            result = sin([self popOperandOffProgramStack:stack]);
        } else if ([operation isEqualToString:@"cos"]) {
            result = cos([self popOperandOffProgramStack:stack]);
        }
    }
    
    return result;
}

+ (double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues
{
    NSMutableArray *stack;
    stack = [program mutableCopy];
    int i;
    if ([program isKindOfClass:[NSArray class]]) {
        
        for (i=1;i<=[stack count];i++)
        {
            if (([stack objectAtIndex:i-1]==@"a") || ([stack objectAtIndex:i-1]==@"b") || ([stack objectAtIndex:i-1]==@"c"))
            [stack insertObject:[variableValues objectForKey:[stack objectAtIndex:i-1]] atIndex:i-1];
           
        }
    
    
    }
    return [self popOperandOffProgramStack:stack];
}

-(void) piCalculate
{
    double pi = acos(-1.0);
    [self pushOperand:pi];
    self.piPressed = YES;
    
    
}

-(void) clearAll
{
    [self.programStack removeAllObjects];
    self.piPressed = NO;
    self.coma = NO;
    self.usingVariables = NO;
    self.waitingVariable = nil;

    
}

@synthesize variableValues = _variableValues;

-(void) addVariable:(double)value
{   
    if (!(self.variableValues)) self.variableValues = [NSMutableDictionary dictionary];
    NSNumber * number = [NSNumber numberWithDouble:value];
    [self.variableValues setObject:number forKey:self.waitingVariable];
    [self.programStack addObject:self.waitingVariable];
    self.waitingVariable = nil;
    self.usingVariables = YES;
}


+(NSSet *) variablesUsedInProgram:(id)program
{ 
    NSSet * usedVariablesSet;
    NSMutableArray* temp;
    
    for (NSString *string in program) {
        if ((string==@"a") || (string==@"b") || (string!=@"c"))
        {
            [temp addObject:string]; 
            
        };
    }
    
    NSArray * temp2 = [temp copy];
    usedVariablesSet = [NSSet setWithArray:temp2];
    return usedVariablesSet;
}
    
@end



