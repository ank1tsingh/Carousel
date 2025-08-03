//
//  CarouselViewModel.swift
//  Carousel
//
//  Created by Ankit on 02/08/25.
//

import SwiftUI

@MainActor
final class CarouselViewModel: ObservableObject {
    
    @Published var items: [CarouselItem] = []
    @Published var currentIndex: Int = 0
    @Published var dragOffset: CGFloat = 0
    @Published var finalOffset: CGFloat = 0
    @Published var isLoading = false
    @Published var error: Error?
    @Published var isDragging = false
    
    private let dataService: CarouselDataServiceProtocol
    private let calculationService: CarouselCalculationServiceProtocol
    
    private let itemWidth: CGFloat = 250
    private let itemSpacing: CGFloat = -60
    
    var totalOffset: CGFloat {
        dragOffset + finalOffset
    }
    
    var actualItemWidth: CGFloat {
        itemWidth + itemSpacing
    }
    
    init(
        dataService: CarouselDataServiceProtocol = CarouselDataService(),
        calculationService: CarouselCalculationServiceProtocol = CarouselCalculationService()
    ) {
        self.dataService = dataService
        self.calculationService = calculationService
        
        Task {
            await loadItems()
        }
    }
    
    func loadItems() async {
        isLoading = true
        error = nil
        
        do {
            items = try await dataService.fetchDestinations()
            setupInitialOffset()
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    func handleDragChanged(value: DragGesture.Value) {
        isDragging = true
        withAnimation(.interactiveSpring(response: 0.35, dampingFraction: 0.8, blendDuration: 0.7)) {
            dragOffset = value.translation.width
        }
    }
    
    func handleDragEnded(value: DragGesture.Value) {
        let newIndex = calculationService.calculateNewIndex(
            currentIndex: currentIndex,
            totalItems: items.count,
            dragDistance: value.translation.width,
            velocity: value.predictedEndLocation.x - value.location.x,
            itemWidth: actualItemWidth
        )
        
        isDragging = false
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 1.0)) {
            dragOffset = 0
        }
        animateToIndex(newIndex)
    }
    
    func selectItem(at index: Int) {
        guard index >= 0 && index < items.count else { return }
        animateToIndex(index)
    }
    
    func retryLoading() {
        Task {
            await loadItems()
        }
    }
    private func setupInitialOffset() {
        let centerOffset = calculationService.calculateCenterOffset(
            screenWidth: UIScreen.main.bounds.width,
            itemWidth: itemWidth
        )
        finalOffset = centerOffset
    }
    
    private func animateToIndex(_ index: Int) {
        guard index != currentIndex else { return }
        
        let centerOffset = calculationService.calculateCenterOffset(
            screenWidth: UIScreen.main.bounds.width,
            itemWidth: itemWidth
        )
        
        let targetOffset = calculationService.calculateFinalOffset(
            centerOffset: centerOffset,
            targetIndex: index,
            itemWidth: actualItemWidth
        )
        
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.8, blendDuration: 1.0)) {
            currentIndex = index
            finalOffset = targetOffset
        }
    }
    
    func calculateScale(for index: Int, screenWidth: CGFloat) -> CGFloat {
        return calculationService.calculateScale(
            for: index,
            screenWidth: screenWidth,
            finalOffset: finalOffset,
            actualItemWidth: actualItemWidth,
            itemWidth: itemWidth
        )
    }
}

