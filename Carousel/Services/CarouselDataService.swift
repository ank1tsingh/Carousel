//
//  CarouselDataService.swift
//  Carousel
//
//  Created by Ankit on 02/08/25.
//

import Foundation


protocol CarouselDataServiceProtocol {
    func fetchDestinations() async throws -> [CarouselItem]
}

final class CarouselDataService: CarouselDataServiceProtocol {
    func fetchDestinations() async throws -> [CarouselItem] {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        return [
            CarouselItem(
                imageURL: "https://picsum.photos/250/250",
                title: "Malaysia",
                subtitle: "Visas on Time",
                processingTime: "3-5 days"
            ),
            CarouselItem(
                imageURL: "https://picsum.photos/250/250",
                title: "Singapore",
                subtitle: "Fast Processing",
                processingTime: "2-3 days"
            ),
            CarouselItem(
                imageURL: "https://picsum.photos/250/250",
                title: "Thailand",
                subtitle: "Easy Application",
                processingTime: "5-7 days"
            ),
            CarouselItem(
                imageURL: "https://picsum.photos/250/250",
                title: "Vietnam",
                subtitle: "Quick Approval",
                processingTime: "4-6 days"
            ),
            CarouselItem(
                imageURL: "https://picsum.photos/250/250",
                title: "Philippines",
                subtitle: "Reliable Service",
                processingTime: "7-10 days"
            )
        ]
    }
}
