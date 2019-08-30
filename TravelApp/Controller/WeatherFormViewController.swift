//
//  WeatherFormViewController.swift
//  TravelApp
//
//  Created by Angelique Babin on 19/08/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

class WeatherFormViewController: UIViewController {
    
    // MARK: - Properties
     let weatherService = WeatherService()
    
    // MARK: - Outlets
    @IBOutlet weak var updateWeatherButton: UIButton!
    @IBOutlet weak var cityAuversLabel: UILabel!
    @IBOutlet weak var temperatureAuversLabel: UILabel!
    @IBOutlet weak var conditionAuversLabel: UILabel!
    @IBOutlet weak var cityNYLabel: UILabel!
    @IBOutlet weak var temperatureNYLabel: UILabel!
    @IBOutlet weak var conditionNYLabel: UILabel!
    @IBOutlet var allLabels: [UILabel]!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
}

// MARK: - Validate
extension WeatherFormViewController {
    @IBAction func tapUpdateWeatherButton() {
        toggleActivityIndicator(shown: true, activityIndicator: activityIndicator, validateButton: updateWeatherButton)
        getWeather()
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        customWeatherInterface(allLabels: allLabels, button: updateWeatherButton)
        getWeather()
    }

    // MARK: - Methods
    private func getWeather() {
        weatherService.getWeather { (success, weather) in
            self.toggleActivityIndicator(shown: false,
                                         activityIndicator: self.activityIndicator,
                                         validateButton: self.updateWeatherButton)
            if success, let weather = weather {
                print(weather)
                self.updateWeather(weatherUpdated: weather)
            } else {
                // display an error message
                self.presentAlert(message: "The update weather download failed.")
            }
        }
    }

    // get description
    private func weatherCondition(list: ListDecodable, conditionLabel: UILabel) {
        let weatherCondition = list.weather[0].description.localizedCapitalized
        conditionLabel.text = weatherCondition
    }
    
    // get temperature
    private func weatherTemp(list: ListDecodable, tempLabel: UILabel) {
        let weatherTemp = Int(list.main.temp)
        let celsius = " C°"
        tempLabel.text = String(weatherTemp) + celsius
    }
    
    // get name of the city
    private func weatherCityName(list: ListDecodable, cityNameLabel: UILabel) {
        let weatherCityName = list.name
        cityNameLabel.text = weatherCityName
    }
    
    // update the weather to New York and Auvers-Sur-Oise
    private func updateWeather(weatherUpdated: WeatherAPI) {
        // Weather to New York
        let weatherNY = weatherUpdated.list[1]
        weatherCondition(list: weatherNY, conditionLabel: conditionNYLabel)
        weatherTemp(list: weatherNY, tempLabel: temperatureNYLabel)
        weatherCityName(list: weatherNY, cityNameLabel: cityNYLabel)

        // Weather to Auvers-Sur-Oise
        let weatherAuvers = weatherUpdated.list[0]
        weatherCondition(list: weatherAuvers, conditionLabel: conditionAuversLabel)
        weatherTemp(list: weatherAuvers, tempLabel: temperatureAuversLabel)
        weatherCityName(list: weatherAuvers, cityNameLabel: cityAuversLabel)
    }
}
