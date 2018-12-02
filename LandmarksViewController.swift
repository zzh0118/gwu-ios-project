//
//  LandmarksViewController.swift
//  Metro Explorer
//
//  Created by zhenghao zhang on 12/2/18.
//  Copyright © 2018 zhenghao zhang. All rights reserved.
//

import UIKit

class LandmarksViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Landmarks loaded success")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func close(){
        dismiss(animated: true, completion: nil)
    }


}
