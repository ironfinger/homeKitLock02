//
//  ViewController.swift
//  homeKitLock02
//
//  Created by Thomas Houghton on 14/08/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import HomeKit

class MyAccessoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HMAccessoryBrowserDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let homeManager = HMHomeManager() // This is pretty much required by every single HomeKit enabled view controller.
    
    var accessories = [HMAccessory]()
    var amountOfAccessories = 0
    var selectedHome = 0
    
    // MARK: View setup.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData() // The table is refreshed each time the view controller appears so that when an accessory is added to that home, it will then show that on the table view.
    }
    
    // MARK: Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var totalAccessories = 0
        if homeManager.primaryHome?.accessories.count != nil {
            totalAccessories = homeManager.homes[selectedHome].accessories.count
        }
        return totalAccessories
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let accessory = homeManager.homes[selectedHome].accessories[indexPath.row]
        let reachable = accessory.isReachable
        //let uuid:String = String(accessory.uniqueIdentifier)
        
        if reachable == true {
            cell.textLabel?.text = "\(accessory.name): Accessory is reachable"
        }else{
            cell.textLabel?.text = "\(accessory.name): Accessory is not reachable"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(homeManager.homes[selectedHome].accessories[indexPath.row])
        self.performSegue(withIdentifier: "ServicesVCSegue", sender: indexPath.row)
    }
    
    // MARK: Picker View
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let homes = homeManager.homes
        return homes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let home = homeManager.homes[row]
        return home.name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected")
        selectedHome = row
        tableView.reloadData()
    }
    
    // MARK: Actions
    
    
    
    // MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ServicesVCSegue" {
            let nextVC = segue.destination as? ServicesViewController
            nextVC?.selectedAccessoryIndex = sender as! Int
            nextVC?.selectedHome = selectedHome
        }else if segue.identifier == "addAccessorySegue" {
            let nextVC = segue.destination as? DiscoveryViewController
            nextVC?.selectedHomeIndex = selectedHome
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
