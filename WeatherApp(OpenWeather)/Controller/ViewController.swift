//
//  ViewController.swift
//  WeatherApp(OpenWeather)
//
//  Created by Viktor Golubenkov on 10.01.2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var descriptionWeatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    
    @IBOutlet weak var locationButtonLabel: UIButton!
    @IBOutlet weak var searchButtonLabel: UIButton!
    
    
    
    var weatherManager = WeatherManager()
    
    let locationManager = CLLocationManager()
    
    let addForTemp = "°C"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        weatherManager.delegate = self
    
        searchTextField.delegate = self
    }

}

//MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {

    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        
        UIView.animate(withDuration: 0.5) {
            self.searchButtonLabel.transform = CGAffineTransform(scaleX: 4.0, y: 4.0)
            self.searchButtonLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something..."
            return false
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
    }
}

//MARK: - WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString + self.addForTemp
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.descriptionWeatherLabel.text = weather.descriptionTheWeather
            self.cityLabel.text = weather.cityName
            self.feelsLikeLabel.text = weather.feelsLikeString + self.addForTemp
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - LocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    
    @IBAction func currentLocationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
        
        UIView.animate(withDuration: 0.5) {
            self.locationButtonLabel.transform = CGAffineTransform(scaleX: 4.0, y: 4.0)
            self.locationButtonLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
}
