//
//  DiscoveryViewController.swift
//  homeKitLock02
//
//  Created by Thomas Houghton on 14/08/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import HomeKit

class DiscoveryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HMAccessoryBrowserDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let homeManager = HMHomeManager() // This is required for pretty much all home kit enable view controllers.
    let browser = HMAccessoryBrowser() // This is the accessory browser which enables you to search for accessories.
    
    var accessories = [HMAccessory]()
    var selectedHomeIndex = 0 // This is so the view controller can know which home it should be looking at.
    
    override func viewDidLoad() { //
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        browser.delegate = self
        
        // Start the discovery process.
        browser.startSearchingForNewAccessories() // This starts the accessory searching process.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // This method is required for the table view and this decides how many rows are in the table view.
        return accessories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // This method is required for the table view, this decides what is inside each table view cell.
            let cell = UITableViewCell()
            let accessory = accessories[indexPath.row] as HMAccessory
            cell.textLabel?.text = accessory.name
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let accessory = accessories[indexPath.row] as HMAccessory
        print("Pairing \(accessory.name)")
        // browser.stopSearchingForNewAccessories() // Stops searching for new accessories as soon as somebody finds an accessory they want.
        
        homeManager.homes[selectedHomeIndex].addAccessory(accessory) { (error) in // This adds the accessory to the current home being view in the MyAccessoriesViewController.
            if error != nil {
                print("We couldn't assign accessory \(error)")
            }else{
                
            }
        }
    }
    
    func accessoryBrowser(_ browser: HMAccessoryBrowser, didFindNewAccessory accessory: HMAccessory) {
        accessories.append(accessory) // When the accessory browser finds a new accessory it adds it to the accessories array.
        tableView.reloadData() // When the accessory browser finds a new accessory the table view will then need to be refreshed in order for the table to show the new discovered accessory.
    }
    
    func accessoryBrowser(_ browser: HMAccessoryBrowser, didRemoveNewAccessory accessory: HMAccessory) { // This function is then called whenever an accessory is removed.
        var index = 0 // This is required so you can then count which index you are at in the accessories array.
        for item in accessories {
            if item.name == accessory.name { // This if statement is activated when the accessory which is removed is equal to item.
                accessories.remove(at: index) // This removed a
                break;
            }
            index = index + 1
        }
        tableView.reloadData() // Once this process is finished, the table will reload data so that is displays the changes.
    }
    
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
