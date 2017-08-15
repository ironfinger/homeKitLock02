//
//  ServicesViewController.swift
//  homeKitLock02
//
//  Created by Thomas Houghton on 15/08/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import HomeKit

class ServicesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationItem!
    
    let homeManager = HMHomeManager()
    
    var selectedAccessory = HMAccessory()
    var servicesLALALA = [HMService]()
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
                    servicesLALALA.append(i)
                }
            }
        }
        navBar.title = selectedAccessory.name
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //for item in homeManager.primaryHome!.accessories {
         //   print("Accessory")
        //}
        print("This accessory (\(selectedAccessory.name)) has \(selectedAccessory.services.count) services")
        print("number of rows in section \(servicesLALALA.count)")
        return servicesLALALA.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let service = servicesLALALA[indexPath.row]
        cell.textLabel?.text = service.name //selectedAccessory.name
        return cell
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
