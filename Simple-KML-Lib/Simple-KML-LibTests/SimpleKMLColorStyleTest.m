//
//  SimpleKMLColorStyleTest.m
//  Simple-KML-Lib
//
//  Created by Markus on 07.10.12.
//  Copyright (c) 2012 jemm. All rights reserved.
//

#import "SimpleKMLColorStyleTest.h"
#import "SimpleKMLColorStyle.h"
#import <CoreLocation/CoreLocation.h>
#import <OCMock/OCMock.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@implementation SimpleKMLColorStyleTest
- (void)setUp
{
    [super setUp];
    
    self.xmlChildMock = [OCMockObject mockForClass:[CXMLElement class]];
    
    self.colorString = @"#AABBCCDD";
    [(CXMLNode*)[[self.xmlChildMock stub] andReturn:self.colorString] stringValue];
    
    [[[self.xmlNodeMock stub] andReturn:@[self.xmlChildMock]] children];
    [[[self.xmlNodeMock stub] andReturn:@"xmlString"] XMLString];
    [[[self.xmlNodeMock stub] andReturn:nil] attributeForName:@"id"];
    
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


- (void)testNoColor
{
    
    NSError* error;
    
    
    
    [(CXMLNode*)[[self.xmlChildMock stub] andReturn:@"No Colors"] name];
    
    
    
    
    SimpleKMLColorStyle* colorStyle = [[SimpleKMLColorStyle alloc] initWithXMLNode:self.xmlNodeMock sourceURL:[NSURL URLWithString:@"Dummy"] error:&error];
    
    assertThat(colorStyle, notNilValue());
    assertThat(colorStyle.color, nilValue());
     
    
}


- (void)testColor
{
    
    NSError* error;
    
    
    
    [(CXMLNode*)[[self.xmlChildMock stub] andReturn:@"color"] name];
    
    
    SimpleKMLColorStyle* colorStyle = [[SimpleKMLColorStyle alloc] initWithXMLNode:self.xmlNodeMock sourceURL:[NSURL URLWithString:@"Dummy"] error:&error];
    
    assertThat(colorStyle, notNilValue());
    
    assertThat(colorStyle.color  , notNilValue());
    assertThat(colorStyle.color, equalTo([UIColor colorWithRed:(CGFloat)(221)/(CGFloat)(255)
                                                                    green:(CGFloat)(204)/(CGFloat)(255)
                                                                     blue:(CGFloat)(187)/(CGFloat)(255)
                                                                    alpha:(CGFloat)(170)/(CGFloat)(255)]));
    
    
}


@end
