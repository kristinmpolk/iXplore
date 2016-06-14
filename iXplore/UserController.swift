//
//  UserController.swift
//  iXplore
//
//  Created by Ingrid Polk on 6/14/16.
//  Copyright © 2016 KristinPolk. All rights reserved.
//

import Foundation

struct User {
    var email:String?
    var password:String?
}

class UserController {
    
    class var sharedInstance: UserController {
        struct Static {
            static var instance:UserController?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token)    {
            Static.instance = UserController()
        }
        return Static.instance!
    }

    
    var users: [User] = []

    func registerUser(newEmail: String, newPassword: String) -> (failureMessage: String?, user: User?) {
        
        for user in users {
            
            if user.email == newEmail {
                
                print("email taken")
                return ("Email taken", nil)
                
            }
            
        }
        
        let user = User(email: newEmail, password: newPassword)
        
        users.append(user)
        
        print("User with email: \(newEmail) has been registered by the UserManager.")
        
        return (nil, user)
        
    }
    
    func loginUser(suppliedEmail: String, suppliedPassword: String) -> (failureMessage: String?, user: User?){
        for user in users {
            if user.email == suppliedEmail {
                if user.password == suppliedPassword {
                    print("User with email: \(suppliedEmail) has been logged in by the UserManager.")
                    return (nil, user)
                } else {
                    return ("Password incorrect", nil)
                }
            }
        }
        return ("No user with that email", nil)
    }
    
    
}