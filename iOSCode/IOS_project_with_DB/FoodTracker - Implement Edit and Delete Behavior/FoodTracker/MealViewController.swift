//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 5/23/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//  See LICENSE.txt for this sample’s licensing information.
//

import UIKit
import RealmSwift
import CoreLocation
import MapKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate{
    // MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var mapView: MKMapView!
    /*
        This value is either passed by `MealTableViewController` in `prepareForSegue(_:sender:)`
        or constructed as part of adding a new meal.
    */
    var meal: Meal?
    var longi: Double?
    var lati: Double?
    var realm : Realm?
    //LOCATION MANAGER 
    let locationManager = CLLocationManager()
    //var center =  CLLocationCoordinate2D()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        realm = try! Realm()
        print (" the path real is \(realm?.path)")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        
        // Set up views if editing an existing Meal.
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text   = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
           
            print("este es algo \(ratingControl.rating)")
        }
        // Enable the Save button only if the text field has a valid Meal name.
        checkValidMealName()
        
//CONFIGURACION DE LOCATION MANAGER
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
//METODO PARA OBTENER UNA NUEVA UBICACION 
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("metodo location manager \(locations[0])")
        let coordinate = locations[0].coordinate
        let latiDelta: CLLocationDegrees = 0.02
        let longDelta: CLLocationDegrees = 0.02
        
     // let span: MKCoordinateSpan = MKCoordinateSpanMake(latiDelta, longDelta)
        let spame = MKCoordinateSpan(latitudeDelta:latiDelta, longitudeDelta: longDelta)
   //     let region: MKCoordinateRegion = MKCoordinateRegionMake(locations[0].coordinate, span)
        let region1 = MKCoordinateRegion(center: coordinate, span: spame)
        
        mapView.setRegion(region1, animated: true)
        
        let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(coordinate.latitude), \(coordinate.longitude)"
        
      /*  let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        annotation.subtitle = dateFormatter.stringFromDate(NSDate())
       */
          mapView.addAnnotation(annotation)
        
        let longpress = UILongPressGestureRecognizer(target: self, action: "action:")
            longpress.minimumPressDuration = 1.0
        mapView.addGestureRecognizer(longpress)
        
        
    }

    func action(gestureRecognizer: UIGestureRecognizer){
        let touchPoint = gestureRecognizer.locationInView(self.mapView)
        let nuevaCoord: CLLocationCoordinate2D = mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
        let nuevaAnotacion = MKPointAnnotation()
        
        
        longi = nuevaCoord.longitude
        lati = nuevaCoord.latitude
        print("Longitud es : \(lati), Longitud es : \(longi)")
        
        nuevaAnotacion.coordinate = nuevaCoord
        nuevaAnotacion.title = "New Location"
        nuevaAnotacion.subtitle = "nuevo subtitulo"
        mapView.addAnnotation(nuevaAnotacion)

    }
    
    func  coordLongitu(long : Double) -> Double{
        //  print(" metodo cordenada longitud: \(longi!)")
        return long
    }
    func coordLatitud(latitude: Double) -> Double{
        // print(" metodo cordenada Latitud:")
        return latitude
    }
    

//******************************
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidMealName()
        navigationItem.title = textField.text
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    func checkValidMealName() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = nameTextField.text ?? ""
            let photo = photoImageView.image
            let rating = ratingControl.rating
            longi = coordLongitu(longi!)
            lati = coordLatitud(lati!)
            print("\(longi!) ,\(lati!)")
            
            // Set the meal to be passed to MealListTableViewController after the unwind segue.
            meal = Meal(name: name, photo: photo, rating: rating, longitud: longi!, latitud: lati!)
            
            
            
            let newMeal = MealDB()
            newMeal.name = (meal?.name)!
            newMeal.photo = UIImagePNGRepresentation((meal?.photo)!)
            newMeal.rating = (meal?.rating)!
            newMeal.longitud = (meal?.longitud)!
            newMeal.latitud = (meal?.latitud)!
            newMeal.id = NSUUID().UUIDString
            // save new meal
            try! self.realm?.write {
                self.realm?.add(newMeal)
            }
        }
    }
    
    // MARK: Actions
    
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }

}

