//
//  CharacteristicsViewController.swift
//  homeKitLock02
//
//  Created by Thomas Houghton on 15/08/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import HomeKit

class CharacteristicsViewController: UIViewController {

    @IBOutlet weak var serviceNameLbl: UILabel!
    @IBOutlet weak var serviceStateLbl: UILabel!
    @IBOutlet weak var serviceStateSegmentControl: UISegmentedControl!
    
    let homeManager = HMHomeManager()
    
    var selectedAccessoryIndex = 0
    var selectedServiceIndex = 0
    var selectedAccessory = HMAccessory()
    var selectedService = HMService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for item in homeManager.primaryHome!.accessories {
            if item.name == homeManager.primaryHome!.accessories[selectedAccessoryIndex].name {
                selectedAccessory = item
                for it in selectedAccessory.services {
                    if it.name == selectedAccessory.services[selectedServiceIndex].name {
                        selectedService = it
                    }
                }
            }
        }
        serviceNameLbl.text = selectedService.name
    }
    
    @IBAction func serviceStateChanged(_ sender: Any) {
        switch serviceStateSegmentControl.selectedSegmentIndex
        {
        case 0:
            
                for item in selectedService.characteristics {
                    print("Iteration")
                    let characteristic = item as HMCharacteristic
                    characteristic.writeValue(0, completionHandler: { (error) in
                        if error != nil {
                            print("Couldn't set a target value \(error)")
                        }else{
                            print("We set a value!")
                        }
                    })
                }

            
            
        case 1:
            for item in selectedService.characteristics {
                print("Iteration")
                let characteristic = item as HMCharacteristic
                characteristic.writeValue(1, completionHandler: { (error) in
                    if error != nil {
                        print("Couldn't set a target value \(error)")
                    }else{
                        print("We set a value!")
                    }
                })
            }
        default:
            break
        }
    }
    
    // MARK: Updating
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
