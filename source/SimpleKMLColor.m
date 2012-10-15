//
//  SimpleKMLColor.m
//  Simple-KML-Lib
//
//  Created by Markus on 03.10.12.
//  Copyright (c) 2012 jemm. All rights reserved.
//

#import "SimpleKMLColor.h"

@implementation SimpleKMLColor

/**     @property cgColor
 *      @brief The CGColorRef to wrap around.
 **/
@synthesize cgColor;

#pragma mark -
#pragma mark Factory Methods

/** @brief Returns a shared instance of SimpleKMLColor initialized with a fully transparent color.
 *
 *  @return A shared SimpleKMLColor object initialized with a fully transparent color.
 **/
+(SimpleKMLColor *)clearColor
{
    static SimpleKMLColor *color = nil;
    
    if ( nil == color ) {
        CGColorRef clear  = NULL;
        CGFloat values[4] = { 0.0, 0.0, 0.0, 0.0 };
        CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
        clear = CGColorCreate(colorspace, values);
        color = [[SimpleKMLColor alloc] initWithCGColor:clear];
        CGColorRelease(clear);
        CGColorSpaceRelease(colorspace);
    }
    return color;
}

/** @brief Returns a shared instance of SimpleKMLColor initialized with a fully opaque white color.
 *
 *  @return A shared SimpleKMLColor object initialized with a fully opaque white color.
 **/
+(SimpleKMLColor *)whiteColor
{
    static SimpleKMLColor *color = nil;
    
    if ( nil == color ) {
        color = [self colorWithGenericGray:1.0];
    }
    return color;
}

/** @brief Returns a shared instance of SimpleKMLColor initialized with a fully opaque 2/3 gray color.
 *
 *  @return A shared SimpleKMLColor object initialized with a fully opaque 2/3 gray color.
 **/
+(SimpleKMLColor *)lightGrayColor
{
    static SimpleKMLColor *color = nil;
    
    if ( nil == color ) {
        color = [self colorWithGenericGray:2.0 / 3.0];
    }
    return color;
}

/** @brief Returns a shared instance of SimpleKMLColor initialized with a fully opaque 50% gray color.
 *
 *  @return A shared SimpleKMLColor object initialized with a fully opaque 50% gray color.
 **/
+(SimpleKMLColor *)grayColor
{
    static SimpleKMLColor *color = nil;
    
    if ( nil == color ) {
        color = [self colorWithGenericGray:0.5];
    }
    return color;
}

/** @brief Returns a shared instance of SimpleKMLColor initialized with a fully opaque 1/3 gray color.
 *
 *  @return A shared SimpleKMLColor object initialized with a fully opaque 1/3 gray color.
 **/
+(SimpleKMLColor *)darkGrayColor
{
    static SimpleKMLColor *color = nil;
    
    if ( nil == color ) {
        color = [self colorWithGenericGray:1.0 / 3.0];
    }
    return color;
}

/** @brief Returns a shared instance of SimpleKMLColor initialized with a fully opaque black color.
 *
 *  @return A shared SimpleKMLColor object initialized with a fully opaque black color.
 **/
+(SimpleKMLColor *)blackColor
{
    static SimpleKMLColor *color = nil;
    
    if ( nil == color ) {
        color = [self colorWithGenericGray:0.0];
    }
    return color;
}

/** @brief Returns a shared instance of SimpleKMLColor initialized with a fully opaque red color.
 *
 *  @return A shared SimpleKMLColor object initialized with a fully opaque red color.
 **/
+(SimpleKMLColor *)redColor
{
    static SimpleKMLColor *color = nil;
    
    if ( nil == color ) {
        color = [[SimpleKMLColor alloc] initWithComponentRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    }
    return color;
}

/** @brief Returns a shared instance of SimpleKMLColor initialized with a fully opaque green color.
 *
 *  @return A shared SimpleKMLColor object initialized with a fully opaque green color.
 **/
+(SimpleKMLColor *)greenColor
{
    static SimpleKMLColor *color = nil;
    
    if ( nil == color ) {
        color = [[SimpleKMLColor alloc] initWithComponentRed:0.0 green:1.0 blue:0.0 alpha:1.0];
    }
    return color;
}

/** @brief Returns a shared instance of SimpleKMLColor initialized with a fully opaque blue color.
 *
 *  @return A shared SimpleKMLColor object initialized with a fully opaque blue color.
 **/
+(SimpleKMLColor *)blueColor
{
    static SimpleKMLColor *color = nil;
    
    if ( nil == color ) {
        color = [[SimpleKMLColor alloc] initWithComponentRed:0.0 green:0.0 blue:1.0 alpha:1.0];
    }
    return color;
}

/** @brief Returns a shared instance of SimpleKMLColor initialized with a fully opaque cyan color.
 *
 *  @return A shared SimpleKMLColor object initialized with a fully opaque cyan color.
 **/
+(SimpleKMLColor *)cyanColor
{
    static SimpleKMLColor *color = nil;
    
    if ( nil == color ) {
        color = [[SimpleKMLColor alloc] initWithComponentRed:0.0 green:1.0 blue:1.0 alpha:1.0];
    }
    return color;
}

/** @brief Returns a shared instance of SimpleKMLColor initialized with a fully opaque yellow color.
 *
 *  @return A shared SimpleKMLColor object initialized with a fully opaque yellow color.
 **/
+(SimpleKMLColor *)yellowColor
{
    static SimpleKMLColor *color = nil;
    
    if ( nil == color ) {
        color = [[SimpleKMLColor alloc] initWithComponentRed:1.0 green:1.0 blue:0.0 alpha:1.0];
    }
    return color;
}

/** @brief Returns a shared instance of SimpleKMLColor initialized with a fully opaque magenta color.
 *
 *  @return A shared SimpleKMLColor object initialized with a fully opaque magenta color.
 **/
+(SimpleKMLColor *)magentaColor
{
    static SimpleKMLColor *color = nil;
    
    if ( nil == color ) {
        color = [[SimpleKMLColor alloc] initWithComponentRed:1.0 green:0.0 blue:1.0 alpha:1.0];
    }
    return color;
}

/** @brief Returns a shared instance of SimpleKMLColor initialized with a fully opaque orange color.
 *
 *  @return A shared SimpleKMLColor object initialized with a fully opaque orange color.
 **/
+(SimpleKMLColor *)orangeColor
{
    static SimpleKMLColor *color = nil;
    
    if ( nil == color ) {
        color = [[SimpleKMLColor alloc] initWithComponentRed:1.0 green:0.5 blue:0.0 alpha:1.0];
    }
    return color;
}

/** @brief Returns a shared instance of SimpleKMLColor initialized with a fully opaque purple color.
 *
 *  @return A shared SimpleKMLColor object initialized with a fully opaque purple color.
 **/
+(SimpleKMLColor *)purpleColor
{
    static SimpleKMLColor *color = nil;
    
    if ( nil == color ) {
        color = [[SimpleKMLColor alloc] initWithComponentRed:0.5 green:0.0 blue:0.5 alpha:1.0];
    }
    return color;
}

/** @brief Returns a shared instance of SimpleKMLColor initialized with a fully opaque brown color.
 *
 *  @return A shared SimpleKMLColor object initialized with a fully opaque brown color.
 **/
+(SimpleKMLColor *)brownColor
{
    static SimpleKMLColor *color = nil;
    
    if ( nil == color ) {
        color = [[SimpleKMLColor alloc] initWithComponentRed:0.6 green:0.4 blue:0.2 alpha:1.0];
    }
    return color;
}

/** @brief Creates and returns a new CPTColor instance initialized with the provided gray level.
 *  @param gray The gray level (0 ≤ gray ≤ 1).
 *  @return A new CPTColor instance initialized with the provided gray level.
 **/
+(SimpleKMLColor *)colorWithGenericGray:(CGFloat)gray
{
    CGFloat values[4]   = { gray, gray, gray, 1.0 };
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorRef = CGColorCreate(colorspace, values);
    SimpleKMLColor *color     = [[SimpleKMLColor alloc] initWithCGColor:colorRef];
    CGColorRelease(colorRef);
    CGColorSpaceRelease(colorspace);
    return color;
}

+ (SimpleKMLColor *)colorWithHexRGBString:(NSString *)colorString;
{
    // color string should be eight or nine characters (RGBA in hex, with or without '#' prefix)
    //
    if ([colorString length] < 8 || [colorString length] > 9)
        return nil;
    
    colorString = [colorString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    NSMutableArray *parts = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < 8; i = i + 2)
    {
        NSString *part = [colorString substringWithRange:NSMakeRange(i, 2)];
        
        unsigned wholeValue;
        
        [[NSScanner scannerWithString:part] scanHexInt:&wholeValue];
        
        if (wholeValue > 255)
            return nil;
        
        [parts addObject:[NSNumber numberWithDouble:((CGFloat)wholeValue / (CGFloat)255)]];
    }
    
    SimpleKMLColor *color = [SimpleKMLColor colorWithComponentRed:[[parts objectAtIndex:3] doubleValue]
                                                            green:[[parts objectAtIndex:2] doubleValue]
                                                             blue:[[parts objectAtIndex:1] doubleValue]
                                                            alpha:[[parts objectAtIndex:0] doubleValue]];
    
    return color;
}


/** @brief Creates and returns a new SimpleKMLColor instance initialized with the provided CGColorRef.
 *  @param newCGColor The color to wrap.
 *  @return A new SimpleKMLColor instance initialized with the provided CGColorRef.
 **/
+(SimpleKMLColor *)colorWithCGColor:(CGColorRef)newCGColor
{
    return [[SimpleKMLColor alloc] initWithCGColor:newCGColor];
}

/** @brief Creates and returns a new SimpleKMLColor instance initialized with the provided RGBA color components.
 *  @param red The red component (0 ≤ red ≤ 1).
 *  @param green The green component (0 ≤ green ≤ 1).
 *  @param blue The blue component (0 ≤ blue ≤ 1).
 *  @param alpha The alpha component (0 ≤ alpha ≤ 1).
 *  @return A new SimpleKMLColor instance initialized with the provided RGBA color components.
 **/
+(SimpleKMLColor *)colorWithComponentRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    return [[SimpleKMLColor alloc] initWithComponentRed:red green:green blue:blue alpha:alpha] ;
}


#pragma mark -
#pragma mark Initialize/Deallocate

/** @brief Initializes a newly allocated SimpleKMLColor object with the provided CGColorRef.
 *
 *      @param newCGColor The color to wrap.
 *  @return The initialized SimpleKMLColor object.
 **/
-(id)initWithCGColor:(CGColorRef)newCGColor
{
    if ( (self = [super init]) ) {
        CGColorRetain(newCGColor);
        cgColor = newCGColor;
    }
    return self;
}

/** @brief Initializes a newly allocated SimpleKMLColor object with the provided RGBA color components.
 *
 *  @param red The red component (0 ≤ red ≤ 1).
 *  @param green The green component (0 ≤ green ≤ 1).
 *  @param blue The blue component (0 ≤ blue ≤ 1).
 *  @param alpha The alpha component (0 ≤ alpha ≤ 1).
 *  @return The initialized SimpleKMLColor object.
 **/
-(id)initWithComponentRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    CGFloat colorComponents[4];
    
    colorComponents[0] = red;
    colorComponents[1] = green;
    colorComponents[2] = blue;
    colorComponents[3] = alpha;
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGColorRef color = CGColorCreate(colorspace, colorComponents);
    self = [self initWithCGColor:color];
    CGColorRelease(color);
    CGColorSpaceRelease(colorspace);
    return self;
}


#pragma mark -
#pragma mark NSCopying methods

-(id)copyWithZone:(NSZone *)zone
{
    CGColorRef cgColorCopy = NULL;
    
    if ( cgColor ) {
        cgColorCopy = CGColorCreateCopy(cgColor);
    }
    SimpleKMLColor *colorCopy = [[[self class] allocWithZone:zone] initWithCGColor:cgColorCopy];
    CGColorRelease(cgColorCopy);
    return colorCopy;
}

#pragma mark -
#pragma mark Color comparison

-(BOOL)isEqual:(id)object
{
    if ( self == object ) {
        return YES;
    }
    else if ( [object isKindOfClass:[self class]] ) {
        return CGColorEqualToColor(self.cgColor, ( (SimpleKMLColor *)object ).cgColor);
    }
    else {
        return NO;
    }
}

-(NSUInteger)hash
{
    // Equal objects must hash the same.
    CGFloat theHash    = 0.0;
    CGFloat multiplier = 256.0;
    
    CGColorRef theColor            = self.cgColor;
    size_t numberOfComponents      = CGColorGetNumberOfComponents(theColor);
    const CGFloat *colorComponents = CGColorGetComponents(theColor);
    
    for ( NSUInteger i = 0; i < numberOfComponents; i++ ) {
        theHash    += multiplier * colorComponents[i];
        multiplier *= 256.0;
    }
    
    return (NSUInteger)theHash;
}


@end
