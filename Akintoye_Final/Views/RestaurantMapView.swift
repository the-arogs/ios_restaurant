//
//  RestaurantMapView.swift
//  Akintoye_Final
//
//  Created by Arogs on 3/12/24.
//

import SwiftUI
import CoreLocation
import MapKit


struct RestaurantMapView: View {
    @EnvironmentObject var coreDBHelper : CoreDBHelper
    @EnvironmentObject var locationHelper: LocationHelper
    var restaurant : RestaurantMO
    let selectedRestaurantIndex : Int
    
    @State private var address : String = ""
    
    var body: some View {
        VStack{
            if self.locationHelper.currentLocation != nil && self.address != "" {
                MyMap(location: self.locationHelper.currentLocation!, restaurant: restaurant, address: self.address)

            }
            else {
                Text("Obtaining location...")
            }
            
        }.onAppear(){
            self.locationHelper.checkPermission()
            doReverseGeocoding()
            self.locationHelper.currentLocation = CLLocation(
                latitude: coreDBHelper.restaurantList[selectedRestaurantIndex].latitude as Double,
              longitude: coreDBHelper.restaurantList[selectedRestaurantIndex].longitude as Double)
        }
    }
    
    
    
    private func doReverseGeocoding(){
        print("Performing reversegeocoding ")
        
        let inputLocation = CLLocation(latitude: coreDBHelper.restaurantList[selectedRestaurantIndex].latitude, longitude: coreDBHelper.restaurantList[selectedRestaurantIndex].longitude)
        
        self.locationHelper.doReverseGeocoding(location: inputLocation, completionHandler: {(matchingAddress, error) in
            
            if (error == nil && matchingAddress != nil){
                self.address = matchingAddress!
                print(matchingAddress!)
            }else{
                self.address = "Unable to obtain address for given coordinates"
            }
            
        })
        
    }
}


struct MyMap : UIViewRepresentable{
    
    typealias UIViewType = MKMapView
    var restaurant : RestaurantMO
    var address : String
    private var location: CLLocation


    @EnvironmentObject var locationHelper : LocationHelper
    let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    
    init(location: CLLocation, restaurant: RestaurantMO, address: String){
        self.location = location
        self.restaurant = restaurant
        self.address = address
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let sourceCoordinates : CLLocationCoordinate2D
        let region : MKCoordinateRegion
        
        
        if self.locationHelper.currentLocation != nil {
          sourceCoordinates = self.locationHelper.currentLocation!.coordinate
        } else {
          sourceCoordinates = CLLocationCoordinate2D(latitude: 43.64732, longitude: -79.38279)
        }
        region = MKCoordinateRegion(center: sourceCoordinates, span: span)
        
        let map = MKMapView(frame: .infinite)
        map.mapType = MKMapType.standard
        map.isZoomEnabled = true
        map.isUserInteractionEnabled = true
        map.showsUserLocation = true
        
        map.setRegion(region, animated: true)
        
        return map
        
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        let sourceCoordinates : CLLocationCoordinate2D
        let region : MKCoordinateRegion
        
        if self.locationHelper.currentLocation != nil {

          if uiView.annotations.count > 0 {

            uiView.removeAnnotation(uiView.annotations.last!)

          }

          sourceCoordinates = self.locationHelper.currentLocation!.coordinate

          region = MKCoordinateRegion(center: sourceCoordinates, span: span)

          let mapAnnotation = MKPointAnnotation()
          mapAnnotation.coordinate = sourceCoordinates
            mapAnnotation.title = "\(restaurant.restaurant!)\n\(address)"

          uiView.setRegion(region, animated: true)
          uiView.addAnnotation(mapAnnotation)

        }
        
    }
    
}

//#Preview {
//    RestaurantMapView()
//}
