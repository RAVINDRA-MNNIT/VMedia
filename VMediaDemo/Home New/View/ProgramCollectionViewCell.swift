//
//  ProgramCollectionViewCell.swift
//  VMediaDemo
//
//  Created by Ravindra Arya on 5/19/20.
//  Copyright © 2020 Ravindra Arya. All rights reserved.
//

import UIKit

class ProgramCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
        gradientView.layer.cornerRadius = 8
        gradientView.clipsToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    private func setup()
    {
        gradientView.layer.borderWidth = 1.0
        gradientView.layer.borderColor = UIColor.white.cgColor
        gradientView.backgroundColor = UIColor.clear
    }

    func configureWithModel(program: ProgramElement,row : Int)
    {
        let startTime = Utility.convertDateTimeStringToDate(string: program.startTime)
        let endTime = startTime.addingTimeInterval(TimeInterval((program.length) * 60))
        self.titleLabel.text = program.name
        self.timeLabel.text = "\(Utility.getDateFromTimeStampByFormat(from:startTime) ?? "") - \(Utility.getDateFromTimeStampByFormat(from: endTime) ?? "")"
    }

    // MARK: UIFocusEnvironment
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({
            if !self.isFocused {
                self.setup()
            }
            else {
                self.gradientView.layer.borderWidth = 0.0
                self.gradientView.backgroundColor = UIColor.init(red: 0/255, green: 33/255, blue: 82/255, alpha: 1)
            }
        }, completion: nil)
    }
}

