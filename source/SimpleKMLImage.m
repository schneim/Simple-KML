//
//  SimpleKMLImage.m
//  Simple-KML-Lib
//
//  Created by Markus on 01.10.12.
//  Copyright (c) 2012 jemm. All rights reserved.
//

#import "SimpleKMLImage.h"



@implementation SimpleKMLImage

/**	@property image
 *	@brief The UIImage to wrap around.
 **/
@synthesize image;




#pragma mark -
#pragma mark Initialization

- (id)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        image = [UIImage imageWithData:data];
    }
    
    if (image != nil)
        return self;
    else
        return nil;
}

- (id)initWithContentsOfFile:(NSString *)path
{
    self = [super init];
    if (self) {
        image = [UIImage imageWithContentsOfFile:path];
    }
    
    if (image != nil)
        return self;
    else
        return nil;
}

- (id)initWithImage:(SimpleKMLImage *) sourceImage scale:(CGFloat)scale
{
    self = [super init];
    if (self) {
        image = [UIImage imageWithCGImage:sourceImage.image.CGImage scale:scale orientation:sourceImage.image.imageOrientation];
    }
    
    if (image != nil)
        return self;
    else
        return nil;
}


+ (SimpleKMLImage *)imageWithData:(NSData *)data
{
    return [[SimpleKMLImage alloc] initWithData:data];
}

- (SimpleKMLImage *)imageWithScale:(CGFloat)scale
{
    return [[SimpleKMLImage alloc] initWithImage:self scale:scale];
}


+ (SimpleKMLImage *)imageWithContentsOfFile:(NSString *)path
{
    return [[SimpleKMLImage alloc] initWithContentsOfFile:path];
}






- (NSData*) dataFromImage
{
    return [NSKeyedArchiver archivedDataWithRootObject:self.image];
}



#pragma mark -
#pragma mark Image comparison

-(BOOL)isEqual:(id)object
{
    if ( self == object ) {
        return YES;
    }
    else if ( [object isKindOfClass:[self class]] ) {
        SimpleKMLImage *otherImage = (SimpleKMLImage *)object;
        
        BOOL equalImages= [self.image isEqual:otherImage.image];
        
         
        return equalImages;
    }
    else {
        return NO;
    }
}





@end
