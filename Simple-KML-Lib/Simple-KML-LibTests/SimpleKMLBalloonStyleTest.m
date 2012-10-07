//
//  SimpleKMLBalloonStyle.m
//  Simple-KML-Lib
//
//  Created by Markus on 07.10.12.
//  Copyright (c) 2012 jemm. All rights reserved.
//

#import "SimpleKMLBalloonStyleTest.h"
#import "SimpleKMLBalloonStyle.h"




#import <CoreLocation/CoreLocation.h>
#import <OCMock/OCMock.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>








@implementation SimpleKMLBalloonStyleTest


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


- (void)testDefaultColors
{
    
    NSError* error;
    

    
    [(CXMLNode*)[[self.xmlChildMock stub] andReturn:@"No Colors"] name];

   
    
    
    SimpleKMLBalloonStyle* ballonStyle = [[SimpleKMLBalloonStyle alloc] initWithXMLNode:self.xmlNodeMock sourceURL:[NSURL URLWithString:@"Dummy"] error:&error];
    
    assertThat(ballonStyle, notNilValue());
    
    assertThat(ballonStyle.textColor        , notNilValue());
    assertThat(ballonStyle.textColor, equalTo([UIColor blackColor]));
    
    assertThat(ballonStyle.backgroundColor  , notNilValue());
    assertThat(ballonStyle.backgroundColor, equalTo([UIColor whiteColor]));
    
    
}


- (void)testBackgroundColor
{
    
    NSError* error;
    

    
    [(CXMLNode*)[[self.xmlChildMock stub] andReturn:@"bgColor"] name];
    
    
    
    
    SimpleKMLBalloonStyle* ballonStyle = [[SimpleKMLBalloonStyle alloc] initWithXMLNode:self.xmlNodeMock sourceURL:[NSURL URLWithString:@"Dummy"] error:&error];
    
    assertThat(ballonStyle, notNilValue());
    
    assertThat(ballonStyle.textColor        , notNilValue());
    assertThat(ballonStyle.textColor, equalTo([UIColor blackColor]));
    
    assertThat(ballonStyle.backgroundColor  , notNilValue());
    assertThat(ballonStyle.backgroundColor, equalTo([UIColor colorWithRed:(CGFloat)(221)/(CGFloat)(255)
                                                                                    green:(CGFloat)(204)/(CGFloat)(255)
                                                                                     blue:(CGFloat)(187)/(CGFloat)(255)
                                                                                    alpha:(CGFloat)(170)/(CGFloat)(255)]));
    
    
}

- (void)testTextColor
{
    
    NSError* error;
    

    
    [(CXMLNode*)[[self.xmlChildMock stub] andReturn:@"textColor"] name];
    
    
    
    
    SimpleKMLBalloonStyle* ballonStyle = [[SimpleKMLBalloonStyle alloc] initWithXMLNode:self.xmlNodeMock sourceURL:[NSURL URLWithString:@"Dummy"] error:&error];
    
    assertThat(ballonStyle, notNilValue());
    
    assertThat(ballonStyle.textColor        , notNilValue());
    assertThat(ballonStyle.textColor, equalTo([UIColor colorWithRed:(CGFloat)(221)/(CGFloat)(255)
                                                                      green:(CGFloat)(204)/(CGFloat)(255)
                                                                       blue:(CGFloat)(187)/(CGFloat)(255)
                                                                      alpha:(CGFloat)(170)/(CGFloat)(255)]));
    
    assertThat(ballonStyle.backgroundColor  , notNilValue());
    assertThat(ballonStyle.backgroundColor,equalTo([UIColor whiteColor]));
    
    
}


@end
