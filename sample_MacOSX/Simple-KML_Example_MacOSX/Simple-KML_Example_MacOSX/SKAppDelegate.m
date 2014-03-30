//
//  SKAppDelegate.m
//  Simple-KML_Example_MacOSX
//
//  Created by Markus on 15.10.12.
//  Copyright (c) 2012 jemm. All rights reserved.
//

#import "SKAppDelegate.h"
#import <Simple-KML/SimpleKMLFeature.h>
#import <Simple-KML/SimpleKMLContainer.h>
#import <Simple-KML/SimpleKMLDocument.h>
#import <Simple-KML/SimpleKMLFeature.h>
#import <Simple-KML/SimpleKMLPlacemark.h>
#import <Simple-KML/SimpleKMLPoint.h>
#import <Simple-KML/SimpleKMLPolygon.h>
#import <Simple-KML/SimpleKMLLinearRing.h>


@implementation SKAppDelegate

@synthesize mapView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self.mapView setShowsUserLocation: YES];
    [self.mapView setDelegate:self];
    
    
    coreLocationPins = [NSMutableArray array];
    

}


- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    // Insert code here to initialize your application
    // grab the example KML file (which we know will have no errors, but you should ordinarily check)
    //
    SimpleKML *kml = [SimpleKML KMLWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"example" ofType:@"kml"] error:NULL];
    
    // look for a document feature in it per the KML spec
    //
    if (kml.feature && [kml.feature isKindOfClass:[SimpleKMLDocument class]])
    {
        // see if the document has features of its own
        //
        for (SimpleKMLFeature *feature in ((SimpleKMLContainer *)kml.feature).features)
        {
            // see if we have any placemark features with a point
            //
            if ([feature isKindOfClass:[SimpleKMLPlacemark class]] && ((SimpleKMLPlacemark *)feature).point)
            {
                SimpleKMLPoint *point = ((SimpleKMLPlacemark *)feature).point;
                
                // create a normal point annotation for it
                //
                MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
                
                annotation.coordinate = point.coordinate;
                annotation.title      = feature.name;
                
                [self.mapView addAnnotation:annotation];
            }
            
            // otherwise, see if we have any placemark features with a polygon
            //
            else if ([feature isKindOfClass:[SimpleKMLPlacemark class]] && ((SimpleKMLPlacemark *)feature).polygon)
            {
                SimpleKMLPolygon *polygon = (SimpleKMLPolygon *)((SimpleKMLPlacemark *)feature).polygon;
                
                SimpleKMLLinearRing *outerRing = polygon.outerBoundary;
                
                CLLocationCoordinate2D points[[outerRing.coordinates count]];
                NSUInteger i = 0;
                
                for (CLLocation *coordinate in outerRing.coordinates)
                {
                    points[i++] = coordinate.coordinate;
                }
                // create a polygon annotation for it
                //
                MKPolygon *overlayPolygon = [MKPolygon polygonWithCoordinates:points count:[outerRing.coordinates count]];
                
                [self.mapView addOverlay:overlayPolygon];
                
                // zoom the map to the polygon bounds
                //
                [self.mapView setVisibleMapRect:overlayPolygon.boundingMapRect animated:NO];

            }
        }
    }

}

#if 1
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    // we get here in order to draw any polygon
    //
    MKPolygonRenderer *polygonView = [[MKPolygonRenderer alloc] initWithPolygon:(MKPolygon *)overlay];
    
    // use some sensible defaults - normally, you'd probably look for LineStyle & PolyStyle in the KML
    //
    polygonView.fillColor   = [NSColor colorWithSRGBRed:0.0 green:0.0 blue:1.0 alpha:0.25];
    polygonView.strokeColor = [NSColor colorWithSRGBRed:1.0 green:0.0 blue:0.0 alpha:0.75];
    
    polygonView.lineWidth = 2.0;
    
    return polygonView;
}
#endif


//#pragma mark MKReverseGeocoderDelegate
//
//- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
//{
//    //NSLog(@"found placemark: %@", placemark);
//}
//
//- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
//{
//    //NSLog(@"MKReverseGeocoder didFailWithError: %@", error);
//}
//
//#pragma mark MKGeocoderDelegate
//
//- (void)geocoder:(MKGeocoder *)geocoder didFindCoordinate:(CLLocationCoordinate2D)coordinate
//{
//    //NSLog(@"MKGeocoder found (%f, %f) for %@", coordinate.latitude, coordinate.longitude, geocoder.address);
//}
//
//- (void)geocoder:(MKGeocoder *)geocoder didFailWithError:(NSError *)error
//{
//    //NSLog(@"MKGeocoder didFailWithError: %@", error);
//}

#pragma mark MapView Delegate

// Responding to Map Position Changes

- (void)mapView:(MKMapView *)aMapView regionWillChangeAnimated:(BOOL)animated
{
    NSLog(@"mapView: %@ regionWillChangeAnimated: %d", aMapView, animated);
}

- (void)mapView:(MKMapView *)aMapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"mapView: %@ regionDidChangeAnimated: %d", aMapView, animated);
}

//Loading the Map Data
- (void)mapViewWillStartLoadingMap:(MKMapView *)aMapView
{
    //NSLog(@"mapViewWillStartLoadingMap: %@", aMapView);
}



- (void)mapViewDidFailLoadingMap:(MKMapView *)aMapView withError:(NSError *)error
{
    //NSLog(@"mapViewDidFailLoadingMap: %@ withError: %@", aMapView, error);
}

// Tracking the User Location
- (void)mapViewWillStartLocatingUser:(MKMapView *)aMapView
{
    //NSLog(@"mapViewWillStartLocatingUser: %@", aMapView);
}

- (void)mapViewDidStopLocatingUser:(MKMapView *)aMapView
{
    //NSLog(@"mapViewDidStopLocatingUser: %@", aMapView);
}

- (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //NSLog(@"mapView: %@ didUpdateUserLocation: %@", aMapView, userLocation);
}

- (void)mapView:(MKMapView *)aMapView didFailToLocateUserWithError:(NSError *)error
{
    // NSLog(@"mapView: %@ didFailToLocateUserWithError: %@", aMapView, error);
}

// Managing Annotation Views


- (MKAnnotationView *)mapView:(MKMapView *)aMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    //NSLog(@"mapView: %@ viewForAnnotation: %@", aMapView, annotation);
    //MKAnnotationView *view = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"blah"] autorelease];
    MKPinAnnotationView *view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"blah"];
    view.draggable = YES;
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"MarkerTest" ofType:@"png"];
    //NSURL *url = [NSURL fileURLWithPath:path];
    //view.imageUrl = [url absoluteString];
    return view;
}

- (void)mapView:(MKMapView *)aMapView didAddAnnotationViews:(NSArray *)views
{
    //NSLog(@"mapView: %@ didAddAnnotationViews: %@", aMapView, views);
}
/*
 - (void)mapView:(MKMapView *)aMapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
 {
 NSLog(@"mapView: %@ annotationView: %@ calloutAccessoryControlTapped: %@", aMapView, view, control);
 }
 */

// Dragging an Annotation View
/*
 - (void)mapView:(MKMapView *)aMapView annotationView:(MKAnnotationView *)annotationView
 didChangeDragState:(MKAnnotationViewDragState)newState
 fromOldState:(MKAnnotationViewDragState)oldState
 {
 NSLog(@"mapView: %@ annotationView: %@ didChangeDragState: %d fromOldState: %d", aMapView, annotationView, newState, oldState);
 }
 */


// Selecting Annotation Views

- (void)mapView:(MKMapView *)aMapView didSelectAnnotationView:(MKAnnotationView *)view
{
    //NSLog(@"mapView: %@ didSelectAnnotationView: %@", aMapView, view);
}

- (void)mapView:(MKMapView *)aMapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    //NSLog(@"mapView: %@ didDeselectAnnotationView: %@", aMapView, view);
}


// Managing Overlay Views
#if 0
- (MKOverlayView *)mapView:(MKMapView *)aMapView viewForOverlay:(id <MKOverlay>)overlay
{
    //NSLog(@"mapView: %@ viewForOverlay: %@", aMapView, overlay);
    MKCircleView *circleView = [[MKCircleView alloc] initWithCircle:overlay];
    return circleView;
    //    MKPolylineView *polylineView = [[[MKPolylineView alloc] initWithPolyline:overlay] autorelease];
    //    return polylineView;
    MKPolygonView *polygonView = [[MKPolygonView alloc] initWithPolygon:overlay];
    return polygonView;
}
#endif

- (void)mapView:(MKMapView *)aMapView didAddOverlayViews:(NSArray *)overlayViews
{
    //NSLog(@"mapView: %@ didAddOverlayViews: %@", aMapView, overlayViews);
}

- (void)mapView:(MKMapView *)aMapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
    //NSLog(@"mapView: %@ annotationView: %@ didChangeDragState:%d fromOldState:%d", aMapView, annotationView, newState, oldState);
    
    if (newState ==  MKAnnotationViewDragStateEnding || newState == MKAnnotationViewDragStateNone)
    {
        // create a new circle view
        MKPointAnnotation *pinAnnotation = annotationView.annotation;
        for (NSMutableDictionary *pin in coreLocationPins)
        {
            if ([[pin objectForKey:@"pin"] isEqual: pinAnnotation])
            {
                // found the pin.
                MKCircle *circle = [pin objectForKey:@"circle"];
                CLLocationDistance pinCircleRadius = circle.radius;
                [aMapView removeOverlay:circle];
                
                circle = [MKCircle circleWithCenterCoordinate:pinAnnotation.coordinate radius:pinCircleRadius];
                [pin setObject:circle forKey:@"circle"];
                [aMapView addOverlay:circle];
            }
        }
    }
    else {
        // find old circle view and remove it
        MKPointAnnotation *pinAnnotation = annotationView.annotation;
        for (NSMutableDictionary *pin in coreLocationPins)
        {
            if ([[pin objectForKey:@"pin"] isEqual: pinAnnotation])
            {
                // found the pin.
                MKCircle *circle = [pin objectForKey:@"circle"];
                [aMapView removeOverlay:circle];
            }
        }
    }
    
    
    //MKPointAnnotation *annotation = annotationView.annotation;
    //NSLog(@"annotation = %@", annotation);
    
}

// MacMapKit additions
- (void)mapView:(MKMapView *)aMapView userDidClickAndHoldAtCoordinate:(CLLocationCoordinate2D)coordinate;
{
    //NSLog(@"mapView: %@ userDidClickAndHoldAtCoordinate: (%f, %f)", aMapView, coordinate.latitude, coordinate.longitude);
    MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
    pin.coordinate = coordinate;
    pin.title = @"Hi.";
    [mapView addAnnotation:pin];
}

- (NSArray *)mapView:(MKMapView *)mapView contextMenuItemsForAnnotationView:(MKAnnotationView *)view
{
    NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:@"Delete It" action:@selector(delete:) keyEquivalent:@""];
    return [NSArray arrayWithObject:item];
}


@end
