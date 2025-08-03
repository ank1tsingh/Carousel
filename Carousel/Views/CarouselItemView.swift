//
//  CarouselItemView.swift
//  Carousel
//
//  Created by Ankit on 02/08/25.
//

import SwiftUI

struct CarouselItemView: View {
    let item: CarouselItem
    let isCenter: Bool
    let scale: CGFloat
    
    var body: some View {
        VStack(spacing: 12) {
            imageView
                .scaleEffect(scale)
            itemInfo
                .opacity(isCenter ? 1.0 : 0.7)
        }
        .frame(width: 250)
    }
    
    private var imageView: some View {
        AsyncImage(url: URL(string: item.imageURL ?? "")) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            placeholderView
        }
        .frame(width: DesignConstants.Carousel.itemWidth, height: DesignConstants.Carousel.itemHeight)
        .clipShape(RoundedRectangle(cornerRadius: DesignConstants.Carousel.cornerRadius))
    }
    
    private var placeholderView: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(gradientForCountry)
            .overlay(
                VStack(spacing: 8) {
                    Image(systemName: iconForCountry)
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                    
                    Text(item.title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            )
    }
    
    private var itemInfo: some View {
        VStack(spacing: 4) {
            Text(item.subtitle)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack(spacing: 4) {
                Image(systemName: DesignConstants.Icons.clock)
                    .foregroundColor(.green)
                Text(item.processingTime)
                    .font(.caption)
                    .foregroundColor(.green)
            }
        }
    }
    
    private var gradientForCountry: LinearGradient {
        LinearGradient(
            colors: colorsForTitle,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    private var colorsForTitle: [Color] {
        switch item.title.lowercased() {
        case "malaysia": return [.red.opacity(0.7), .yellow.opacity(0.7)]
        case "singapore": return [.red.opacity(0.7), .blue.opacity(0.7)]
        case "thailand": return [.blue.opacity(0.7), .red.opacity(0.7)]
        case "vietnam": return [.red.opacity(0.7), .green.opacity(0.7)]
        case "philippines": return [.blue.opacity(0.7), .yellow.opacity(0.7)]
        default: return [.blue.opacity(0.7), .purple.opacity(0.7)]
        }
    }
    
    private var iconForCountry: String {
        switch item.title.lowercased() {
        case "malaysia": return  DesignConstants.Icons.malaysia
        case "singapore": return DesignConstants.Icons.singapore
        case "thailand": return DesignConstants.Icons.thailand
        case "vietnam": return  DesignConstants.Icons.vietnam
        case "philippines": return DesignConstants.Icons.philippines
        default: return DesignConstants.Icons.defaultIcon
        }
    }
}
