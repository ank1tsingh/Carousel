//
//  CarouselCalculationService.swift
//  Carousel
//
//  Created by Ankit on 02/08/25.
//

import Foundation
import CoreGraphics

protocol CarouselCalculationServiceProtocol {
    func calculateNewIndex(currentIndex: Int, totalItems: Int, dragDistance: CGFloat, velocity: CGFloat, itemWidth: CGFloat) -> Int
    func calculateCenterOffset(screenWidth: CGFloat, itemWidth: CGFloat) -> CGFloat
    func calculateFinalOffset(centerOffset: CGFloat, targetIndex: Int, itemWidth: CGFloat) -> CGFloat
    func calculateScale(for index: Int, screenWidth: CGFloat, finalOffset: CGFloat, actualItemWidth: CGFloat, itemWidth: CGFloat) -> CGFloat
}

final class CarouselCalculationService: CarouselCalculationServiceProtocol {
    
    func calculateNewIndex(currentIndex: Int, totalItems: Int, dragDistance: CGFloat, velocity: CGFloat, itemWidth: CGFloat) -> Int {
        
        let dragThreshold = itemWidth * DesignConstants.Carousel.dragThresholdPercentage
        let velocityThreshold = DesignConstants.Carousel.velocityThreshold
        var newIndex = currentIndex
        
        if dragDistance > dragThreshold || velocity > velocityThreshold {
            newIndex = currentIndex - 1
        } else if dragDistance < -dragThreshold || velocity < -velocityThreshold {
            newIndex = currentIndex + 1
        }
        return max(0, min(newIndex, totalItems - 1))
    }
    
    func calculateCenterOffset(screenWidth: CGFloat, itemWidth: CGFloat) -> CGFloat {
        return (screenWidth - itemWidth) / 2
    }
    
    func calculateFinalOffset(centerOffset: CGFloat, targetIndex: Int, itemWidth: CGFloat) -> CGFloat {
        return centerOffset - CGFloat(targetIndex) * itemWidth
    }
    
    func calculateScale(for index: Int, screenWidth: CGFloat, finalOffset: CGFloat, actualItemWidth: CGFloat, itemWidth: CGFloat) -> CGFloat {
        let centerX = screenWidth / 2
        let itemCenterX = finalOffset + CGFloat(index) * actualItemWidth + (itemWidth / 2)
        let distance = abs(itemCenterX - centerX)
        let maxDistance = actualItemWidth
        let normalizedDistance = min(distance / maxDistance, 1.0)
        return 1.0 - (normalizedDistance * DesignConstants.Carousel.scaleRange)
    }
}
