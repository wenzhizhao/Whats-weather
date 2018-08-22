//
//  ViewController.swift
//  WhatsWeather
//
//  Created by Wenzhi Zhao on 8/13/18.
//  Copyright © 2018 Wenzhi Zhao. All rights reserved.
//

import UIKit

class WWViewController: UIViewController {
    var weatherArray: [WWWeather]?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.fetchData()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func fetchData() {
        let urlString = String(format: WWConstants.baseURL, WWConstants.latitude, WWConstants.longitude)
        let url = URL.init(string: urlString)
        let fetcher = WWFetcher(url)
        configureViews(true)
        fetcher.fetchWeather({ (result) in
            guard let summary = try? JSONDecoder().decode(WWSummary.self, from: result) else {
                print("Error: Couldn't decode data into WWSummary")
                return
            }
            self.weatherArray = summary.summaryList.weatherList
            DispatchQueue.main.async { [weak self] in
                self?.configureViews(false)
                self?.tableView.reloadData()
            }
        }) { (error) in
            DispatchQueue.main.async { [weak self] in
                self?.failedFetching()
            }
        }
    }
    private func configureViews (_ isFetching: Bool) {
        if isFetching {
            self.tableView.isHidden = true
            self.loadingLabel.isHidden = false
        } else {
            self.tableView.isHidden = false
            self.loadingLabel.isHidden = true
        }
    }
    private func failedFetching() {
        self.tableView.isHidden = true
        self.loadingLabel.text = "Please check network connectivity, and try again"
    }
}

extension WWViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: WWTableViewCell.identifier, for: indexPath)
        if let wwcell = cell as? WWTableViewCell, let weather = weatherArray?[indexPath.row] {
            wwcell.configureCell(weather)
            return wwcell
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
