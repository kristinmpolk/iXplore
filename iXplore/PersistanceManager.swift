//
//  PersistanceManager.swift
//  FastNet
//
//  Created by Julian Hulme on 2016/02/21.
//  Copyright © 2016 ArcadeSoftware. All rights reserved.
//

import Foundation
//
//
//class Place: NSObject, NSCoding {
//    
//    var firstName:String?
//    
//    
//    var email:String?
//    
//    required init(firstName:String?, email:String?) {
//        self.firstName = firstName
//        self.email = email
//        
//    }
//    
//    // MARK: - NSCoding
//    func encodeWithCoder(aCoder: NSCoder) {
//        aCoder.encodeObject(self.firstName, forKey: "firstName")
//        aCoder.encodeObject(self.email, forKey: "email")
//        
//        
//    }
//    
//    required convenience init?(coder aDecoder: NSCoder) {
//        
//        let firstName = aDecoder.decodeObjectForKey("firstName") as? String
//        let email = aDecoder.decodeObjectForKey("email") as? String
//        
//        self.init(firstName:firstName, email:email)
//        
//    }
//}



class PersistenceManager {
    
    //Gets you the writing document directory path
    class func documentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDirectory = paths[0] as String
        return documentDirectory
    }
    
    class func loadObject(filename:String) -> NSObject? {
        let file = documentsDirectory().stringByAppendingPathComponent(filename)
        let result = NSKeyedUnarchiver.unarchiveObjectWithFile(file)
        return result as? NSObject
    }
    
    class func saveObject(objectToSave: NSObject, fileName: String) {
        let file = documentsDirectory().stringByAppendingPathComponent(fileName)
        NSKeyedArchiver.archiveRootObject(objectToSave, toFile: file)
    }
    
    class func saveNSArray(arrayToSave: NSArray, fileName:String) {
        let file = documentsDirectory().stringByAppendingPathComponent(fileName)
        NSKeyedArchiver.archiveRootObject(arrayToSave, toFile: file)
    }
    
    class func loadNSArray(fileName:String) -> NSArray? {
        let file = documentsDirectory().stringByAppendingPathComponent(fileName)
        let result = NSKeyedUnarchiver.unarchiveObjectWithFile(file)
        return result as? NSArray
    }
}