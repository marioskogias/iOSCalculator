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
@synthesize variablesDisplay;
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
    
}
- (IBAction)enterPressed 
{   
        if (self.brain.piPressed) self.brain.piPressed = NO;
else {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.display2.text = [self.display2.text stringByAppendingString:@" "];
    }
    self.display2.text = [CalculatorBrain descriptionOfProgram:self.brain.program];
}

- (IBAction)operationPressed:(UIButton *)sender 
{
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g",result];
    self.display2.text = [CalculatorBrain descriptionOfProgram:self.brain.program];

}

- (IBAction)piPressed {
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    self.display.text = [NSString stringWithString:@"π" ];
    [self.brain piCalculate];

   
}
- (IBAction)comaPressed 
{
    if ((self.userIsInTheMiddleOfEnteringANumber) && (!self.brain.coma)) 
    {
        self.display.text = [self.display.text stringByAppendingString:@"."];
        self.brain.coma = YES;
    }
}

- (IBAction)clear {
    self.display.text = @"0";
    self.display2.text = @"";
    self.variablesDisplay.text = @"";
    self.userIsInTheMiddleOfEnteringANumber=NO;
    [self.brain clearAll];
}

-(NSString *) variableValues:(NSMutableDictionary *) dictionary
{   NSString * result = [NSString new];
    for (NSString * key in dictionary)
    {
        result = [result stringByAppendingFormat:@"  %@=%@  ", key,[dictionary objectForKey:key]];
    }
    return result;
}

- (IBAction)variable:(id)sender 
{
    if ([[CalculatorBrain variablesUsedInProgram:self.brain.program] containsObject:[sender currentTitle]]) 
        [self.brain.programStack addObject:[sender currentTitle]];
    else
        [self.brain addVariable:[sender currentTitle]];
    self.display.text = [NSString stringWithFormat:[sender currentTitle]];
    self.variablesDisplay.text = [self variableValues:self.brain.variableValues];
    
}

- (IBAction)test:(id)sender {
    NSArray * array = [NSArray new];
    if ([[sender currentTitle] isEqualToString:@"Test 1"])
        array = [NSArray arrayWithObjects:[NSNumber numberWithFloat:1],[NSNumber numberWithFloat:2],[NSNumber numberWithFloat:3],nil];
    else if ([[sender currentTitle] isEqualToString:@"Test 2"])
        array = [NSArray arrayWithObjects:[NSNumber numberWithFloat:100],[NSNumber numberWithFloat:200],[NSNumber numberWithFloat:300],nil];
    else 
        array = [NSArray arrayWithObjects:[NSNumber numberWithFloat:-1],[NSNumber numberWithFloat:-2],[NSNumber numberWithFloat:-3],nil];
    [self.brain setDictionary:array];
    self.display.text =  [NSString stringWithFormat:@"%g", [CalculatorBrain runProgram:self.brain.program usingVariableValues:self.brain.variableValues]];
    self.variablesDisplay.text = [self variableValues:self.brain.variableValues];
    
}
- (IBAction)undo {
    if (self.userIsInTheMiddleOfEnteringANumber) 
    {
        if ([self.display.text length] > 1)
        self.display.text = [self.display.text substringToIndex:[self.display.text length]];
        else self.userIsInTheMiddleOfEnteringANumber=NO;
    }
    
    
        [self.brain undo];
        self.display.text =  [NSString stringWithFormat:@"%g", [CalculatorBrain runProgram:self.brain.program usingVariableValues:self.brain.variableValues]];
        self.display2.text = [CalculatorBrain descriptionOfProgram:self.brain.program];

        
    }
}
    
- (void)viewDidUnload {
    [self setVariablesDisplay:nil];
    [super viewDidUnload];
}
@end
