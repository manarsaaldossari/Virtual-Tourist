//
//  MapViewController.swift
//  VirtualTourist
//
//  Created by manar Aldossari on 07/06/1440 AH.
//  Copyright © 1440 MacBook Pro. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController:  UIViewController ,NSFetchedResultsControllerDelegate ,MKMapViewDelegate {
    var dataController : DataController!
    var pins:[Pin]!
    
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadFetchedPins()
    }
    
    //MARK- IBAction
    @IBAction func addPin(_ sender: UILongPressGestureRecognizer) {
        if sender.state != .began {return}
        let location = sender.location(in: self.mapView)
        let locationCoordinate = self.mapView.convert(location, toCoordinateFrom: self.mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinate
        self.mapView.addAnnotation(annotation)
        savePin(latitude: annotation.coordinate.latitude , longitude: annotation.coordinate.longitude)
    }
    
    
    func uploadFetchedPins(){
        pins = dataController.fetchPins(viewContext: dataController.viewContext)
        for pin in pins {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D (latitude: pin.latitude, longitude: pin.longitude)
            self.mapView.addAnnotation(annotation)
        }
    }
    
    func savePin(latitude:Double ,longitude:Double ){
        let pin = Pin(context: dataController.viewContext)
        pin.latitude = latitude
        pin.longitude = longitude
        pins.append(pin)
        saveViewContext()
    }
    
    func saveViewContext(){
        do{
            try dataController.viewContext.save()
        }catch{
            fatalError(" could not save viewContext : \(error.localizedDescription)")
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let coordinate = view.annotation?.coordinate
        for pin in pins {
            if pin.latitude == coordinate?.latitude && pin.longitude == coordinate?.longitude{
                let photoAlbumVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotoAlbumViewController") as! PhotoAlbumViewController
                photoAlbumVC.pin = pin
                photoAlbumVC.dataController = self.dataController
                navigationController?.pushViewController(photoAlbumVC, animated: true)
            }
        }
    }


}
