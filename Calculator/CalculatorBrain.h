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
@property (nonatomic) BOOL usingVariables;
@property (nonatomic, readonly) id program;
@property (nonatomic, strong) NSMutableArray *programStack;
@property (nonatomic,strong) NSString * waitingVariable;
@property (nonatomic,strong) NSMutableDictionary * variableValues;


-(void) pushOperand: (double)operand;
-(double) performOperation: (NSString *) operation;
-(void) piCalculate;
-(void) clearAll;
-(void) addVariable:(double) value;


+ (NSString *)descriptionOfProgram:(id)program;
+ (double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues;
+ (NSSet *) variablesUsedInProgram:(id)program;

@end



