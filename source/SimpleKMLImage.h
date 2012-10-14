//
//  SimpleKMLImage.h
//  Simple-KML-Lib
//
//  Created by Markus on 01.10.12.
//  Copyright (c) 2012 jemm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface SimpleKMLImage : NSObject
{
@private
    CGImageRef image;
}

@property (nonatomic, readwrite, assign) CGImageRef image;

/// @name Factory Methods
/// @{
+(SimpleKMLImage *)imageWithCGImage:(CGImageRef)anImage scale:(CGFloat)newScale;
+(SimpleKMLImage *)imageWithCGImage:(CGImageRef)anImage;

///	@}

/// @name Initialization
/// @{
-(id)initWithCGImage:(CGImageRef)anImage scale:(CGFloat)newScale;
-(id)initWithCGImage:(CGImageRef)anImage;

///	@}


@end
