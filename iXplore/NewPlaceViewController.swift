//
//  NewPlaceViewController.swift
//  iXplore
//
//  Created by Ingrid Polk on 6/14/16.
//  Copyright © 2016 KristinPolk. All rights reserved.
//

import UIKit
import MapKit

class NewPlaceViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!

    @IBOutlet weak var latitudeField: UITextField!
    @IBOutlet weak var longitudeField: UITextField!
    
    var givenTitle:String?
    var givenDescription:String?
    var givenLatitude: Double?
    var givenLongitude: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(frame: CGRectMake(10, 30, 70, 20))
        button.setTitle("Back", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: Selector("buttonTapped:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
        

        // Do any additional setup after loading the view.
    }

    func buttonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
        let loggedInvc = LoggedInViewController()
        self.presentViewController(loggedInvc, animated: true, completion: nil)
        
    }
    @IBAction func saveButtonTapped(sender: UIButton) {
        givenTitle = titleField.text!
        givenDescription = descriptionField.text!
        givenLatitude = Double(latitudeField.text!)
        givenLongitude = Double(longitudeField.text!)
        
        
//        givenCoordinates = CLLocationCoordinate2D(coordinateField.text!)
        PlaceController.sharedInstance.addPlace(givenLatitude, lon: givenLongitude, title: givenTitle, imageURL: nil, description_: givenDescription, date: NSDate(), favorite: false)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
