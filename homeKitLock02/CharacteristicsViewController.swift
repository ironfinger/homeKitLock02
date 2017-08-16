//
//  CharacteristicsViewController.swift
//  homeKitLock02
//
//  Created by Thomas Houghton on 15/08/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import HomeKit

class CharacteristicsViewController: UIViewController, HMAccessoryDelegate {

    @IBOutlet weak var serviceNameLbl: UILabel!
    @IBOutlet weak var serviceStateLbl: UILabel!
    @IBOutlet weak var serviceStateSegmentControl: UISegmentedControl!
    
    let homeManager = HMHomeManager()
    
    var selectedAccessoryIndex = 0
    var selectedServiceIndex = 0
    var selectedAccessory = HMAccessory()
    var selectedService = HMService()
    var lockedState = "" // This is used to see the actual state of the lock.
    
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
        selectedAccessory.delegate = self
        setServiceState()
    }
    
    func setServiceState() {
        for item in selectedService.characteristics {
            let characteristic = item as HMCharacteristic
            if characteristic.characteristicType == HMCharacteristicTypeCurrentLockMechanismState {
                characteristic.readValue(completionHandler: { (error) in
                    let theValue = String(describing: characteristic.value!)
                    if theValue == "0" {
                        self.serviceStateLbl.text = "Locked"
                        self.serviceStateSegmentControl.selectedSegmentIndex = 1
                    }else{
                        self.serviceStateLbl.text = "Un-Locked"
                        self.serviceStateSegmentControl.selectedSegmentIndex = 0
                    }
                })
            }
        }
    }
    
    @IBAction func serviceStateChanged(_ sender: Any) {
        switch serviceStateSegmentControl.selectedSegmentIndex
        {
        case 0:
                for item in selectedService.characteristics { // To cycle through all the characteristics and find the specific characteristic that we want.
                    print("Iteration")
                    let characteristic = item as HMCharacteristic
                    if characteristic.characteristicType == HMCharacteristicTypeTargetLockMechanismState { // To check to see if the characteristic we found is a target lock.
                        characteristic.writeValue(0, completionHandler: { (error) in
                            if error != nil{
                                print("Couldn't set the target lock value to 0 \(String(describing: error))")
                            }else{
                                print("We set the target value to 0")
                            }
                        })
                    }
                }
        case 1:
            for item in selectedService.characteristics { // To cycle through all the characteristics and find the specific characteristic that we want.😀
                print("Iteration")
                let characteristic = item as HMCharacteristic
                if characteristic.characteristicType == HMCharacteristicTypeTargetLockMechanismState { // To check to see if the characteric we found is a target lock.
                    characteristic.writeValue(1, completionHandler: { (error) in
                        if error != nil {
                            print("Couldn't set the target lock value to 1 \(String(describing: error))")
                        }else{
                            print("We set the target value to 1")
                        }
                    })
                }
            }
        default:
            break
        }
    }
    
    @IBAction func unPairButtonTapped(_ sender: Any) {
        homeManager.primaryHome!.removeAccessory(selectedAccessory) { (error) in
            if error != nil {
                print("Couldn't remove accessory \(String(describing: error))")
            }else{
                print("Successfully removed accessory")
            }
        }
        performSegue(withIdentifier: "backToMyAccessoriesSegue", sender: nil) // Sends the user back to the my accessories view controller.
    }
    
    // MARK: Update
    
    func accessory(_ accessory: HMAccessory, service: HMService, didUpdateValueFor characteristic: HMCharacteristic) {
        if characteristic.characteristicType == HMCharacteristicTypeCurrentLockMechanismState {
            characteristic.readValue(completionHandler: { (error) in
                let theValue = String(describing: characteristic.value!)
                print("the value \(theValue)")
                if theValue == "0"{
                    print("The value is 0")
                    self.serviceStateLbl.text = "Locked"
                }else if theValue == "1"{
                    print("The value is 1")
                    self.serviceStateLbl.text = "Un-Locked"
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

