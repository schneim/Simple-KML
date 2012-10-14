//
//  SimpleKMLOverlay.h
//  Simple-KML-Lib
//
//  Created by Markus on 07.10.12.
//  Copyright (c) 2012 jemm. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

#import "SimpleKMLObjectTest.h"

@interface SimpleKMLOverlayTest : SimpleKMLObjectTest

@property id                    xmlChildMock;
@property NSString*             colorString;

- (void)clearCacheObjectForKey:(NSString *)key;

@end

