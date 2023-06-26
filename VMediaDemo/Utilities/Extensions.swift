//
//  Extensions.swift
//  VMediaDemo
//
//  Created by Ravindra Arya on 5/13/20.
//

import UIKit

extension CGFloat {
    func pointsToPixel() -> CGFloat {
        return self * UIScreen.main.scale
    }
}

