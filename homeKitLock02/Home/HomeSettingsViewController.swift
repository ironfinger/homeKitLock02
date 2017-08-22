//
//  HomeSettingsViewController.swift
//  homeKitLock02
//
//  Created by Thomas Houghton on 17/08/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import HomeKit

class HomeSettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HMHomeManagerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var primaryHomeSwitch: UISwitch!
    @IBOutlet weak var setHomeNameTextField: UITextField!
    @IBOutlet weak var changeNameBtn: UIButton!
    @IBOutlet weak var navBar: UINavigationItem!
    
    let homeManager = HMHomeManager()
    
    var selectedHomeIndex = 0
    var selectedRoomIndex = 0
    var homes = [HMHome]()
    var homeAmount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        self.homeManager.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.homeManager.delegate = self
        homeAmount = homeManager.homes[selectedHomeIndex].rooms.count
        
        if homeManager.homes[selectedHomeIndex].isPrimary != true {
            primaryHomeSwitch.setOn(false, animated: false)
        }else if homeManager.homes[selectedHomeIndex].isPrimary == true {
            primaryHomeSwitch.setOn(true, animated: false)
        }else {
            primaryHomeSwitch.setOn(false, animated: false)
            print("somehow the primary status isn't either true or false")
        }
        
        if setHomeNameTextField.text == nil {
            changeNameBtn.isEnabled = false
        }else if setHomeNameTextField.text == "" {
            changeNameBtn.isEnabled = false
        }
        
        for item in homeManager.homes {
            homes.append(item)
        }
        
        navBar.title = homeManager.homes[selectedHomeIndex].name
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    // MARK: Table View.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Hello table")
        return homeAmount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let home = homes[selectedHomeIndex]
        let room = home.rooms[indexPath.row]
        cell.textLabel?.text = room.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRoomIndex = indexPath.row
        performSegue(withIdentifier: "roomSettingsViewController", sender: nil)
    }
    
    // MARK: IBActions
    
    @IBAction func changeNameBtnTapped(_ sender: Any) {
        homeManager.homes[selectedHomeIndex].updateName(setHomeNameTextField.text!) { (error) in
            if error != nil {
                print(error)
            }else{
                print("Successfully set the home name")
                self.setHomeNameTextField.text = nil
                self.changeNameBtn.isEnabled = false
                self.navBar.title = self.homeManager.homes[self.selectedHomeIndex].name
            }
        }
    }
    
    @IBAction func homeNameTextFieldValueChanged(_ sender: Any) {
        changeNameBtn.isEnabled = true
    }
    
    @IBAction func homeNameTextFieldEditingBegins(_ sender: Any) {
        changeNameBtn.isEnabled = true    }
    @IBAction func changeHomeNameTextFieldTouchUpInside(_ sender: Any) {
        changeNameBtn.isEnabled = true
    }
    
    @IBAction func primaryHomeSwitch(_ sender: Any) {
        let home = homeManager.homes[selectedHomeIndex]
        homeManager.updatePrimaryHome(home) { (error) in
            if error != nil {
                print("Couldn't set as primary home \(error)")
            }
        }
    }
    
    @IBAction func addRoomBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "AddRoomSegue", sender: nil)
    }
    
    // MARK: Updates
    
    func homeManagerDidUpdatePrimaryHome(_ manager: HMHomeManager) {
        if homeManager.homes[selectedHomeIndex].isPrimary != true {
            primaryHomeSwitch.setOn(false, animated: false)
        }else if homeManager.homes[selectedHomeIndex].isPrimary == true {
            primaryHomeSwitch.setOn(true, animated: false)
        }else {
            primaryHomeSwitch.setOn(false, animated: false)
            print("somehow the primary status isn't either true or false")
        }
        
        navBar.title = homeManager.homes[selectedHomeIndex].name
    }
    
    // MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddRoomSegue" {
            let nextVC = segue.destination as? AddRoomViewController
            nextVC?.chosenHomeIndex = selectedHomeIndex
        }else if segue.identifier == "roomSettingsViewController" {
            let nextVC = segue.destination as? RoomSettingsViewController
            nextVC?.homeIndex = selectedHomeIndex
            nextVC?.roomIndex = selectedRoomIndex
            nextVC?.roomAccessories.removeAll()
            for item in homeManager.homes[selectedHomeIndex].rooms[selectedRoomIndex].accessories {
                nextVC?.roomAccessories.append(item)
            }
        }
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
