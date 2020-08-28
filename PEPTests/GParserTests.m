//
//  GLParserTests.m
//  PEPTests
//
//  Created by Aaron Elkins on 8/27/20.
//  Copyright © 2020 Aaron Elkins. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GParser.h"

@interface GLParserTests : XCTestCase

@end

@implementation GLParserTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testGParserSetLexer {
    GParser *p = [GParser parser];
    GLexer *l = [GLexer lexer];
    [p setLexer:l];
    XCTAssertEqual([p lexer], l);
    
    GLexer *l2 = [GLexer lexer];
    XCTAssertNotEqual([p lexer], l2);
}

- (void)testGParserParseBooleanObject {
    GParser *p = [GParser parser];
    char *b = "false true";
    NSData *d = [NSData dataWithBytes:b length:strlen(b) + 1];
    [p setStream:d];
    [p parse];
    NSMutableArray *objs = [p objects];
    NSInteger i = 0;
    for (i = 0; i < [objs count]; i++) {
        if (i == 0) {
            GBooleanObject *obj = [objs objectAtIndex:i];
            XCTAssertEqual([obj value], NO);
            XCTAssertEqualObjects([obj rawContent], [NSData dataWithBytes:"false" length:5]);
        } else if (i == 1) {
            GBooleanObject *obj = [objs objectAtIndex:i];
            XCTAssertEqual([obj value], YES);
            XCTAssertEqualObjects([obj rawContent], [NSData dataWithBytes:"true" length:4]);
        }
    }
}

- (void)testGParserParseNumberObject {
    GParser *p = [GParser parser];
    char *b = "128 -128";
    NSData *d = [NSData dataWithBytes:b length:strlen(b) + 1];
    [p setStream:d];
    [p parse];
    NSMutableArray *objs = [p objects];
    NSInteger i = 0;
    for (i = 0; i < [objs count]; i++) {
        if (i == 0) {
            GNumberObject *obj = [objs objectAtIndex:i];
            XCTAssertEqual([obj subtype], kIntSubtype);
            XCTAssertEqual([obj intValue], 128);
        } else if (i == 1) {
            GNumberObject *obj = [objs objectAtIndex:i];
            XCTAssertEqual([obj subtype], kIntSubtype);
            XCTAssertEqual([obj intValue], -128);
        }
    }
}

@end
