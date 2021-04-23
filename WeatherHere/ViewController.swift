//
//  ViewController.swift
//  WeatherHere
//
//  Created by apple on 22/04/21.
//

import UIKit
import Alamofire

class CellClass: UITableViewCell {
    
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(dataSource)
        valuePicker = dataSource[indexPath.row]
        self.cityy.text! = dataSource[indexPath.row]
        customDropDownData(city: valuePicker)
        removeTransparentView()
        addTransparentView(frames: selectedButton.frame)

        }
    
    var selectedButton = UIView()
    //var dataSource = [String]()
    var valuePicker = String()
    var dataSource = ["Mumbai","New Delhi", "Bengaluru", "Ahmedabad", "Pune", "Jaipur", "Kolkata", "Surat", "Chennai", "Dehradun"]
    var count = Int()
    var cityName = String()
    var cityTempe = Double()
    var citySky = String()
    var citySkyDesc = String()
    var colldata : [WeatherDataModels] = []
    @IBOutlet weak var weatherDataCollView: UICollectionView!
    
    @IBOutlet weak var cityy: UILabel!
    @IBOutlet weak var dropDownView: UIView!
    private let API_KEY = "2457e554ff9480721ab2226adb00f3d2"
    let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        let heightZero = UITapGestureRecognizer(target: self , action: #selector((CDDsomeee)) )
        heightZero.delegate = self
        dropDownView.addGestureRecognizer(heightZero)
        dropDownView.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    func customDropDownData(city: String) {
        let query = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? city
        let path = "http://api.openweathermap.org/data/2.5/weather?q=%@&appid=%@&units=metric"
        let urlString = String(format: path, query, API_KEY)
        AF.request(urlString).responseDecodable(of: WeatherData.self, queue: .main, decoder: JSONDecoder()){(response) in
            switch response.result{
            case .success(let weatherData):
                self.colldata.removeAll()
                self.cityName = weatherData.name
                self.cityTempe = weatherData.main.temp
               // self.citySky = weatherData.weather.
                print("aaya kyaf3edcwsqa\(weatherData)")
                
                // 1. Access yourJSON ["data"] only if you have ensured that the data type of yourJSON["data"] is correct as you have envisioned.
                self.citySky = weatherData.weather[0].main
                self.citySkyDesc = weatherData.weather[0].description
                let dataaa = WeatherDataModels.init(cityname: self.cityName, cityTemperature: self.cityTempe, citiSky: self.citySky, citySkyDesc: self.citySkyDesc)
                    
                self.colldata.append(dataaa!)
                self.weatherDataCollView.reloadData()
            case .failure(let error):
                print("error:\(error)")
            }
        }
       
    
            }
    
    @objc func CDDsomeee() {
        selectedButton = dropDownView
        
        if(tableView.frame.height>0){
            

            removeTransparentView()

            
        }else{
            addTransparentView(frames: dropDownView.frame)

        }
      }
    func addTransparentView(frames: CGRect) {
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        tableView.reloadData()
        if dataSource.count <= 4 {
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.dataSource.count * 50))
            }, completion: nil)
            
        }
        else{
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: 250)
            }, completion: nil)
            
        }
        
    }
    
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }


}
extension ViewController : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view!.isDescendant(of: tableView) {
            print("falseeeeee")
            return false
        }
        print("trueeeeee")
        return true
    }
}
extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colldata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherData", for: indexPath) as! DisplayWeatherCollectionViewCell
        cellB.contentView.layer.cornerRadius = 6.0
        cellB.contentView.layer.borderWidth = 1.0
        cellB.contentView.layer.borderColor = UIColor.clear.cgColor
        cellB.contentView.layer.masksToBounds = true

        cellB.layer.shadowColor = UIColor.lightGray.cgColor
        cellB.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cellB.layer.shadowRadius = 6.0
        cellB.layer.shadowOpacity = 1.0
        cellB.layer.masksToBounds = false
        cellB.layer.shadowPath = UIBezierPath(roundedRect: cellB.layer.bounds, cornerRadius: cellB.layer.cornerRadius).cgPath
        cellB.layer.backgroundColor = UIColor.clear.cgColor
        cellB.configure(with: colldata[indexPath.row])
        return cellB
    }
    
   
}


