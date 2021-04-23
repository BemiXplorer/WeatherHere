//
//  DisplayWeatherCollectionViewCell.swift
//  WeatherHere
//
//  Created by apple on 22/04/21.
//

import UIKit

class DisplayWeatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityTemp: UILabel!
    @IBOutlet weak var citySky: UILabel!
    @IBOutlet weak var citySkyDesc: UILabel!
    
    public func configure(with model: WeatherDataModels) {
    
    
        cityName.text = model.cityname
        cityTemp.text = String(model.cityTemperature)
        citySky.text = model.citiSky
        citySkyDesc.text = model.citySkyDesc
        
   // stwiTxtfld.text = model.chaptername
}
    
}
