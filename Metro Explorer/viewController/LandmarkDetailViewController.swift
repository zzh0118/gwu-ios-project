//
//  LandmarkDetailViewController.swift
//  Metro Explorer
//
//  Created by zhenghao zhang on 12/2/18.
//  Copyright © 2018 zhenghao zhang. All rights reserved.
//

import UIKit

class LandmarkDetailViewController: UIViewController {
    
    var landmark : Landmark?
    
    
    @IBOutlet weak var landmarkName: UILabel!
    @IBOutlet weak var landmarkImage: UIImageView!
    @IBOutlet weak var landmarkDescription :UITextView!
    @IBOutlet weak var landmarkRate: UIImageView!
    @IBAction func favoriteButton (_ sender: Any){
        if (!landmark!.save){
            let landmarkSaved = landmark
            
            PersistenceManager.sharedInstance.saveLandmark(landmark: landmarkSaved!)
            landmark!.save = true
            let message = "The name of landmark:  \(String(landmark!.name))" + "\n the address is \(String(landmark!.address))"
            
            let alert = UIAlertController(title: "Save to favorite", message: message, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "ok", style: .default, handler: nil)
                
            alert.addAction(action)
            
            present(alert,animated: true,completion: nil)
        } else {
            
            let message = "The name of landmark:  \(String(landmark!.name))" + "\n the address is \(String(landmark!.address) + " already saved")"
            
            let alert = UIAlertController(title: "Already Saved to favorite", message: message, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "ok", style: .default, handler: nil)
            
            alert.addAction(action)
            
            present(alert,animated: true,completion: nil)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (PersistenceManager.sharedInstance.checkStatus(landmark: landmark!)){
            print("status = ture ")
        } else {
            print("status = false")
        }
        landmarkName?.text = landmark?.name
        landmarkImage?.load(url: (landmark!.logoUrlString))
        landmarkDescription?.text = String(landmark!.address)
        
        let uiImage = fetchUIImage(rating: landmark!.rating)
        landmarkRate?.image = UIImage(named: uiImage)
        print(uiImage)
       
    }
    
    func fetchUIImage (rating: Double) -> String{
        var rate: String
        if rating == 1.5 {
            rate = "extra_large_1_half"
        } else if rating == 2.5 {
            rate = "extra_large_2_half"
        } else if rating == 3.5 {
            rate = "extra_large_3_half"
        } else if rating == 4.5 {
            rate = "extra_large_4_half"
        } else{
            rate = "extra_large_\(Int(rating))"
        }
        return rate;
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
