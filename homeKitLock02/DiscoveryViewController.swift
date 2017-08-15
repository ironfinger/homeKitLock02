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
    
    let homeManager = HMHomeManager()
    let browser = HMAccessoryBrowser()
    
    var accessories = [HMAccessory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        browser.delegate = self
        
        // Start the discovery process.
        browser.startSearchingForNewAccessories()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accessories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell()
            let accessory = accessories[indexPath.row] as HMAccessory
            cell.textLabel?.text = accessory.name
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let accessory = accessories[indexPath.row] as HMAccessory
        print("Pairing \(accessory.name)")
        
        if let room = homeManager.primaryHome?.rooms.first as HMRoom? {
            homeManager.primaryHome?.addAccessory(accessory, completionHandler: { (error) in
                if error != nil {
                    print("We couldn't assign accessory \(error)")
                }else{
                    self.homeManager.primaryHome?.assignAccessory(accessory, to: room, completionHandler: { (error) in
                        if error != nil {
                            print("We have an erroro with assigning the accessory to a room: \(error)")
                        }else{
                            print("accessory assigned to \(room.name)")
                        }
                    })
                }
            })
        }else{
            self.performSegue(withIdentifier: "discoveryToAddHomeSegue", sender: nil)
        }
    }
    
    func accessoryBrowser(_ browser: HMAccessoryBrowser, didFindNewAccessory accessory: HMAccessory) {
        accessories.append(accessory)
        tableView.reloadData()
    }
    
    func accessoryBrowser(_ browser: HMAccessoryBrowser, didRemoveNewAccessory accessory: HMAccessory) {
        var index = 0
        for item in accessories {
            if item.name == accessory.name {
                accessories.remove(at: index)
                break;
            }
            index = index + 1
        }
        tableView.reloadData()
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
