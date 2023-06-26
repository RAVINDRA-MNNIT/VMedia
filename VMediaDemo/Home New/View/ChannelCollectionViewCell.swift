//
//  ChannelCollectionViewCell.swift
//  VMediaDemo
//
//  Created by Ravindra Arya on 5/19/20.
//  Copyright © 2020 Ravindra Arya. All rights reserved.
//

import UIKit
//import SDWebImage

class ChannelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var channelName: UILabel!
    @IBOutlet weak var channelNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    func setup() {
         self.containerView.backgroundColor = UIColor.init(red: 89/255, green: 97/255, blue: 100/255, alpha: 1.0)
        
    }

    func configureWith(channel: ChannelElement)
    {
        self.containerView.layer.cornerRadius = 8
        self.containerView.clipsToBounds = true
        self.channelName.text = channel.callSign
        self.channelNumber.text = "\(channel.id)"
    }

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({
            if !self.isFocused {
                self.containerView.backgroundColor = UIColor.init(red: 89/255, green: 97/255, blue: 100/255, alpha: 1.0)
            }
            else {
                self.containerView.backgroundColor = UIColor.lightGray
            }
        }, completion: nil)
    }
}
