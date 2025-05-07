//
//  HeaderWeather.swift
//  WeatherApp
//
//  Created by Marcell Fulop on 5/7/25.
//

import UIKit

class HeaderWeather: UITableViewHeaderFooterView {

    let cityLabel = UILabel()
    let temperatureLabel = UILabel()

   // @IBOutlet var weatherView: UIView!
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureContents() {
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.text = "City"
        cityLabel.textColor = .darkGray
        cityLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        contentView.addSubview(cityLabel)
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.text = "Temperature"
        temperatureLabel.textAlignment = .right
        temperatureLabel.textColor = .darkGray
        temperatureLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        contentView.addSubview(temperatureLabel)
        
        NSLayoutConstraint.activate([

            // Center the label vertically, and use it to fill the remaining
            // space in the header view.
            cityLabel.heightAnchor.constraint(equalToConstant: 30),
            cityLabel.leadingAnchor.constraint(
                equalTo:
                    contentView.leadingAnchor, constant: 10
            ),
            cityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
           // temperatureLabel.widthAnchor.constraint(equalToConstant: 100),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 30),
            //temperatureLabel.trailingAnchor.constraint(equalTo:
            //                                            contentView.trailingAnchor, constant: 25
             //                                        ),
            //temperatureLabel.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor, constant: 10),
            temperatureLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -10
            ),
            temperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

}
