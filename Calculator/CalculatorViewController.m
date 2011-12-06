//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Marios Kogias on 11/27/11.
//  Copyright (c) 2011 marioskogias@hotmail.com. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"


@interface CalculatorViewController()       
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain * brain;
@end

@implementation CalculatorViewController

@synthesize display;
@synthesize display2;
@synthesize brain = _brain;
@synthesize userIsInTheMiddleOfEnteringANumber;

-(CalculatorBrain *)brain
{
    if(!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}
- (IBAction)digitpressed:(UIButton *)sender 
{
    NSString * digit = [sender currentTitle];
    if (self.userIsInTheMiddleOfEnteringANumber) {
    self.display.text = [self.display.text stringByAppendingString:digit];
        } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    if (self.brain.waitingVariable==nil) self.display2.text = [self.display2.text stringByAppendingString:digit];
}
- (IBAction)enterPressed 
{   
    if (self.brain.waitingVariable!=nil)
    {
        [self.brain addVariable:[self.display.text doubleValue]];
        self.userIsInTheMiddleOfEnteringANumber=NO;
    } else {
    if (self.brain.piPressed) self.brain.piPressed = NO;
else {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.display2.text = [self.display2.text stringByAppendingString:@" "];
    }
}
}

- (IBAction)operationPressed:(UIButton *)sender 
{
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g",result];
    self.display2.text = [self.display2.text stringByAppendingString:operation];
    self.display2.text = [self.display2.text stringByAppendingString:@" "];
}
- (IBAction)piPressed {
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    self.display.text = [NSString stringWithString:@"π" ];
    self.display2.text = [self.display2.text stringByAppendingString:@"π "];
    [self.brain piCalculate];

   
}
- (IBAction)comaPressed 
{
    if ((self.userIsInTheMiddleOfEnteringANumber) && (!self.brain.coma)) 
    {
        self.display.text = [self.display.text stringByAppendingString:@"."];
        self.display2.text = [self.display2.text stringByAppendingString:@"."];
        self.brain.coma = YES;
    }
}

- (IBAction)clear {
    self.display.text = @"0";
    self.display2.text = @"";
    self.userIsInTheMiddleOfEnteringANumber=NO;
    [self.brain clearAll];
}

- (IBAction)variable:(id)sender 
{
    if (!(self.brain.usingVariables))
    {
        self.display.text = [NSString stringWithString:@"Please enter the variable's value"];
        self.brain.waitingVariable = [sender currentTitle];

    } else
    {
        if ([[CalculatorBrain variablesUsedInProgram:self.brain.program] containsObject:[sender currentTitle]])
            [self.brain performOperation:[sender currentTitle]];
        else
        {
            self.display.text = [NSString stringWithString:@"Please enter the variable's value"];
            self.brain.waitingVariable = [sender currentTitle];
        }
    }
    self.display2.text = [self.display2.text stringByAppendingString:[sender currentTitle]];
        self.display2.text = [self.display2.text stringByAppendingString:@" "];
}   
    
@end
