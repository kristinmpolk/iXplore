//
//  ViewController.swift
//  iXplore
//
//  Created by Ingrid Polk on 6/8/16.
//  Copyright © 2016 KristinPolk. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var spotList = []

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidLoad() {
        self.spotList = Spot.spotList()
        super.viewDidLoad()
        setupMapView()
        setupTableView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setupMapView() {
        mapView.mapType = .Hybrid
        mapView.showsBuildings = true
        mapView.addAnnotations(self.spotList as! [MKAnnotation])
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.spotList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        let spot = spotList[indexPath.row]
        cell.textLabel?.text = spot.title
        return cell
        
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let spot = spotList[indexPath.row]
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let mapCenterAfterMove = CLLocationCoordinate2D(latitude: self.spotList[indexPath.row].coordinate.latitude, longitude: self.spotList[indexPath.row].coordinate.longitude)
        mapView.selectAnnotation(spot as! MKAnnotation, animated: true)

    }

    

}

