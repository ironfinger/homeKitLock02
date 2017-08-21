//
//  AccessorySettingsViewController.swift
//  homeKitLock02
//
//  Created by Thomas Houghton on 17/08/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import HomeKit

class AccessorySettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var accessoryNameLbl: UILabel!
    @IBOutlet weak var currentRoomLbl: UILabel!
    
    let homeManager = HMHomeManager()
    
    var selectedAccessory = HMAccessory()
    var selectedAccessoryIndex = 0
    var selectedHomeIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        subView.layer.cornerRadius = 10
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subView.alpha = 0
        accessoryNameLbl.text = selectedAccessory.name
        if selectedAccessory.room?.name == nil {
            currentRoomLbl.text = "please assign to a room"
        }else{
            currentRoomLbl.text = "Current Room \(selectedAccessory.room?.name)"
        }
        tableView.reloadData()
    }
    
    // MARK: Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //let rooms = homeManager.homes[selectedHomeIndex].rooms
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        //let rooms = homeManager.homes[selectedHomeIndex].rooms
        //let room = rooms[indexPath.row]
        cell.textLabel?.text = "room.name"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // let accessory = homeManager.homes[selectedHomeIndex].accessories[selectedAccessoryIndex]
        
    }
    
    // MARK: ACTIONS
    
    @IBAction func assignSubViewCallerTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.25) {
            self.subView.alpha = 1
        }
    }
    
    @IBAction func assignButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func unPairBtnTapped(_ sender: Any) {
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
