//
//  SimpleKMLColor.h
//  Simple-KML-Lib
//
//  Created by Markus on 03.10.12.
//  Copyright (c) 2012 jemm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


@interface SimpleKMLColor : NSObject<NSCopying>
{
@private
    CGColorRef cgColor;
}


@property (nonatomic, readonly, assign) CGColorRef cgColor;


/// @name Factory Methods
/// @{

+(SimpleKMLColor*) colorWithHexRGBString:(NSString *)colorString;
+(SimpleKMLColor*) colorWithCGColor:(CGColorRef)newCGColor;
+(SimpleKMLColor*) colorWithComponentRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+(SimpleKMLColor*) colorWithGenericGray:(CGFloat)gray;

+(SimpleKMLColor*) clearColor;
+(SimpleKMLColor*) whiteColor;
+(SimpleKMLColor*) lightGrayColor;
+(SimpleKMLColor*) grayColor;
+(SimpleKMLColor*) darkGrayColor;
+(SimpleKMLColor*) blackColor;
+(SimpleKMLColor*) redColor;
+(SimpleKMLColor*) greenColor;
+(SimpleKMLColor*) blueColor;
+(SimpleKMLColor*) cyanColor;
+(SimpleKMLColor*) yellowColor;
+(SimpleKMLColor*) magentaColor;
+(SimpleKMLColor*) orangeColor;
+(SimpleKMLColor*) purpleColor;
+(SimpleKMLColor*) brownColor;

/// @}


/// @name Initialization
/// @{
-(id)initWithCGColor:(CGColorRef)cgColor;
-(id)initWithComponentRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
/// @}


@end
