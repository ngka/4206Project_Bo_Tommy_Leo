//
//  TemperatureViewController.swift
//  4206_IOSproject_TsangKaPo_ChowChingHo_NgKaKin
//
//  Created by NgKaKin on 10/12/2023.
//

import UIKit
import MapKit
class TemperatureViewController: UIViewController {

    @IBOutlet weak var currentlocation: MKMapView!
    @IBOutlet weak var Iconimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Iconimage.backgroundColor = .systemBlue
        Iconimage.layer.masksToBounds = true
        Iconimage.layer.cornerRadius = Iconimage.frame.height / 2
        
        currentlocation.layer.masksToBounds = true
        currentlocation.layer.cornerRadius = currentlocation.frame.height / 3

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
