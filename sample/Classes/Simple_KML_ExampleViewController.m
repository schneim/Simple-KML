//
//  Simple_KML_ExampleViewController.m
//  Simple KML Example
//
//  Created by Justin R. Miller on 9/22/10.
//  Copyright Development Seed 2010-2012. All rights reserved.
//

#import "Simple_KML_ExampleViewController.h"

#import <MapKit/MapKit.h>

#import "SimpleKML.h"
#import "SimpleKMLContainer.h"
#import "SimpleKMLDocument.h"
#import "SimpleKMLFeature.h"
#import "SimpleKMLPlacemark.h"
#import "SimpleKMLPoint.h"
#import "SimpleKMLPolygon.h"
#import "SimpleKMLLinearRing.h"


#define MERCATOR_OFFSET_20_ZOOM 268435456
#define MERCATOR_RADIUS_20_ZOOM 85445659.44705395

#define MERCATOR_OFFSET_10_ZOOM 134217728
#define MERCATOR_RADIUS_10_ZOOM 42722829.72352697

#define MERCATOR_OFFSET MKMapSizeWorld.width/2
#define MERCATOR_RADIUS MERCATOR_OFFSET/M_PI 



/*
 * Mercator transformation
 * accounts for the fact that the earth is not a sphere, but a spheroid
 */
#define D_R (M_PI / 180.0)
#define R_D (180.0 / M_PI)
#define R_MAJOR 6378137.0
#define R_MINOR 6356752.3142
#define RATIO (R_MINOR/R_MAJOR)
#define ECCENT (sqrt(1.0 - (RATIO * RATIO)))
#define COM (0.5 * ECCENT)

static double deg_rad (double ang) {
    return ang * D_R;
}

double merc_x (double lon) {
    return R_MAJOR * deg_rad (lon);
}

double merc_y (double lat) {
    lat = fmin (89.5, fmax (lat, -89.5));
    double phi = deg_rad(lat);
    double sinphi = sin(phi);
    double con = ECCENT * sinphi;
    con = pow((1.0 - con) / (1.0 + con), COM);
    double ts = tan(0.5 * (M_PI * 0.5 - phi)) / con;
    return 0 - R_MAJOR * log(ts);
}

static double rad_deg (double ang) {
    return ang * R_D;
}

double merc_lon (double x) {
    return rad_deg(x) / R_MAJOR;
}

double merc_lat (double y) {
    double ts = exp ( -y / R_MAJOR);
    double phi = M_PI_2 - 2 * atan(ts);
    double dphi = 1.0;
    int i;
    for (i = 0; fabs(dphi) > 0.000000001 && i < 15; i++) {
        double con = ECCENT * sin (phi);
        dphi = M_PI_2 - 2 * atan (ts * pow((1.0 - con) / (1.0 + con), COM)) - phi;
        phi += dphi;
    }
    return rad_deg (phi);
}

@implementation Simple_KML_ExampleViewController
{
    IBOutlet MKMapView *mapView;
}



- (double)longitudeToPixelSpaceX:(double)longitude
{
    return round(MERCATOR_OFFSET + MERCATOR_RADIUS * longitude * M_PI / 180.0);
}

- (double)latitudeToPixelSpaceY:(double)latitude
{
    return round(MERCATOR_OFFSET - MERCATOR_RADIUS * logf((1 + sinf(latitude * M_PI / 180.0)) / (1 - sinf(latitude * M_PI / 180.0))) / 2.0);
}

- (double)pixelSpaceXToLongitude:(double)pixelX
{
    return ((round(pixelX) - MERCATOR_OFFSET) / MERCATOR_RADIUS) * 180.0 / M_PI;
}

- (double)pixelSpaceYToLatitude:(double)pixelY
{
    return (M_PI / 2.0 - 2.0 * atan(exp((round(pixelY) - MERCATOR_OFFSET) / MERCATOR_RADIUS))) * 180.0 / M_PI;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
                
                [mapView addAnnotation:annotation];
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
                    CLLocationCoordinate2D coordinatePoint = coordinate.coordinate;
            
                 
                    double mercaturY_zoom = [self latitudeToPixelSpaceY:coordinatePoint.latitude];
                    double mercaturX_zoom = [self longitudeToPixelSpaceX:coordinatePoint.longitude];
                    MKMapPoint mapPoint = MKMapPointForCoordinate(coordinatePoint);
                    
                    MKMapSize mapWorldSize = MKMapSizeWorld;
                    MKMapRect mapWorldRect = MKMapRectWorld;
                    
                }
                // create a polygon annotation for it
                //
                MKPolygon *overlayPolygon = [MKPolygon polygonWithCoordinates:points count:[outerRing.coordinates count]];
                
                [mapView addOverlay:overlayPolygon];
                
                // zoom the map to the polygon bounds
                //
                
                 MKMapRect boundingMapRect = overlayPolygon.boundingMapRect;
             [mapView setVisibleMapRect:overlayPolygon.boundingMapRect animated:YES];
  //                 [self->mapView setRegion:MKCoordinateRegionForMapRect(boundingMapRect) animated:YES];
                MKCoordinateRegion region =  MKCoordinateRegionForMapRect(boundingMapRect);
                
                [mapView setRegion:region animated:YES];

            }
        }
    }
}

#pragma mark -

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    // we get here in order to draw any polygon
    //
    MKPolygonView *polygonView = [[MKPolygonView alloc] initWithPolygon:(MKPolygon *)overlay];
    
    // use some sensible defaults - normally, you'd probably look for LineStyle & PolyStyle in the KML
    //
    polygonView.fillColor   = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.25];
    polygonView.strokeColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.75];
    
    polygonView.lineWidth = 2.0;
    
    return polygonView;
}

@end