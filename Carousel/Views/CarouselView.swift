//
//  CarouselView.swift
//  Carousel
//
//  Created by Ankit on 02/08/25.
//

import SwiftUI

struct CarouselView: View {
    @StateObject private var viewModel = CarouselViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if viewModel.isLoading {
                loadingView
            } else if let error = viewModel.error {
                errorView(error)
            } else if !viewModel.items.isEmpty {
                carouselContent
                pageControl
            }
        }
        .padding(.vertical, 12)
    }
    
    private var loadingView: some View {
        HStack(spacing: 20) {
            ForEach(0..<3) { _ in
                RoundedRectangle(cornerRadius: 16)
                    .fill(DesignConstants.Colors.loadingGray)
                    .frame(width: DesignConstants.Carousel.itemWidth, height: DesignConstants.Carousel.itemHeight)
                    .overlay(
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    )
            }
        }
        .frame(height: 250)
    }
    
    private func errorView(_ error: Error) -> some View {
        VStack(spacing: 16) {
            Image(systemName: DesignConstants.Icons.error)
                .font(.system(size: 50))
                .foregroundColor(.orange)
            
            Text(AppStrings.Carousel.loadingError)
                .font(.headline)
            
            Text(AppStrings.Carousel.connectionError)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Button(AppStrings.Carousel.retryButtonTitle, action: viewModel.retryLoading)
                .buttonStyle(.borderedProminent)
        }
        .frame(width: 250, height: 250)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(16)
    }
    
    private var carouselContent: some View {
        GeometryReader { geometry in
            HStack(spacing: -60) {
                ForEach(Array(viewModel.items.enumerated()), id: \.element.id) { index, item in
                    let isCenter = index == viewModel.currentIndex
                    let scale = viewModel.calculateScale(for: index, screenWidth: geometry.size.width)
                    CarouselItemView(
                        item: item,
                        isCenter: isCenter,
                        scale: scale
                    )
                    .zIndex(isCenter ? 1.0: 0.0)
                    .onTapGesture {
                        viewModel.selectItem(at: index)
                    }
                }
            }
            .offset(x: viewModel.totalOffset)
            .gesture(
                DragGesture(minimumDistance: 15)
                    .onChanged { value in
                        viewModel.handleDragChanged(value: value)
                    }
                    .onEnded { value in
                        viewModel.handleDragEnded(value: value)
                    }
            )
        }
        .frame(height: 250)
        .clipped()
    }
    
    private var pageControl: some View {
        PageControlView(
            currentIndex: viewModel.currentIndex,
            totalCount: viewModel.items.count
        )
    }
}
