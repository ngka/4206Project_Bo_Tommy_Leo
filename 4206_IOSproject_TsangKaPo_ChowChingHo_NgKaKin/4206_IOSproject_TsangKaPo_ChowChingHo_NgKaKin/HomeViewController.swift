//
//  TemperatureViewController.swift
//  4206_IOSproject_TsangKaPo_ChowChingHo_NgKaKin
//
//  Created by NgKaKin on 10/12/2023.
//

import UIKit
import MapKit
import CoreData
class HomeViewController: UIViewController,CLLocationManagerDelegate {

    
    @IBOutlet weak var currentlocation: MKMapView!
    @IBOutlet weak var Iconimage: UIImageView!
    
    @IBOutlet weak var lbtime: UILabel!
    
    @IBOutlet weak var lbdate: UILabel!
    
    @IBOutlet weak var lbtemp: UILabel!
    
    var latitude : Double?
    var longitude : Double?
    let locationManager = CLLocationManager()
    
    let oneWeek = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    //let minuteTimer = Timer.scheduledTimer(timeInterval: 60, target: HomeViewController.self, selector: #selector(updatetimeLabel), userInfo: nil, repeats: true)
    
    var managedObjectContex : NSManagedObjectContext?{
        if let delegate = UIApplication.shared.delegate as? AppDelegate{
            return delegate.persistentContainer.viewContext;
        }
        return nil;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Iconimage.backgroundColor = .systemBlue
        Iconimage.layer.masksToBounds = true
        Iconimage.layer.cornerRadius = Iconimage.frame.height / 2
        
        currentlocation.layer.masksToBounds = true
        currentlocation.layer.cornerRadius = currentlocation.frame.height / 3

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        let countryCode = Locale.current
        let localeString = countryCode.identifier
        print(localeString)
        updatetimeLabel()
    }
    
    func getCurrentWeather(lat: Double, lon:Double){
        APIService.shared.getCurrentWeather(lat: lat, lon: lon) {[weak self] result in DispatchQueue.main.async {
            switch result{
            case.success(let currentTemp):
                let currentTemp_celsius = currentTemp.main.temp - 273.15
                self?.lbtemp.text = String(format:"%.1f",currentTemp_celsius)+" °C, " + currentTemp.weather[0].main
                print(currentTemp_celsius)
                let iconID = String(currentTemp.weather[0].icon)
                self?.updateWeatherICON(IconID: iconID)
            case.failure(let error):
                print("--------------------")
                print(error)
            }
        }
            
        }
    }
    
    func updatetimeLabel(){
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let week = calendar.component(.weekday, from: date)
        let hour = calendar.component(.hour, from: date)
        let min = calendar.component(.minute,from: date)
        lbtime.text = String(hour) + ":" + String(min)
        lbdate.text = String(year) + "/" + String(month) + "/" + String(day) + ", " + oneWeek[week-1]
    }
    
    func updateWeatherICON(IconID : String){
        let urlLink = "https://openweathermap.org/img/wn/" + IconID + "@2x.png"
        let url = URL(string: urlLink)!
        //let data = try? Data(contentsOf: url)
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Check for errors, handle the response
            guard let data = data, error == nil else {
                print(error)
                return
            }

            // Process the data
            let imagedata = data
            let image = UIImage(data: imagedata)
            DispatchQueue.main.async {
                // Update UI on main thread

                    self.Iconimage.image = image
                
            }
        }.resume()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error:: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            print(latitude!,longitude!)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01);
            let coord = location.coordinate;
            let region = MKCoordinateRegion(center: coord, span: span)
            self.currentlocation?.setRegion(region, animated: false);
            getCurrentWeather(lat: latitude!, lon: longitude!)
        }
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
