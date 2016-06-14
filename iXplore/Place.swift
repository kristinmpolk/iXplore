//
//  Place.swift
//  iXplore
//
//  Created by Ingrid Polk on 6/9/16.
//  Copyright © 2016 KristinPolk. All rights reserved.
//

import Foundation
import MapKit

class Place:NSObject, MKAnnotation  {
    
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var title: String?
    var imageURL:String?
    var ratable: Bool = false
    var description_: String?
    var date: NSDate?
    var favorite: Bool = false
    
    class func placeList() -> [Place] {
        
        let place1 = Place ()
        place1.title = "Workshop 17"
        place1.imageURL = "https://avatars1.githubusercontent.com/u/7220596?v=3&s=200"
        place1.ratable = true
        place1.favorite = true
        place1.coordinate = CLLocationCoordinate2D(latitude: -33.906764,longitude: 18.4164983)
        place1.date = NSDate()
        
        let place2 = Place ()
        place2.title = "Truth Coffee"
        place2.imageURL = "https://robohash.org/123.png"
        place2.ratable = true
        place2.coordinate = CLLocationCoordinate2D(latitude: -33.9281976,longitude: 18.4227045)
        place2.date = NSDate()
        
        let place3 = Place ()
        place3.title = "Chop Chop Coffee"
        place3.imageURL = "http://cdn3.ixperience.co.za/assets/icons/interview-step-2-801f63110f89e85e38f27d39f5864a1399f256fe0684844caea2a18c4b6fbd33.svg"
        place3.ratable = true
        place3.coordinate = CLLocationCoordinate2D(latitude: -33.9271879,longitude: 18.4327055)
        place3.date = NSDate()
        
        let place4 = Place ()
        place4.title = "Four"
        place4.coordinate = CLLocationCoordinate2D(latitude: -33.9251879,longitude: 18.4327055)
        place4.date = NSDate()
        
        let place5 = Place ()
        place5.title = "Five"
        place5.coordinate = CLLocationCoordinate2D(latitude: -33.9261879,longitude: 18.4327055)
        place5.date = NSDate()
        
        let place6 = Place ()
        place6.title = "six"
        place6.coordinate = CLLocationCoordinate2D(latitude: -33.9291879,longitude: 18.4327055)
        place6.date = NSDate()
        
        let place7 = Place ()
        place7.title = "seven"
        place7.coordinate = CLLocationCoordinate2D(latitude: -33.9171879,longitude: 18.4327055)
        place7.date = NSDate()
        
        let place8 = Place ()
        place8.title = "eight"
        place8.coordinate = CLLocationCoordinate2D(latitude: -33.9181879,longitude: 18.4327055)
        place8.date = NSDate()
        
        let place9 = Place ()
        place9.title = "nine"
        place9.coordinate = CLLocationCoordinate2D(latitude: -33.9071879,longitude: 18.4327055)
        place9.date = NSDate()
        
        let place10 = Place ()
        place10.title = "ten"
        place10.coordinate = CLLocationCoordinate2D(latitude: -33.9091879,longitude: 18.4327055)
        place10.date = NSDate()
        
        return [place1,place2,place3, place4,place5,place6,place7,place8,place9,place10]
    }
    
//    func formatDate(date:NSDate) {
//        let date = NSDateComponents().date
//        print(date)
//    }
}

extension UIImageView   {
    
    
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if let imageData = data as NSData? {
                    self.image = UIImage(data: imageData)
                }
            }
        }
    }
    
}
