//
//  SKAppDelegate.h
//  Simple-KML_Example_MacOSX
//
//  Created by Markus on 15.10.12.
//  Copyright (c) 2012 jemm. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <MapKit/MapKit.h>

@interface SKAppDelegate : NSObject <NSApplicationDelegate,MKMapViewDelegate>
{
        NSMutableArray *coreLocationPins;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet MKMapView *mapView;

@end
