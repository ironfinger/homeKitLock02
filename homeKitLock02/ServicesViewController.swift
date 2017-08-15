//
//  ServicesViewController.swift
//  homeKitLock02
//
//  Created by Thomas Houghton on 15/08/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import HomeKit

class ServicesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HMAccessoryDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationItem!
    
    let homeManager = HMHomeManager()
    
    var selectedAccessory = HMAccessory()
    var services = [HMService]()
    var selectedAccessoryIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for item in homeManager.primaryHome!.accessories {
            if item.name == homeManager.primaryHome!.accessories[selectedAccessoryIndex].name{
                selectedAccessory = item
                for i in item.services  {
                    print("Iteration \(i.name)")
                    services.append(i)
                }
            }
        }
        navBar.title = selectedAccessory.name
        tableView.reloadData()
    }
    
    // MARK: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let service = services[indexPath.row]
        
        cell.textLabel?.text = service.name
        cell.detailTextLabel?.text = "details"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let service = services[indexPath.row]
        service.characteristics[1].writeValue(1, completionHandler: { (error) in
            if error != nil {
                print(error)
            }else{
                print("We changed a value!")
            }
        })
    }
    
    func accessory(_ accessory: HMAccessory, service: HMService, didUpdateValueFor characteristic: HMCharacteristic) {
        print("Change")
    }
}
