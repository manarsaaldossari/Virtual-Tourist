//
//  PhotoAlbumViewController.swift
//  VirtualTourist
//
//  Created by manar Aldossari on 07/06/1440 AH.
//  Copyright © 1440 MacBook Pro. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class PhotoAlbumViewController: UIViewController ,NSFetchedResultsControllerDelegate ,UICollectionViewDataSource {
    var dataController : DataController!
    var fetchedResultsController : NSFetchedResultsController<Photo>!
    var pin : Pin!
    @IBOutlet weak var mapView: MKMapView!
    //MARK:- Life Cycle
    override func viewDidLoad() {
         APICall.getPhotosId(latitude: pin.latitude, longitude: pin.longitude)
        super.viewDidLoad()
        addPin()
        fetchedResultsControllerSetUp()
    }
    func addPin(){
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D (latitude: pin.latitude, longitude: pin.longitude)
        self.mapView.setCenter(annotation.coordinate, animated: true)
        self.mapView.addAnnotation(annotation)
        
    }
    
    func fetchedResultsControllerSetUp(){
        let fetchRequest : NSFetchRequest<Photo> = Photo.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "image", ascending: true)]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest , managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil , cacheName: "photos")
        fetchedResultsController.delegate = self
        do{
            try fetchedResultsController.performFetch()
        }catch{
            fatalError("could not perform fetch ,\(error.localizedDescription)")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = fetchedResultsController.object(at: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! PhotoCell
       // cell.imageView?.image = nil
        cell.setimage()
        return cell
        
    }
    
    


}
