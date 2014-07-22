//
//  IMCcalculatorTests.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 22/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IMCcalculator.h"

@interface IMCcalculatorTests : XCTestCase

@end

@implementation IMCcalculatorTests

- (void)testIMCWithHeight50AndWeight100{
	CGFloat imc=[IMCcalculator calculateIMCWithWeight:50 andHeight:100];
	
  XCTAssertEqual(imc, 50, @"");
}

- (void)testIMCWithHeightAndWeight{
	CGFloat imc=[IMCcalculator calculateIMCWithWeight:0 andHeight:0];
	
  XCTAssertEqualWithAccuracy(imc, 0, 0.1 ,@"");
}




@end
