//
//  PageControlView.swift
//  Carousel
//
//  Created by Ankit on 02/08/25.
//

import SwiftUI

struct PageControlView: View {
    let currentIndex: Int
    let totalCount: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalCount, id: \.self) { index in
                Circle()
                    .fill(index == currentIndex ? Color.blue : Color.gray.opacity(0.4))
                    .frame(width: 8, height: 8)
                    .scaleEffect(index == currentIndex ? 1.2 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.8), value: currentIndex)
            }
        }
        .padding(.top, 20)
    }
}

// MARK: - Preview Provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
