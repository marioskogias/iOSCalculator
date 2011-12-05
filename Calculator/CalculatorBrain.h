//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Marios Kogias on 11/27/11.
//  Copyright (c) 2011 marioskogias@hotmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject
@property (nonatomic) BOOL piPressed;
@property (nonatomic) BOOL coma;
@property (nonatomic, readonly) id program;

-(void) pushOperand: (double)operand;
-(double) performOperation: (NSString *) operation;
-(void) piCalculate;
-(void) clearAll;

+ (NSString *)descriptionOfProgram:(id)program;
+ (double)runProgram:(id)program;

@end



