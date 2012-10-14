//
//  SimpleKMLIconStyleTest.m
//  Simple-KML-Lib
//
//  Created by Markus on 14.10.12.
//  Copyright (c) 2012 jemm. All rights reserved.
//

#import "SimpleKMLIconStyleTest.h"
#import "SimpleKMLIconStyle.h"
#import "SimpleKMLImage.h"
#import <OCMock/OCMock.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@implementation SimpleKMLIconStyleTest

- (void)setUp
{
    [super setUp];
    
    self.xmlScaleMock = [OCMockObject mockForClass:[CXMLElement class]];
    [(CXMLNode*)[[self.xmlScaleMock stub] andReturn:@"scale"] name];

    
    
    self.xmlIconMock = [OCMockObject mockForClass:[CXMLElement class]];
    [(CXMLNode*)[[self.xmlIconMock stub] andReturn:@"Icon"] name];
    self.xmlIconHrefMock = [OCMockObject mockForClass:[CXMLElement class]];
    
    [[[self.xmlIconMock stub] andReturn:@[self.xmlIconHrefMock]] children];
    
    [[[self.xmlNodeMock stub] andReturn:@[self.xmlIconMock,self.xmlScaleMock]] children];
    [[[self.xmlNodeMock stub] andReturn:@"xmlString"] XMLString];
    [[[self.xmlNodeMock stub] andReturn:nil] attributeForName:@"id"];
    
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)clearCacheObjectForKey:(NSString *)key
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSString* path=  [NSString stringWithFormat:@"%@/%@", [paths objectAtIndex:0], @"SimpleKMLIconStyle"];
    
    
    NSMutableDictionary *cache = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    if ( ! cache)
        cache = [NSMutableDictionary dictionary];
    
    [cache removeObjectForKey:key];
    
    [cache writeToFile:path atomically:YES];
    
}


- (void)testIconNoCache
{
    NSError* error;

    
    NSURL* iconURL =  [[NSBundle bundleForClass:[self class]] URLForResource:@"icon21" withExtension:@"png"];
    [(CXMLNode*)[[self.xmlIconHrefMock stub] andReturn:[iconURL absoluteString]] stringValue];
    [(CXMLNode*)[[self.xmlIconHrefMock stub] andReturnValue:OCMOCK_VALUE((CXMLNodeKind){CXMLElementKind})] kind];
   
    [(CXMLNode*)[[self.xmlScaleMock stub] andReturn:@"1.0"] stringValue];
    
    
    [self clearCacheObjectForKey:[iconURL absoluteString]];
    
    SimpleKMLIconStyle* iconStyle = [[SimpleKMLIconStyle alloc] initWithXMLNode:self.xmlNodeMock sourceURL:[NSURL URLWithString:@"Dummy"] error:&error];
    
    
    assertThat(iconStyle, notNilValue());
    assertThat(iconStyle.icon, notNilValue());


    NSData* checkIconData = [[SimpleKMLImage imageWithContentsOfFile:[iconURL path]] dataFromImage];
    NSData* iconStyleIconData =[iconStyle.icon dataFromImage];
    
    assertThat(checkIconData,equalTo(iconStyleIconData));
    
    
    
    
}


- (void)testIconWithCache
{
    NSError* error;

    
    
    NSURL* iconURL =  [[NSBundle bundleForClass:[self class]] URLForResource:@"icon21" withExtension:@"png"];
    [(CXMLNode*)[[self.xmlIconHrefMock stub] andReturn:[iconURL absoluteString]] stringValue];
    [(CXMLNode*)[[self.xmlIconHrefMock stub] andReturnValue:OCMOCK_VALUE((CXMLNodeKind){CXMLElementKind})] kind];

    [(CXMLNode*)[[self.xmlScaleMock stub] andReturn:@"1.0"] stringValue];

    
    SimpleKMLIconStyle* iconStyle = [[SimpleKMLIconStyle alloc] initWithXMLNode:self.xmlNodeMock sourceURL:[NSURL URLWithString:@"Dummy"] error:&error];
    
    
    assertThat(iconStyle, notNilValue());
    assertThat(iconStyle.icon, notNilValue());
    NSData* checkIconData = [[SimpleKMLImage imageWithContentsOfFile:[iconURL path]] dataFromImage];
    NSData* iconStyleIconData =[iconStyle.icon dataFromImage];
    
    assertThat(checkIconData,equalTo(iconStyleIconData));
    
    
    
    
}



- (void)testIconFromArchive
{
    NSError* error;
   
    
    NSURL* docURL =  [[NSBundle bundleForClass:[self class]] URLForResource:@"IconStyle" withExtension:@"kmz"];
    NSURL* iconURLinArchive =  [NSURL URLWithString:@"IconStyle/files/icon21.png"];
    NSURL* iconURL =  [[NSBundle bundleForClass:[self class]] URLForResource:@"icon21" withExtension:@"png"];
    
    [(CXMLNode*)[[self.xmlIconHrefMock stub] andReturn:[iconURLinArchive path]] stringValue];
    [(CXMLNode*)[[self.xmlIconHrefMock stub] andReturnValue:OCMOCK_VALUE((CXMLNodeKind){CXMLElementKind})] kind];

    [(CXMLNode*)[[self.xmlScaleMock stub] andReturn:@"1.0"] stringValue];

    
    [self clearCacheObjectForKey:[iconURLinArchive path]];
    
    SimpleKMLIconStyle* iconStyle = [[SimpleKMLIconStyle alloc] initWithXMLNode:self.xmlNodeMock sourceURL:docURL error:&error];
    
    
    assertThat(iconStyle, notNilValue());
    assertThat(iconStyle.icon, notNilValue());
    NSData* checkIconData = [[SimpleKMLImage imageWithContentsOfFile:[iconURL path]] dataFromImage];
    NSData* iconStyleIconData =[iconStyle.icon dataFromImage];
    
    assertThat(checkIconData,equalTo(iconStyleIconData));
}

- (void)testIconWithWrongKind
{
    NSError* error;
    
    
    NSURL* iconURL =  [[NSBundle bundleForClass:[self class]] URLForResource:@"icon21" withExtension:@"png"];
    [(CXMLNode*)[[self.xmlIconHrefMock stub] andReturn:[iconURL absoluteString]] stringValue];
    
 
    [(CXMLNode*)[[self.xmlIconHrefMock expect] andReturnValue:OCMOCK_VALUE((CXMLNodeKind){CXMLAttributeKind})] kind];

    
    [self clearCacheObjectForKey:[iconURL absoluteString]];
    
    SimpleKMLIconStyle* iconStyle = [[SimpleKMLIconStyle alloc] initWithXMLNode:self.xmlNodeMock sourceURL:[NSURL URLWithString:@"Dummy"] error:&error];
    
    
    assertThat(iconStyle, nilValue());
    
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Improperly formed KML (no href specified for IconStyle Icon)"
                                                         forKey:NSLocalizedFailureReasonErrorKey];
    
    NSError* checkError = [NSError errorWithDomain:SimpleKMLErrorDomain code:SimpleKMLParseError userInfo:userInfo];
    
    assertThat(checkError, equalTo(error));
    
}

- (void)testIconWithWrongURL
{
    NSError* error;
    
    NSURL* iconURL =  [[NSBundle bundleForClass:[self class]] URLForResource:@"icon21" withExtension:@"png"];
    [(CXMLNode*)[[self.xmlIconHrefMock stub] andReturn:@"Invalid URL"] stringValue];
    [(CXMLNode*)[[self.xmlIconHrefMock stub] andReturnValue:OCMOCK_VALUE((CXMLNodeKind){CXMLElementKind})] kind];
  
    [self clearCacheObjectForKey:[iconURL absoluteString]];
    
    SimpleKMLIconStyle* iconStyle = [[SimpleKMLIconStyle alloc] initWithXMLNode:self.xmlNodeMock sourceURL:[NSURL URLWithString:@"Dummy"] error:&error];
    
    
    assertThat(iconStyle, nilValue());
    
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Improperly formed KML (invalid icon URL specified in IconStyle)"
                                                         forKey:NSLocalizedFailureReasonErrorKey];
    
    NSError* checkError = [NSError errorWithDomain:SimpleKMLErrorDomain code:SimpleKMLParseError userInfo:userInfo];
    
    assertThat(checkError, equalTo(error));
    
}

- (void)testIconNotInArchive
{
    NSError* error;
    
    
    NSURL* docURL =  [[NSBundle bundleForClass:[self class]] URLForResource:@"IconStyle" withExtension:@"kmz"];
    NSURL* iconURLinArchive =  [NSURL URLWithString:@"files/icon21.png"];
    
    
    [(CXMLNode*)[[self.xmlIconHrefMock stub] andReturn:[iconURLinArchive path]] stringValue];
    [(CXMLNode*)[[self.xmlIconHrefMock stub] andReturnValue:OCMOCK_VALUE((CXMLNodeKind){CXMLElementKind})] kind];
 
    [self clearCacheObjectForKey:[iconURLinArchive path]];
    
    SimpleKMLIconStyle* iconStyle = [[SimpleKMLIconStyle alloc] initWithXMLNode:self.xmlNodeMock sourceURL:docURL error:&error];
    
    
    assertThat(iconStyle, nilValue());
    
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Improperly formed KML (invalid icon URL specified in IconStyle)"
                                                         forKey:NSLocalizedFailureReasonErrorKey];
    
    NSError* checkError = [NSError errorWithDomain:SimpleKMLErrorDomain code:SimpleKMLParseError userInfo:userInfo];
    
    assertThat(checkError, equalTo(error));
}


- (void)testIconWithInvalideImage
{
    NSError* error;
    
    
    NSURL* iconURL =  [[NSBundle bundleForClass:[self class]] URLForResource:@"invalid_image" withExtension:@"png"];
    [(CXMLNode*)[[self.xmlIconHrefMock stub] andReturn:[iconURL absoluteString]] stringValue];
    [(CXMLNode*)[[self.xmlIconHrefMock stub] andReturnValue:OCMOCK_VALUE((CXMLNodeKind){CXMLElementKind})] kind];

    [self clearCacheObjectForKey:[iconURL absoluteString]];
    
    SimpleKMLIconStyle* iconStyle = [[SimpleKMLIconStyle alloc] initWithXMLNode:self.xmlNodeMock sourceURL:[NSURL URLWithString:@"Dummy"] error:&error];
    
    
    assertThat(iconStyle, nilValue());
    
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Improperly formed KML (unable to retrieve icon specified for IconStyle)"
                                                         forKey:NSLocalizedFailureReasonErrorKey];
    
    NSError* checkError = [NSError errorWithDomain:SimpleKMLErrorDomain code:SimpleKMLParseError userInfo:userInfo];
    
    assertThat(checkError, equalTo(error));
    
    
}


- (void)testScaleAndIcon
{
    NSError* error;
    [(CXMLNode*)[[self.xmlScaleMock stub] andReturn:@"scale"] name];
    [(CXMLNode*)[[self.xmlScaleMock expect] andReturn:@"1.1"] stringValue];

    NSURL* iconURL =  [[NSBundle bundleForClass:[self class]] URLForResource:@"icon21" withExtension:@"png"];
    [(CXMLNode*)[[self.xmlIconHrefMock stub] andReturn:[iconURL absoluteString]] stringValue];
    [(CXMLNode*)[[self.xmlIconHrefMock stub] andReturnValue:OCMOCK_VALUE((CXMLNodeKind){CXMLElementKind})] kind];
    
    [self clearCacheObjectForKey:[iconURL absoluteString]];
  
    
    SimpleKMLIconStyle* iconStyle = [[SimpleKMLIconStyle alloc] initWithXMLNode:self.xmlNodeMock sourceURL:[NSURL URLWithString:@"Dummy"] error:&error];
    
    
    
    assertThat(iconStyle, notNilValue());
    assertThat(iconStyle.icon, notNilValue());
    
    NSData* checkIconData = [[[SimpleKMLImage imageWithContentsOfFile:[iconURL path]] imageWithScale:1.1f] dataFromImage];
    NSData* iconStyleIconData =[iconStyle.icon dataFromImage];

    assertThat(checkIconData,equalTo(iconStyleIconData));
    
    
    
    
}

- (void)testWithNegativeScaleAndIcon
{
    NSError* error;
    [(CXMLNode*)[[self.xmlScaleMock stub] andReturn:@"scale"] name];
    [(CXMLNode*)[[self.xmlScaleMock expect] andReturn:@"-1.1"] stringValue];
    
    NSURL* iconURL =  [[NSBundle bundleForClass:[self class]] URLForResource:@"icon21" withExtension:@"png"];
    [(CXMLNode*)[[self.xmlIconHrefMock stub] andReturn:[iconURL absoluteString]] stringValue];
    [(CXMLNode*)[[self.xmlIconHrefMock stub] andReturnValue:OCMOCK_VALUE((CXMLNodeKind){CXMLElementKind})] kind];
    
    [self clearCacheObjectForKey:[iconURL absoluteString]];
    
    
    SimpleKMLIconStyle* iconStyle = [[SimpleKMLIconStyle alloc] initWithXMLNode:self.xmlNodeMock sourceURL:[NSURL URLWithString:@"Dummy"] error:&error];
    
    
    
    assertThat(iconStyle, nilValue());
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Improperly formed KML (invalid icon scale specified in IconStyle)"
                                                         forKey:NSLocalizedFailureReasonErrorKey];
    
    NSError* checkError = [NSError errorWithDomain:SimpleKMLErrorDomain code:SimpleKMLParseError userInfo:userInfo];
    
    assertThat(checkError, equalTo(error));

    
}





@end
