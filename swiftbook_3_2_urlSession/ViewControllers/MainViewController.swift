//
//  ViewController.swift
//  swiftbook_3_2_urlSession
//
//  Created by dobrets on 06.11.2022.
//

import UIKit

enum Alert {
    case success
    case failed
    
    var title: String {
        switch self {
        case .success:
            return "Success"
        case .failed:
            return "Failed"
        }
    }
    
    var message: String {
        switch self {
        case .success:
            return "You can see the results in the Debug area"
        case .failed:
            return "You can see error in the Debug area"
        }
    }
}

class MainViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var temperatureLabel: UILabel!
    
    let catUrl = "https://thiscatdoesnotexist.com"
    let weatherUrl = "https://api.open-meteo.com/v1/forecast?latitude=43.2340992&longitude=76.8868352&current_weather=true"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
    
    @IBAction func nextButtonPressed() {
        activityIndicator.startAnimating()
        fetchImage()
    }
    
    @IBAction func showJsonButtonPressed() {
        fetchWeather()
    }
    
    private func fetchImage() {
        guard let url = URL(string: catUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            print(response)
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.imageView.image = image
                self?.activityIndicator.stopAnimating()
            }
        }.resume()
    }
    
    private func fetchWeather() {
        guard let url = URL(string: weatherUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let weather = try decoder.decode(Weather.self, from: data)
                print(weather)
                self?.showAlert(withStatus: .success)
                DispatchQueue.main.async {
                    self?.temperatureLabel.text = "temperature in Almaty \(weather.current_weather?.temperature ?? 0)"
                }
            } catch let error {
                self?.showAlert(withStatus: .failed)
                print(String(describing: error))
            }
            
        }.resume()
    }
    
    private func showAlert(withStatus status: Alert) {
        DispatchQueue.main.async { [unowned self] in
            let alert = UIAlertController(title: status.title, message: status.message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
    }
}

