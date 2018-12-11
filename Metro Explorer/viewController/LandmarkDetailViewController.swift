//
//  LandmarkDetailViewController.swift
//  Metro Explorer
//
//  Created by zhenghao zhang on 12/2/18.
//  Copyright © 2018 zhenghao zhang. All rights reserved.
//

import UIKit

class LandmarkDetailViewController: UIViewController {
    
    @IBOutlet weak var landmarkName: UILabel!
    @IBOutlet weak var landmarkImage: UIImageView!
    @IBOutlet weak var landmarkDescription :UITextView!
    
  
    var landmark : Landmark?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        landmarkName.text = landmark?.name
       // landmarkDescription.attributedText = landmark?.name
       // landmarkImage.load(url: (landmark?.logoUrlString))
       // landmarkDescription.textStorage = landmark?.name
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
