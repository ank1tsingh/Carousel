//
//  ContentView.swift
//  Carousel
//
//  Created by Ankit on 02/08/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            CarouselView()
            Text("Carousel")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .background(Color(.systemBackground))
    }
}

#Preview {
    ContentView()
}
