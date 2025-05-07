//
//  ViewController.swift
//  WeatherApp
//
//  Created by Marcell Fulop on 5/7/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherTableView: UITableView!
    let networkLayer = NetworkLayer()
    var cities: [CityQuery] = []
    var citiesWeather: [CityWeather] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        weatherTableView.register(
            HeaderWeather.self,
            forHeaderFooterViewReuseIdentifier: "header"
        )
        UITableViewHeaderFooterView.appearance().tintColor = .systemGray6
        networkLayer.execute(
            request: CitiesRequest.createRequest(),
            modelName: [CityQuery].self
        ) { result in
            DispatchQueue.main.async {
                do {
                    self.cities = try result.get()
                } catch {
                    print("Error: \(error)")
                    abort()
                }
                for city in self.cities[0..<5] {
                    let cityName = city.localizedName
                    let cityKey = city.key
                    self.networkLayer.execute(
                        request: WeatherRequest.createRequest(cityKey: cityKey),
                        modelName: [AccuweatherResponse].self
                    ) { result in
                        DispatchQueue.main.async {
                            do {
                                let response = try result.get()
                                self.citiesWeather.append(
                                    CityWeather(
                                        city: cityName,
                                        temperature: response[0].temperature
                                            .value
                                    )
                                )
                                // print(self.citiesWeather.last ?? CityWeather(city: "no city", temperature: -1) )
                                self.weatherTableView.reloadData()
                            } catch {
                                print("Error: \(error)")
                                abort()
                            }
                        }
                    }
                }
            }
        }
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        guard
            let cell = weatherTableView.dequeueReusableCell(
                withIdentifier: "WeatherTableViewCell",
                for: indexPath
            ) as? WeatherTableViewCell
        else {
            return UITableViewCell()
        }
        if citiesWeather.count != 5 {
            return UITableViewCell()
        }
        cell.cityLabel.text = citiesWeather[indexPath.row].city
        cell.temperatureLabel.text =
            String(citiesWeather[indexPath.row].temperature) + " °F"
        return cell
    }

    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        guard
            let view = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: "header"
            ) as? HeaderWeather
        else {
            print("No header generated")
            return UIView()
        }
        //view.cityLabel.text = "City"
    
        return view
    }
}
