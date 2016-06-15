//
//  Place.swift
//  iXplore
//
//  Created by Ingrid Polk on 6/9/16.
//  Copyright © 2016 KristinPolk. All rights reserved.
//

import Foundation
import MapKit

class Place: NSObject, NSCoding, MKAnnotation  {
    
    var latitude: Double?
    var longitude:Double?
    var coordinate: CLLocationCoordinate2D
    var title: String? = ""
    var imageURL:String?
    var description_: String? = ""
    var date: NSDate
    var favorite: Bool = false
    
    required init(newLat:Double?, newLon:Double?, newTitle:String?, newImageURL:String?, newDescription:String?, newDate:NSDate, newFavorite:Bool) {
        self.latitude = newLat
        self.longitude = newLon
        self.coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        self.title = newTitle
        self.imageURL = newImageURL
        self.description_ = newDescription
        self.date = newDate
        self.favorite = newFavorite
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.latitude as! AnyObject, forKey: "latitude")
        aCoder.encodeObject(self.longitude as! AnyObject, forKey: "longitude")
        aCoder.encodeObject(self.description_, forKey: "description_")
        aCoder.encodeObject(self.title, forKey: "title")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let latitude = aDecoder.decodeObjectForKey("latitude") as? Double
        let longitude = aDecoder.decodeObjectForKey("longitude") as? Double
        let title = aDecoder.decodeObjectForKey("title") as? String
        let description_ = aDecoder.decodeObjectForKey("description_")as? String
        self.init(newLat: latitude, newLon: longitude, newTitle: title,newImageURL: nil,newDescription: description_,newDate: NSDate(),newFavorite: false)
    }
    
    
    
    class func placeList() -> [Place] {
        
        let place1 = Place(newLat: -33.9281976,newLon: 18.4227045, newTitle: "One", newImageURL: "https://avatars1.githubusercontent.com/u/7220596?v=3&s=200", newDescription: "where we learn", newDate: NSDate(), newFavorite: true)
        
        let place2 = Place(newLat: -33.9181976,newLon: 18.4227045, newTitle: "Two", newImageURL: "https://avatars1.githubusercontent.com/u/7220596?v=3&s=200", newDescription: "where we learn", newDate: NSDate(), newFavorite: false)

        let place3 = Place(newLat: -33.9081976,newLon: 18.4227045, newTitle: "Three", newImageURL: "https://avatars1.githubusercontent.com/u/7220596?v=3&s=200", newDescription: "where we learn", newDate: NSDate(), newFavorite: false)
        
//        let place2 = Place ()
//        place2.title = "Truth Coffee"
//        place2.imageURL = "https://robohash.org/123.png"
//        place2.coordinate = CLLocationCoordinate2D(latitude: -33.9281976,longitude: 18.4227045)
//        place2.date = NSDate()
//        
//        let place3 = Place ()
//        place3.title = "Chop Chop Coffee"
//        place3.imageURL = "http://cdn3.ixperience.co.za/assets/icons/interview-step-2-801f63110f89e85e38f27d39f5864a1399f256fe0684844caea2a18c4b6fbd33.svg"
//        place3.coordinate = CLLocationCoordinate2D(latitude: -33.9271879,longitude: 18.4327055)
//        place3.date = NSDate()
//        
//        let place4 = Place ()
//        place4.title = "Four"
//        place4.coordinate = CLLocationCoordinate2D(latitude: -33.9251879,longitude: 18.4327055)
//        place4.date = NSDate()
//        
//        let place5 = Place ()
//        place5.title = "Five"
//        place5.coordinate = CLLocationCoordinate2D(latitude: -33.9261879,longitude: 18.4327055)
//        place5.date = NSDate()
//        
//        let place6 = Place ()
//        place6.title = "six"
//        place6.coordinate = CLLocationCoordinate2D(latitude: -33.9291879,longitude: 18.4327055)
//        place6.date = NSDate()
//        
//        let place7 = Place ()
//        place7.title = "seven"
//        place7.coordinate = CLLocationCoordinate2D(latitude: -33.9171879,longitude: 18.4327055)
//        place7.date = NSDate()
//        
//        let place8 = Place ()
//        place8.title = "eight"
//        place8.coordinate = CLLocationCoordinate2D(latitude: -33.9181879,longitude: 18.4327055)
//        place8.date = NSDate()
//        
//        let place9 = Place ()
//        place9.title = "nine"
//        place9.coordinate = CLLocationCoordinate2D(latitude: -33.9071879,longitude: 18.4327055)
//        place9.date = NSDate()
//        
//        let place10 = Place ()
//        place10.title = "ten"
//        place10.coordinate = CLLocationCoordinate2D(latitude: -33.9091879,longitude: 18.4327055)
//        place10.date = NSDate()
        
        return [place1,place2,place3]
    }

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
