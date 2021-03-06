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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CharacteristicVCSegue", sender: indexPath.row)
    }
    
    // MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as? CharacteristicsViewController
        nextVC?.selectedAccessoryIndex = selectedAccessoryIndex
        nextVC?.selectedServiceIndex = sender as! Int
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
