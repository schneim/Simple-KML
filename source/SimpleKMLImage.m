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
 *	@brief The CGImageRef to wrap around.
 **/
@synthesize image;




#pragma mark -
#pragma mark Initialization

/** @brief Initializes a SimpleKMLImage instance with the provided CGImageRef.
 *
 *	This is the designated initializer.
 *
 *  @param anImage The image to wrap.
 *	@param newScale The image scale. Must be greater than zero.
 *  @return A SimpleKMLImage instance initialized with the provided CGImageRef.
 **/
-(id)initWithCGImage:(CGImageRef)anImage scale:(CGFloat)newScale
{
    NSParameterAssert(newScale > 0.0);
    
    if ( (self = [super init]) ) {
        CGImageRetain(anImage);
        image                 = anImage;
    }
    return self;
}

/** @brief Initializes a SimpleKMLImage instance with the provided CGImageRef and scale 1.0.
 *  @param anImage The image to wrap.
 *  @return A SimpleKMLImage instance initialized with the provided CGImageRef.
 **/
-(id)initWithCGImage:(CGImageRef)anImage
{
    return [self initWithCGImage:anImage scale:1.0];
}

-(id)init
{
    return [self initWithCGImage:NULL];
}




#pragma mark -
#pragma mark NSCopying

-(id)copyWithZone:(NSZone *)zone
{
    SimpleKMLImage *copy = [[[self class] allocWithZone:zone] init];
    
    copy->image                 = CGImageCreateCopy(self.image);
    
    return copy;
}

#pragma mark -
#pragma mark Factory Methods

/** @brief Creates and returns a new SimpleKMLImage instance initialized with the provided CGImageRef.
 *  @param anImage The image to wrap.
 *	@param newScale The image scale.
 *  @return A new SimpleKMLImage instance initialized with the provided CGImageRef.
 **/
+(SimpleKMLImage *)imageWithCGImage:(CGImageRef)anImage scale:(CGFloat)newScale
{
    return [[self alloc] initWithCGImage:anImage scale:newScale];
}

/** @brief Creates and returns a new SimpleKMLImage instance initialized with the provided CGImageRef and scale 1.0.
 *  @param anImage The image to wrap.
 *  @return A new SimpleKMLImage instance initialized with the provided CGImageRef.
 **/
+(SimpleKMLImage *)imageWithCGImage:(CGImageRef)anImage
{
    return [[self alloc] initWithCGImage:anImage];
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
        
        BOOL equalImages=YES;
        
        CGImageRef selfCGImage  = self.image;
        CGImageRef otherCGImage = otherImage.image;
        
        CGColorSpaceRef selfColorSpace  = CGImageGetColorSpace(selfCGImage);
        CGColorSpaceRef otherColorSpace = CGImageGetColorSpace(otherCGImage);
        
        if ( equalImages ) {
            equalImages = ( CGImageGetWidth(selfCGImage) == CGImageGetWidth(otherCGImage) );
        }
        
        if ( equalImages ) {
            equalImages = ( CGImageGetHeight(selfCGImage) == CGImageGetHeight(otherCGImage) );
        }
        
        if ( equalImages ) {
            equalImages = ( CGImageGetBitsPerComponent(selfCGImage) == CGImageGetBitsPerComponent(otherCGImage) );
        }
        
        if ( equalImages ) {
            equalImages = ( CGImageGetBitsPerPixel(selfCGImage) == CGImageGetBitsPerPixel(otherCGImage) );
        }
        
        if ( equalImages ) {
            equalImages = ( CGImageGetBytesPerRow(selfCGImage) == CGImageGetBytesPerRow(otherCGImage) );
        }
        
        if ( equalImages ) {
            equalImages = ( CGImageGetBitmapInfo(selfCGImage) == CGImageGetBitmapInfo(otherCGImage) );
        }
        
        if ( equalImages ) {
            equalImages = ( CGImageGetShouldInterpolate(selfCGImage) == CGImageGetShouldInterpolate(otherCGImage) );
        }
        
        if ( equalImages ) {
            equalImages = ( CGImageGetRenderingIntent(selfCGImage) == CGImageGetRenderingIntent(otherCGImage) );
        }
        
        // decode array
        if ( equalImages ) {
            const CGFloat *selfDecodeArray  = CGImageGetDecode(selfCGImage);
            const CGFloat *otherDecodeArray = CGImageGetDecode(otherCGImage);
            
            if ( selfDecodeArray && otherDecodeArray ) {
                size_t numberOfComponentsSelf  = CGColorSpaceGetNumberOfComponents(selfColorSpace) * 2;
                size_t numberOfComponentsOther = CGColorSpaceGetNumberOfComponents(otherColorSpace) * 2;
                
                if ( numberOfComponentsSelf == numberOfComponentsOther ) {
                    for ( size_t i = 0; i < numberOfComponentsSelf; i++ ) {
                        if ( selfDecodeArray[i] != otherDecodeArray[i] ) {
                            equalImages = NO;
                            break;
                        }
                    }
                }
                else {
                    equalImages = NO;
                }
            }
            else if ( (selfDecodeArray && !otherDecodeArray) || (!selfDecodeArray && otherDecodeArray) ) {
                equalImages = NO;
            }
        }
        
        // color space
        if ( equalImages ) {
            equalImages = ( CGColorSpaceGetModel(selfColorSpace) == CGColorSpaceGetModel(otherColorSpace) ) &&
            ( CGColorSpaceGetNumberOfComponents(selfColorSpace) == CGColorSpaceGetNumberOfComponents(otherColorSpace) );
        }
        
        // data provider
        if ( equalImages ) {
            CGDataProviderRef selfProvider  = CGImageGetDataProvider(selfCGImage);
            CFDataRef selfProviderData      = CGDataProviderCopyData(selfProvider);
            CGDataProviderRef otherProvider = CGImageGetDataProvider(otherCGImage);
            CFDataRef otherProviderData     = CGDataProviderCopyData(otherProvider);
            
            if ( selfProviderData && otherProviderData ) {
                equalImages = [(__bridge NSData *) selfProviderData isEqualToData:(__bridge NSData *)otherProviderData];
            }
            else {
                equalImages = (selfProviderData == otherProviderData);
            }
            
            if ( selfProviderData ) {
                CFRelease(selfProviderData);
            }
            if ( otherProviderData ) {
                CFRelease(otherProviderData);
            }
        }
        
        return equalImages;
    }
    else {
        return NO;
    }
}

-(NSUInteger)hash
{
    // Equal objects must hash the same.
    CGImageRef selfCGImage = self.image;
    
    return ( CGImageGetWidth(selfCGImage) * CGImageGetHeight(selfCGImage) ) +
    CGImageGetBitsPerComponent(selfCGImage) +
    CGImageGetBitsPerPixel(selfCGImage) +
    CGImageGetBytesPerRow(selfCGImage) +
    CGImageGetBitmapInfo(selfCGImage) +
    CGImageGetShouldInterpolate(selfCGImage);
}




@end
