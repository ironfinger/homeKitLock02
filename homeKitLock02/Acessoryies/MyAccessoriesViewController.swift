//
//  ViewController.swift
//  homeKitLock02
//
//  Created by Thomas Houghton on 14/08/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import HomeKit

class MyAccessoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HMAccessoryBrowserDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let homeManager = HMHomeManager()
    
    var accessories = [HMAccessory]()
    var amountOfAccessories = 0
    
    // MARK: View setup.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var totalAccessories = 0
        if homeManager.primaryHome?.accessories.count != nil {
            totalAccessories = homeManager.primaryHome!.accessories.count
        }
        return totalAccessories
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let accessory = homeManager.primaryHome!.accessories[indexPath.row]
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
        print(homeManager.primaryHome!.accessories[indexPath.row])
        self.performSegue(withIdentifier: "ServicesVCSegue", sender: indexPath.row)
    }
    
    // MARK: Actions
    
    
    
    // MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ServicesVCSegue" {
            let nextVC = segue.destination as? ServicesViewController
            nextVC?.selectedAccessoryIndex = sender as! Int
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

