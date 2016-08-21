//
//  MapViewController.swift
//  FoodTracker
//
//  Created by Diego Alejandro Orellana Lopez on 8/12/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import RealmSwift


class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var MapaVista: MKMapView!
    
    
    let locationManager = CLLocationManager()
    var currentLocation = CLLocationCoordinate2D()
    var zoomRect = MKMapRectNull
    var realm: Realm?
    
    
    override func viewDidLoad() {
          super.viewDidLoad()
         realm = try! Realm()
                MapaVista.delegate = self
        print("vista de la cargada del mapa")
        
        loadDB()
        
    }

    override func viewWillAppear(animated: Bool) {
        //let anotationsRemove = MapaVista.annotations.filter{ $0 !== MapaVista.userLocation }
     //   MapaVista.removeAnnotations( anotationsRemove )
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.MapaVista.showsUserLocation = true
        
        zoomRect = MKMapRectNull
    
        
        
     //   for mealObject in MealDB.Meals {     }
        
    }
    /*
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        currentLocation = CLLocationCoordinate2D(latitude: -17.373349440495932, longitude: -66.15387632479246)
        let mylocationRec = MKMapRectMake(currentLocation.latitude, currentLocation.longitude, 0, 0)
        var anotacion = MKPointAnnotation()
        anotacion.coordinate = currentLocation
        
        MapaVista.addAnnotation(anotacion)
        
        
    }*/
    
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("metodo location manager \(locations[0])")
        let coordinate = locations[0].coordinate
        let latiDelta: CLLocationDegrees = 0.1
        let longDelta: CLLocationDegrees = 0.1
        
        // let span: MKCoordinateSpan = MKCoordinateSpanMake(latiDelta, longDelta)
      let spame = MKCoordinateSpan(latitudeDelta:latiDelta, longitudeDelta: longDelta)
       //     let region: MKCoordinateRegion = MKCoordinateRegionMake(locations[0].coordinate, span)
        let region1 = MKCoordinateRegion(center: coordinate, span: spame)
        
        MapaVista.setRegion(region1, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "\(coordinate.latitude), \(coordinate.longitude)"
        
         let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        annotation.subtitle = dateFormatter.stringFromDate(NSDate())
        
        MapaVista.addAnnotation(annotation)
    }
    

    
    
    
    
    
    func loadDB(){    
        
        for me in (realm?.objects(MealDB.self))! {
            let img = UIImage(data: me.photo!)
            let meal = Meal(name: me.name, photo: img, rating: me.rating, longitud: me.longitud, latitud: me.latitud)
          
            print(" es tes melas  \(meal?.name)! , \(meal?.latitud)!")
            
            currentLocation = CLLocationCoordinate2D(latitude: (meal?.latitud)!, longitude: (meal?.longitud)!)
          let myLocationPointrect = MKMapRectMake(currentLocation.latitude, currentLocation.longitude, 0, 0)
            var anotation = MKPointAnnotation()
            anotation.coordinate = currentLocation
            anotation.title = meal?.name
            zoomRect = myLocationPointrect
            
            MapaVista.addAnnotation(anotation)
            

            
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
