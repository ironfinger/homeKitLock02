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
    
    var accessories = [HMAccessory]()
    var amountOfAcceessories = 0
    let homeManager = HMHomeManager()
    
    // MARK: View setup.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //  amountOfAcceessories = homeManager.primaryHome!.accessories.count
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
        cell.textLabel?.text = accessory.name
        //if reachable == true {
            //cell.detailTextLabel?.text = "Is reachable"
       // }else{
           // cell.detailTextLabel?.text = "Isn't reachable"
        //}
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(homeManager.primaryHome!.accessories[indexPath.row])
        self.performSegue(withIdentifier: "ServicesVCSegue", sender: indexPath.row)
    }
    
    // MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ServicesVCSegue" {
            //let nextVC = segue.destination as? ServicesViewController
            //nextVC?.selectedAccessoryIndex = sender as! Int
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

