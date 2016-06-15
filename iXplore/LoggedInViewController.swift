//
//  LandingViewController.swift
//  iXplore
//
//  Created by Ingrid Polk on 6/9/16.
//  Copyright © 2016 KristinPolk. All rights reserved.
//

import UIKit
import MapKit

class LoggedInViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, MKMapViewDelegate {
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLoad() {
        self.tableView.registerClass(PlaceTableViewCell.self, forCellReuseIdentifier: "PlaceTableViewCell")
        super.viewDidLoad()
        PlaceController.sharedInstance.getPlaces()
        setupMapView()
        setupTableView()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        let rightBarButton = UIBarButtonItem(title: "+", style: .Plain, target: self, action: "plusButtonTapped:")
        self.navigationItem.rightBarButtonItem = rightBarButton
        let leftBarButton = UIBarButtonItem(title: "logout", style: .Plain, target: self, action: "logoutButtonTapped:")
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationController?.navigationBarHidden = false
        tableView.reloadData()
        setupMapView()
        
        
    }
    
    func plusButtonTapped(sender: UIBarButtonItem!) {
        let nvc = NewPlaceViewController()
        self.presentViewController(nvc, animated: true, completion: nil)
        appDelegate.locationManager!.startUpdatingLocation()
    }
    
    func logoutButtonTapped(sender: UIBarButtonItem!) {
        let lvc = LandingViewController()
        self.presentViewController(lvc, animated: true, completion: nil)
    }
    
    func setupMapView() {
        mapView.mapType = .Hybrid
        mapView.showsBuildings = true
        mapView.addAnnotations(PlaceController.sharedInstance.placeList)
        self.mapView.delegate = self
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaceController.sharedInstance.placeList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let spot = PlaceController.sharedInstance.placeList[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("PlaceTableViewCell", forIndexPath: indexPath) as! PlaceTableViewCell
        cell.placeNameLabel.text = spot.title!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let dateString:String
        dateString = dateFormatter.stringFromDate(spot.date)
        cell.dateLabel.text = String(dateString)
        cell.dateLabel.text = dateString
        if spot.imageURL != nil {
            cell.logoImageView.imageFromUrl(PlaceController.sharedInstance.placeList[indexPath.row].imageURL!)
        }
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let pin = annotation as! Place
        if !pin.favorite {
            return nil
        }
        
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView!.pinTintColor = UIColor.yellowColor()
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView

        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        appDelegate.locationManager?.startUpdatingLocation()
        let spot = PlaceController.sharedInstance.placeList[indexPath.row]
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let mapCenterAfterMove = CLLocationCoordinate2D(latitude: spot.coordinate.latitude, longitude: spot.coordinate.longitude)
        mapView.selectAnnotation(spot as! MKAnnotation, animated: true)
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegion(center: mapCenterAfterMove, span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .Normal, title: "Delete") { action, index in
            var spot = PlaceController.sharedInstance.placeList[indexPath.row]
            self.mapView.removeAnnotation(spot as! MKAnnotation)
            PlaceController.sharedInstance.placeList.removeAtIndex(indexPath.row)
            PersistenceManager.saveObject(PlaceController.sharedInstance.placeList, fileName: "/iXplore.placeList")
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            //self.setupMapView()
        }
        deleteAction.backgroundColor = UIColor.redColor()
        
        let favoriteAction = UITableViewRowAction(style: .Normal, title: "Favorite") { action, index in
            self.mapView.removeAnnotation(PlaceController.sharedInstance.placeList[indexPath.row])
            self.mapView.addAnnotation(PlaceController.sharedInstance.placeList[indexPath.row])
            PlaceController.sharedInstance.placeList[indexPath.row].favorite = true
        }
        favoriteAction.backgroundColor = UIColor.orangeColor()
        
        
        return [deleteAction, favoriteAction]
    }
    



}
