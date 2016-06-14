//
//  PlaceController.swift
//  iXplore
//
//  Created by Ingrid Polk on 6/14/16.
//  Copyright © 2016 KristinPolk. All rights reserved.
//

import Foundation
import MapKit



class PlaceController {
    
    class var sharedInstance: PlaceController {
        struct Static {
            static var instance:PlaceController?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token)    {
            Static.instance = PlaceController()
        }
        return Static.instance!
    }
    
    var placeList: [Place] = []
    
    func addPlace(lat: Double?, lon:Double?, title:String?, imageURL:String?, description_:String?, date:NSDate?, favorite:Bool) {
        var dateDefault = NSDate()
        let place = Place(newLat: lat,newLon: lon, newTitle: title, newImageURL: nil, newDescription: description_, newDate: dateDefault, newFavorite: false)
        placeList.append(place)
        PersistenceManager.saveObject(placeList, fileName: "/iXplore.placeList")
    }
    
    private func readPlacesFromMemory() {
        var currentPlaces = PersistenceManager.loadObject("/iXplore.placeList") as? [Place]
        for place in currentPlaces! {
            self.placeList.append(place)
        }
        
    }
    
    func getPlaces() -> [Place] {
        var result = Place.placeList()
        if placeList.isEmpty {
            self.readPlacesFromMemory()
            if placeList.isEmpty {
                return result
            }
            return self.placeList
        }
        return placeList
    }
    
}