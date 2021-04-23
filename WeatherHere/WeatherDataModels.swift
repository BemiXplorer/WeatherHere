//
//  WeatherDataModels.swift
//  WeatherHere
//
//  Created by apple on 22/04/21.
//

import Foundation
import Foundation

class WeatherDataModels {
    
    //MARK: Properties
    var cityname: String
    var cityTemperature: Double
    var citiSky: String
    var citySkyDesc: String
   
    
    
    
    //MARK: Initialization
    
    init?(cityname: String, cityTemperature: Double, citiSky: String, citySkyDesc: String) {
        
        // The name must not be empty
     

        // The rating must be between 0 and 5 inclusively
     
        // Initialize stored properties.
        self.cityname = cityname
        self.cityTemperature = cityTemperature
        self.citiSky = citiSky
        self.citySkyDesc = citySkyDesc
        
        
        
    }
}
