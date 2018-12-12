//
//  MenuViewController.swift
//  Metro Explorer
//
//  Created by zhenghao zhang on 12/2/18.
//  Copyright © 2018 zhenghao zhang. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nearestButtonPressed(_ sender: Any) {
        
        print("nearest button pressed")
        performSegue(withIdentifier: "nearestSegue", sender: self)
    }
    @IBAction func searchButtonPressed(_ sender: Any) {
        
        print("nearest button pressed")
        performSegue(withIdentifier: "searchSegue", sender: self)
    }
    
    @IBAction func favoriteButtonPressed(_ sender: Any){
        print("favoriteButtonPressed")
        performSegue(withIdentifier: "favoriteSegue", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nearestSegue" {
            let destination = segue.destination as! MetroStationsViewController
            destination.searchType = "nearest"
        } else if segue.identifier == "searchSegue" {
            let destination = segue.destination as! MetroStationsViewController
            destination.searchType = "search"
        } else if segue.identifier == "favoriteSegue"{
            let destination = segue.destination as! LandmarksViewController

            destination.searchType = "favorite"
        }
    }


}
