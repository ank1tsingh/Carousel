//
//  CarouselItem.swift
//  Carousel
//
//  Created by Ankit on 02/08/25.
//

import Foundation

struct CarouselItem: Identifiable, Equatable {
    let id = UUID()
    let imageURL: String?
    let title: String
    let subtitle: String
    let processingTime: String
    
    static func == (lhs: CarouselItem, rhs: CarouselItem) -> Bool {
        lhs.id == rhs.id
    }
}
