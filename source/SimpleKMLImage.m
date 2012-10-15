//
//  SimpleKMLImage.m
//  Simple-KML-Lib
//
//  Created by Markus on 01.10.12.
//  Copyright (c) 2012 jemm. All rights reserved.
//

#import "SimpleKMLImage.h"

#if __MAC_OS_X_VERSION_MIN_REQUIRED
@interface NSImage (SimpleKML)
- (NSImage *)imageWithScale:(CGFloat)scale;

@end


@implementation NSImage  (SimpleKML)

#pragma mark Density Adjustments

- (NSImage *)imageWithScale:(CGFloat)scale
{
    NSParameterAssert(scale > 0);
    
    NSInteger width = 0;
    NSInteger height = 0;
    
    for (NSImageRep *representation in self.representations) {
        if (representation.pixelsWide * representation.pixelsHigh > width * height) {
            width = representation.pixelsWide;
            height = representation.pixelsHigh;
        }
    }
    
    NSImage *newImage = [self copy];
    newImage.size = CGSizeMake(width * scale, height * scale);
    
    return newImage;
}

@end
#endif


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
#if __IPHONE_OS_VERSION_MIN_REQUIRED
        image = [UIImage imageWithData:data];
#endif
        
        
#if __MAC_OS_X_VERSION_MIN_REQUIRED
        image = [[NSImage alloc ]initWithData:data];
#endif

    }
    
    if (self.image != nil)
        return self;
    else
        return nil;
}

- (id)initWithContentsOfFile:(NSString *)path
{
    self = [super init];
    if (self) {
#if __IPHONE_OS_VERSION_MIN_REQUIRED
        image = [UIImage imageWithContentsOfFile:path];
#endif
        
        
#if __MAC_OS_X_VERSION_MIN_REQUIRED
        image = [[NSImage alloc ]initWithContentsOfFile:path];
#endif

    }
    
    if (self.image != nil)
        return self;
    else
        return nil;
}

- (id)initWithImage:(SimpleKMLImage *) sourceImage scale:(CGFloat)scale
{
    self = [super init];
    if (self) {
#if __IPHONE_OS_VERSION_MIN_REQUIRED
        image = [UIImage imageWithCGImage:sourceImage.image.CGImage scale:scale orientation:sourceImage.image.imageOrientation];
#endif
        
#if __MAC_OS_X_VERSION_MIN_REQUIRED
        image = [sourceImage.image imageWithScale:scale];
#endif

        
    }
    
    if (self.image != nil)
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
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED
    return [NSKeyedArchiver archivedDataWithRootObject:self.image];
#endif
    
#if __MAC_OS_X_VERSION_MIN_REQUIRED
    return [image TIFFRepresentation];
#endif
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
