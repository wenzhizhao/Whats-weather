//
//  WWTableViewCell.swift
//  WhatsWeather
//
//  Created by Wenzhi Zhao on 8/18/18.
//  Copyright © 2018 Wenzhi Zhao. All rights reserved.
//

import UIKit

class WWTableViewCell: UITableViewCell {
    static let identifier = "wwcell"
    private struct StringFormatter {
        static let dateFormatter = "Date:%@"
        static let minTempFormatter = "Min Temperature:%@"
        static let maxTempFormatter = "Max Temperature:%@"
        static let summaryFormatter = "Summary:%@"
    }
    //Mark: outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    func configureCell(_ weather: WWWeather) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateText = formatter.string(from: weather.date)
        dateLabel.text = String(format: StringFormatter.dateFormatter, dateText)
        let minText = String(format: "%.2f", Double(truncating: weather.minTemperature as NSNumber))
        minTemperatureLabel.text = String(format: StringFormatter.minTempFormatter, minText)
        let maxText = String(format: "%.2f", Double(truncating: weather.maxTemperature as NSNumber))
        maxTemperatureLabel.text = String(format: StringFormatter.maxTempFormatter, maxText)
        summaryLabel.text = String(format: StringFormatter.summaryFormatter, weather.summary)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
