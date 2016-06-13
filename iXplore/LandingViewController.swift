//
//  LandingViewController.swift
//  iXplore
//
//  Created by Ingrid Polk on 6/9/16.
//  Copyright © 2016 KristinPolk. All rights reserved.
//

import UIKit
import MapKit

class LandingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    var placeList:[Place] = []
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLoad() {
        self.placeList = Place.placeList()
        super.viewDidLoad()
        setupMapView()
        setupTableView()
        tableView.registerNib(UINib(nibName : "SpotTableViewCell", bundle : nil), forCellReuseIdentifier: "SpotTableViewCell")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setupMapView() {
        mapView.mapType = .Hybrid
        mapView.showsBuildings = true
        mapView.addAnnotations(self.placeList) //as! [MKAnnotation]
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.placeList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SpotTableViewCell", forIndexPath: indexPath) as! SpotTableViewCell
        let spot = placeList[indexPath.row]
        cell.label?.text = spot.title!
        cell.logo.imageFromUrl(placeList[indexPath.row].imageURL!)
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if placeList[indexPath.row].ratable {
            return 88
        } else {
            return 44
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let spot = placeList[indexPath.row]
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let mapCenterAfterMove = CLLocationCoordinate2D(latitude: self.placeList[indexPath.row].coordinate.latitude, longitude: self.placeList[indexPath.row].coordinate.longitude)
        mapView.selectAnnotation(spot as! MKAnnotation, animated: true)
        
    }


}
