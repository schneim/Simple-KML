//
//  SimpleKMLColorTest.m
//  Simple-KML-Lib
//
//  Created by Markus on 06.10.12.
//  Copyright (c) 2012 jemm. All rights reserved.
//

#import "SimpleKMLColorTest.h"
#import "SimpleKML.h"
#import "SimpleKMLColor.h"

#import <OCMock/OCMock.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>


@implementation SimpleKMLColorTest


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
    
    SimpleKMLColor* color =  [SimpleKMLColor colorWithHexRGBString:@"#AABBCCDD"];
    
    SimpleKMLColor* checkColor =  [SimpleKMLColor colorWithComponentRed:(CGFloat)(221)/(CGFloat)(255)
                                                  green:(CGFloat)(204)/(CGFloat)(255)
                                                   blue:(CGFloat)(187)/(CGFloat)(255)
                                                  alpha:(CGFloat)(170)/(CGFloat)(255)];
    
    assertThat(color,equalTo(checkColor));
    
    
}

- (void)testColorForStringWithoutPrefix
{
    
    SimpleKMLColor* color =  [SimpleKMLColor colorWithHexRGBString:@"AABBCCDD"];
    
    SimpleKMLColor* checkColor =  [SimpleKMLColor colorWithComponentRed:(CGFloat)(221)/(CGFloat)(255)
                                                  green:(CGFloat)(204)/(CGFloat)(255)
                                                   blue:(CGFloat)(187)/(CGFloat)(255)
                                                  alpha:(CGFloat)(170)/(CGFloat)(255)];
    
    assertThat(color,equalTo(checkColor));
    
    
}


- (void)testColorForStringTooLong
{
    
    SimpleKMLColor* color =  [SimpleKMLColor colorWithHexRGBString:@"AABBCCDDEE"];
    
    
    assertThat(color,nilValue());
    
    
}

- (void)testColorForStringTooShort
{
    
    SimpleKMLColor* color =  [SimpleKMLColor colorWithHexRGBString:@"AABBCC"];
    
    
    assertThat(color,nilValue());
    
    
}

@end
