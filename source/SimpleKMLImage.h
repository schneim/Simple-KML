//
//  SimpleKMLImage.h
//  Simple-KML-Lib
//
//  Created by Markus on 01.10.12.
//  Copyright (c) 2012 jemm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleKMLImage : NSObject
{
@private
    UIImage* image;
}

@property (readonly) UIImage* image;

/// @name Factory Methods
/// @{
+ (SimpleKMLImage *)imageWithData:(NSData *)data;
+ (SimpleKMLImage *)imageWithContentsOfFile:(NSString *)path;
- (SimpleKMLImage *)imageWithScale:(CGFloat)scale;

///	@}

/// @name Initialization
/// @{
- (id)initWithContentsOfFile:(NSString *)path;
- (id)initWithData:(NSData *)data;
- (id)initWithImage:(SimpleKMLImage *)image scale:(CGFloat)scale;
///	@}


- (NSData*) dataFromImage;



@end
