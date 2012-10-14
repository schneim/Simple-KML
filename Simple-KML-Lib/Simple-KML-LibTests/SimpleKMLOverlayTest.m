//
//  SimpleKMLOverlay.m
//  Simple-KML-Lib
//
//  Created by Markus on 07.10.12.
//  Copyright (c) 2012 jemm. All rights reserved.
//

#import "SimpleKMLOverlayTest.h"
#import "SimpleKMLOverlay.h"
#import "SimpleKMLColor.h"

#import <OCMock/OCMock.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>


@implementation SimpleKMLOverlayTest

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


- (void)clearCacheObjectForKey:(NSString *)key
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSString* path=  [NSString stringWithFormat:@"%@/%@", [paths objectAtIndex:0], @"SimpleKMLOverlay"];
    
    
    NSMutableDictionary *cache = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    if ( ! cache)
        cache = [NSMutableDictionary dictionary];
    
    [cache removeObjectForKey:key];
    
    [cache writeToFile:path atomically:YES];
    
}

- (void)testNoColor
{
    
    NSError* error;
    
    
    
    [(CXMLNode*)[[self.xmlChildMock stub] andReturn:@"No Colors"] name];
    
    
    
    
    SimpleKMLOverlay* overlay = [[SimpleKMLOverlay alloc] initWithXMLNode:self.xmlNodeMock sourceURL:[NSURL URLWithString:@"Dummy"] error:&error];
    
    assertThat(overlay, notNilValue());
    assertThat(overlay.color, nilValue());
    
    
}


- (void)testColor
{
    
    NSError* error;
    
    
    
    [(CXMLNode*)[[self.xmlChildMock stub] andReturn:@"color"] name];
    
    
    SimpleKMLOverlay* overlay = [[SimpleKMLOverlay alloc] initWithXMLNode:self.xmlNodeMock sourceURL:[NSURL URLWithString:@"Dummy"] error:&error];
    
    assertThat(overlay, notNilValue());
    
    assertThat(overlay.color  , notNilValue());
    assertThat(overlay.color, equalTo([SimpleKMLColor colorWithComponentRed:(CGFloat)(221)/(CGFloat)(255)
                                                         green:(CGFloat)(204)/(CGFloat)(255)
                                                          blue:(CGFloat)(187)/(CGFloat)(255)
                                                         alpha:(CGFloat)(170)/(CGFloat)(255)]));
    
    
}


- (void)testIconNoCache
{
      NSError* error;
    [(CXMLNode*)[[self.xmlChildMock stub] andReturn:@"Icon"] name];
    OCMockObject* xmlGrandchildMock = [OCMockObject mockForClass:[CXMLElement class]];
    [[[self.xmlChildMock stub] andReturn:@[xmlGrandchildMock]] children];
    [(CXMLNode*)[[xmlGrandchildMock stub] andReturnValue:OCMOCK_VALUE((CXMLNodeKind){CXMLElementKind})] kind];

    
    NSURL* iconURL =  [[NSBundle bundleForClass:[self class]] URLForResource:@"icon21" withExtension:@"png"];
    [(CXMLNode*)[[xmlGrandchildMock stub] andReturn:[iconURL absoluteString]] stringValue];
    
    [self clearCacheObjectForKey:[iconURL absoluteString]];
    
     SimpleKMLOverlay* overlay = [[SimpleKMLOverlay alloc] initWithXMLNode:self.xmlNodeMock sourceURL:[NSURL URLWithString:@"Dummy"] error:&error];
    
    
    assertThat(overlay, notNilValue());
    assertThat(overlay.icon, notNilValue());
    NSData* checkIconData = UIImagePNGRepresentation([UIImage imageWithContentsOfFile:[iconURL path]]);
    NSData* overlayIconData =UIImagePNGRepresentation(overlay.icon);
  
    assertThat(checkIconData,equalTo(overlayIconData));
     
    
    
    
}

- (void)testIconWithCache
{
    NSError* error;
    [(CXMLNode*)[[self.xmlChildMock stub] andReturn:@"Icon"] name];
    OCMockObject* xmlGrandchildMock = [OCMockObject mockForClass:[CXMLElement class]];
    [[[self.xmlChildMock stub] andReturn:@[xmlGrandchildMock]] children];
    [(CXMLNode*)[[xmlGrandchildMock stub] andReturnValue:OCMOCK_VALUE((CXMLNodeKind){CXMLElementKind})] kind];
    
    
    NSURL* iconURL =  [[NSBundle bundleForClass:[self class]] URLForResource:@"icon21" withExtension:@"png"];
    [(CXMLNode*)[[xmlGrandchildMock stub] andReturn:[iconURL absoluteString]] stringValue];
    

    
    SimpleKMLOverlay* overlay = [[SimpleKMLOverlay alloc] initWithXMLNode:self.xmlNodeMock sourceURL:[NSURL URLWithString:@"Dummy"] error:&error];
    
    
    assertThat(overlay, notNilValue());
    assertThat(overlay.icon, notNilValue());
    NSData* checkIconData = UIImagePNGRepresentation([UIImage imageWithContentsOfFile:[iconURL path]]);
    NSData* overlayIconData =UIImagePNGRepresentation(overlay.icon);
    
    assertThat(checkIconData,equalTo(overlayIconData));
    
    
    
    
}


- (void)testIconFromArchive
{
    NSError* error;
    [(CXMLNode*)[[self.xmlChildMock stub] andReturn:@"Icon"] name];
    OCMockObject* xmlGrandchildMock = [OCMockObject mockForClass:[CXMLElement class]];
    [[[self.xmlChildMock stub] andReturn:@[xmlGrandchildMock]] children];
    [(CXMLNode*)[[xmlGrandchildMock stub] andReturnValue:OCMOCK_VALUE((CXMLNodeKind){CXMLElementKind})] kind];
    
    
    NSURL* docURL =  [[NSBundle bundleForClass:[self class]] URLForResource:@"IconStyle" withExtension:@"kmz"];
    NSURL* iconURLinArchive =  [NSURL URLWithString:@"IconStyle/files/icon21.png"];
    NSURL* iconURL =  [[NSBundle bundleForClass:[self class]] URLForResource:@"icon21" withExtension:@"png"];
    
    [(CXMLNode*)[[xmlGrandchildMock stub] andReturn:[iconURLinArchive path]] stringValue];
    
     [self clearCacheObjectForKey:[iconURLinArchive path]];
    
    SimpleKMLOverlay* overlay = [[SimpleKMLOverlay alloc] initWithXMLNode:self.xmlNodeMock sourceURL:docURL error:&error];
    
    
    assertThat(overlay, notNilValue());
    assertThat(overlay.icon, notNilValue());
    NSData* checkIconData = UIImagePNGRepresentation([UIImage imageWithContentsOfFile:[iconURL path]]);
    NSData* overlayIconData =UIImagePNGRepresentation(overlay.icon);
    
    assertThat(checkIconData,equalTo(overlayIconData));
}


- (void)testIconWithWrongKind
{
    NSError* error;
    [(CXMLNode*)[[self.xmlChildMock stub] andReturn:@"Icon"] name];
    OCMockObject* xmlGrandchildMock = [OCMockObject mockForClass:[CXMLElement class]];
    [[[self.xmlChildMock stub] andReturn:@[xmlGrandchildMock]] children];
    [(CXMLNode*)[[xmlGrandchildMock stub] andReturnValue:OCMOCK_VALUE((CXMLNodeKind){CXMLAttributeKind})] kind];
    
    
    NSURL* iconURL =  [[NSBundle bundleForClass:[self class]] URLForResource:@"icon21" withExtension:@"png"];
    [(CXMLNode*)[[xmlGrandchildMock stub] andReturn:[iconURL absoluteString]] stringValue];
    
    [self clearCacheObjectForKey:[iconURL absoluteString]];
    
    SimpleKMLOverlay* overlay = [[SimpleKMLOverlay alloc] initWithXMLNode:self.xmlNodeMock sourceURL:[NSURL URLWithString:@"Dummy"] error:&error];
    
    
    assertThat(overlay, nilValue());
    
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Improperly formed KML (no href specified for Overlay Icon)"
                                                         forKey:NSLocalizedFailureReasonErrorKey];

    NSError* checkError = [NSError errorWithDomain:SimpleKMLErrorDomain code:SimpleKMLParseError userInfo:userInfo];
    
    assertThat(checkError, equalTo(error));
    
}


- (void)testIconWithWrongURL
{
    NSError* error;
    [(CXMLNode*)[[self.xmlChildMock stub] andReturn:@"Icon"] name];
    OCMockObject* xmlGrandchildMock = [OCMockObject mockForClass:[CXMLElement class]];
    [[[self.xmlChildMock stub] andReturn:@[xmlGrandchildMock]] children];
    [(CXMLNode*)[[xmlGrandchildMock stub] andReturnValue:OCMOCK_VALUE((CXMLNodeKind){CXMLElementKind})] kind];
    
    
    NSURL* iconURL =  [[NSBundle bundleForClass:[self class]] URLForResource:@"icon21" withExtension:@"png"];
    [(CXMLNode*)[[xmlGrandchildMock stub] andReturn:@"Invalid URL"] stringValue];
    
    [self clearCacheObjectForKey:[iconURL absoluteString]];
    
    SimpleKMLOverlay* overlay = [[SimpleKMLOverlay alloc] initWithXMLNode:self.xmlNodeMock sourceURL:[NSURL URLWithString:@"Dummy"] error:&error];
    
    
    assertThat(overlay, nilValue());
    
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Improperly formed KML (invalid Icon URL specified in Overlay)"
                                                         forKey:NSLocalizedFailureReasonErrorKey];
    
    NSError* checkError = [NSError errorWithDomain:SimpleKMLErrorDomain code:SimpleKMLParseError userInfo:userInfo];
    
    assertThat(checkError, equalTo(error));
    
}

- (void)testIconNotInArchive
{
    NSError* error;
    [(CXMLNode*)[[self.xmlChildMock stub] andReturn:@"Icon"] name];
    OCMockObject* xmlGrandchildMock = [OCMockObject mockForClass:[CXMLElement class]];
    [[[self.xmlChildMock stub] andReturn:@[xmlGrandchildMock]] children];
    [(CXMLNode*)[[xmlGrandchildMock stub] andReturnValue:OCMOCK_VALUE((CXMLNodeKind){CXMLElementKind})] kind];
    
    
    NSURL* docURL =  [[NSBundle bundleForClass:[self class]] URLForResource:@"IconStyle" withExtension:@"kmz"];
    NSURL* iconURLinArchive =  [NSURL URLWithString:@"files/icon21.png"];

    
    [(CXMLNode*)[[xmlGrandchildMock stub] andReturn:[iconURLinArchive path]] stringValue];
    
    [self clearCacheObjectForKey:[iconURLinArchive path]];
    
    SimpleKMLOverlay* overlay = [[SimpleKMLOverlay alloc] initWithXMLNode:self.xmlNodeMock sourceURL:docURL error:&error];
    
    
    assertThat(overlay, nilValue());
    
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Improperly formed KML (invalid Icon URL specified in Overlay)"
                                                         forKey:NSLocalizedFailureReasonErrorKey];
    
    NSError* checkError = [NSError errorWithDomain:SimpleKMLErrorDomain code:SimpleKMLParseError userInfo:userInfo];
    
    assertThat(checkError, equalTo(error));
}


- (void)testIconWithInvalideImage
{
    NSError* error;
    [(CXMLNode*)[[self.xmlChildMock stub] andReturn:@"Icon"] name];
    OCMockObject* xmlGrandchildMock = [OCMockObject mockForClass:[CXMLElement class]];
    [[[self.xmlChildMock stub] andReturn:@[xmlGrandchildMock]] children];
    [(CXMLNode*)[[xmlGrandchildMock stub] andReturnValue:OCMOCK_VALUE((CXMLNodeKind){CXMLElementKind})] kind];
    
    
    NSURL* iconURL =  [[NSBundle bundleForClass:[self class]] URLForResource:@"invalid_image" withExtension:@"png"];
    [(CXMLNode*)[[xmlGrandchildMock stub] andReturn:[iconURL absoluteString]] stringValue];
    
    [self clearCacheObjectForKey:[iconURL absoluteString]];
    
    SimpleKMLOverlay* overlay = [[SimpleKMLOverlay alloc] initWithXMLNode:self.xmlNodeMock sourceURL:[NSURL URLWithString:@"Dummy"] error:&error];
    
    
    assertThat(overlay, nilValue());

    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Improperly formed KML (unable to retrieve Icon specified for Overlay)"
                                                         forKey:NSLocalizedFailureReasonErrorKey];
    
    NSError* checkError = [NSError errorWithDomain:SimpleKMLErrorDomain code:SimpleKMLParseError userInfo:userInfo];
    
    assertThat(checkError, equalTo(error));
    
    
}



@end
