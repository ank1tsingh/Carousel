//
//  DesignConstants.swift
//  Carousel
//
//  Created by Ankit on 02/08/25.
//

import Foundation
import SwiftUI

enum DesignConstants {
    enum Carousel {
        static let itemWidth: CGFloat = 250
        static let itemHeight: CGFloat = 250
        static let cornerRadius: CGFloat = 16
        static let scaleRange: CGFloat = 0.18
        static let dragThresholdPercentage: CGFloat = 0.25
        static let velocityThreshold: CGFloat = 150
    }
    
    enum Colors {
        static let primaryBlue = Color.blue
        static let secondaryGray = Color.gray.opacity(0.4)
        static let loadingGray = Color.gray.opacity(0.2)
    }
    
    enum Icons {
        static let malaysia = "building.2"
        static let singapore = "building.columns"
        static let thailand = "camera.macro"
        static let vietnam = "leaf"
        static let philippines = "beach.umbrella"
        static let defaultIcon = "airplane"
        static let clock = "clock"
        static let error = "exclamationmark.triangle"
    }
}
