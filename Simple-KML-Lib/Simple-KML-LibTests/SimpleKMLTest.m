//
//  SimpleKMLTest.m
//  Simple-KML-Lib
//
//  Created by Markus on 02.10.12.
//  Copyright (c) 2012 jemm. All rights reserved.
//

#import "SimpleKMLTest.h"
#import "SimpleKML.h"

#import <OCMock/OCMock.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>


@implementation SimpleKMLTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testColorForStringDefault
{
 
    UIColor* color =  [SimpleKML colorForString:@"#AABBCCDD"];
    
    UIColor* checkColor =  [UIColor colorWithCGColor:[SimpleKMLColor colorWithComponentRed:(CGFloat)(221)/(CGFloat)(255)
                                                        green:(CGFloat)(204)/(CGFloat)(255)
                                                         blue:(CGFloat)(187)/(CGFloat)(255)
                                                        alpha:(CGFloat)(170)/(CGFloat)(255)].cgColor];
        
    assertThat(color,equalTo(checkColor));
    
    
}

- (void)testColorForStringWithoutPrefix
{
    
    UIColor* color =  [SimpleKML colorForString:@"AABBCCDD"];
    
    UIColor* checkColor =  [UIColor colorWithCGColor:[SimpleKMLColor colorWithComponentRed:(CGFloat)(221)/(CGFloat)(255)
                                                  green:(CGFloat)(204)/(CGFloat)(255)
                                                   blue:(CGFloat)(187)/(CGFloat)(255)
                                                  alpha:(CGFloat)(170)/(CGFloat)(255)].cgColor];
    
    assertThat(color,equalTo(checkColor));
    
    
}


- (void)testColorForStringTooLong
{
    
    UIColor* color =  [SimpleKML colorForString:@"AABBCCDDEE"];
    
    
    assertThat(color,nilValue());
    
    
}

- (void)testColorForStringTooShort
{
    
    UIColor* color =  [SimpleKML colorForString:@"AABBCC"];
    
    
    assertThat(color,nilValue());
    
    
}


@end
