//
//  MyHomesViewController.swift
//  homeKitLock02
//
//  Created by Thomas Houghton on 17/08/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import HomeKit

class MyHomesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let homeManager = HMHomeManager()
    
    var homes = [HMHome]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        if homes.count == 0 {
            homes.removeAll()
            print("Homes removed")
        }
        for item in homeManager.homes {
            homes.append(item)
            print(item.name)
        }
        for item in homes {
            print("A home: \(item.name)")
        }
        
        tableView.reloadData()
    }
    
    // MARK: Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeManager.homes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let home = homeManager.homes[indexPath.row]
        cell.textLabel?.text = home.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("indexPath.row: \(indexPath.row)")
        print("Problem in didselectrow")
        print(homes[indexPath.row].name)
        // let selectedIndex = indexPath.row
        performSegue(withIdentifier: "homeSettingsSegue", sender: indexPath.row)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Problem in prepare for segue")
        if segue.identifier == "homeSettingsSegue" {
            let nextVC = segue.destination as? HomeSettingsViewController
            nextVC?.selectedHomeIndex = sender as! Int
        }
        print("Problem in prepare for segue")
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
