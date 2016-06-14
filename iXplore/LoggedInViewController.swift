//
//  LandingViewController.swift
//  iXplore
//
//  Created by Ingrid Polk on 6/9/16.
//  Copyright © 2016 KristinPolk. All rights reserved.
//

import UIKit
import MapKit

class LandingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    var placeList:[Place] = []
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLoad() {
        self.tableView.registerClass(PlaceTableViewCell.self, forCellReuseIdentifier: "PlaceTableViewCell")
        self.placeList = Place.placeList()
        super.viewDidLoad()
        setupMapView()
        setupTableView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setupMapView() {
        mapView.mapType = .Hybrid
        mapView.showsBuildings = true
        mapView.addAnnotations(self.placeList)
        self.mapView.delegate = self
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.placeList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let spot = placeList[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("PlaceTableViewCell", forIndexPath: indexPath) as! PlaceTableViewCell
        cell.placeNameLabel.text = spot.title!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let dateString = dateFormatter.stringFromDate(spot.date!)
        cell.dateLabel.text = String(dateString)
        if spot.imageURL != nil {
            cell.logoImageView.imageFromUrl(placeList[indexPath.row].imageURL!)
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
        let spot = placeList[indexPath.row]
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let mapCenterAfterMove = CLLocationCoordinate2D(latitude: self.placeList[indexPath.row].coordinate.latitude, longitude: self.placeList[indexPath.row].coordinate.longitude)
        mapView.selectAnnotation(spot as! MKAnnotation, animated: true)
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegion(center: mapCenterAfterMove, span: span)
        mapView.setRegion(region, animated: true)
        print(placeList[indexPath.row].favorite)
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .Normal, title: "Delete") { action, index in
            self.mapView.removeAnnotation(self.placeList[indexPath.row] as! MKAnnotation)
            self.placeList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            //self.setupMapView()
        }
        deleteAction.backgroundColor = UIColor.redColor()
        
        let favoriteAction = UITableViewRowAction(style: .Normal, title: "Favorite") { action, index in
            self.mapView.removeAnnotation(self.placeList[indexPath.row])
            self.mapView.addAnnotation(self.placeList[indexPath.row])
            self.placeList[indexPath.row].favorite = true
        }
        favoriteAction.backgroundColor = UIColor.orangeColor()
        
        
        return [deleteAction, favoriteAction]
    }
    



}
