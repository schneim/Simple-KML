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
///	@}

/// @name Initialization
/// @{

///	@}


- (NSData*) dataFromImage;


@end
