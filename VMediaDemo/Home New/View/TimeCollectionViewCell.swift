//
//  TimeCollectionViewCell.swift
//  VMediaDemo
//
//  Created by Ravindra Arya on 5/19/20.
//  Copyright © 2020 Ravindra Arya. All rights reserved.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    var startTime = "12:00 AM"


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func setup() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.clear.cgColor
    }

    func configureCell(indexInt:Int)
    {
        self.timeLabel.textAlignment = .left
         self.timeLabel.text  = ""

        if indexInt != 0
        {

            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(abbreviation: "UTC")!
            let date1 = formatter.date(from: startTime)
            self.timeLabel.text = formatter.string(for: date1?.addingTimeInterval(TimeInterval((indexInt - 1)*30*60)))
        }
    }

}
