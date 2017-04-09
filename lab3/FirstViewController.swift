//
//  SecondViewController.swift
//  lab2
//
//  Created by Admin on 21.02.17.
//  Copyright © 2017 arthur. All rights reserved.
//

import UIKit
import Alamofire
class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    //var carModels: [Int:[String:String]] = [0:["name":"logan"],1:["name":"caprut"]];
    var weather: [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
  
        WeatherService.getRawWeatherArray { (result: [AnyObject]) in
            self.weather = result
            self.tableView.reloadData()
        }
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return(weather.count)
    }
    public func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FirstViewControllerTableViewCell
        
        let wind = weather[indexPath.row]["wind"] as? NSDictionary
      
        cell.weatherDesc.text = "Ветер " + (wind?["speed"] as! NSNumber).stringValue + " м/с"
        
        let temperature = (weather[indexPath.row]["main"]as? NSDictionary)?["temp"]
        cell.weatherTemp.text = (String(lround(temperature as! Double))) + "°C"
        
        let region = weather[indexPath.row]["name"]
        cell.cityName.text = region as? String
        
        return(cell)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retrieveWeatherInfo(row:Int)->[String:String] {
        let region = weather[row] as! NSDictionary
        return WeatherService.formatArray(data: region)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ShowDetailView") {
            
            let controller =  segue.destination as! DetailViewController
            let row = self.tableView.indexPathForSelectedRow?.row
            
            controller.regionInfo = retrieveWeatherInfo(row: row!)
        }
        
        
    }
    
    
}

