# iOS Carousel Assignment

A smooth, interactive image carousel built with SwiftUI

## Demo
<div align="center">
  <img src="https://github.com/user-attachments/assets/e4c50251-7be0-4772-8d8d-b1d357e67fa1" alt="Carousel Demo" width="300">
</div>
<p align="center"><em>Carousel Animation</em></p>


## What I Built

This is a destination carousel app that lets users swipe through different travel destinations. The main focus was creating a really smooth user experience with proper animations and responsive gestures.

## Architecture Decisions

I went with **MVVM (Model-View-ViewModel)** instead of more complex patterns like Clean Architecture with use cases and multiple protocol layers. Here's why:

- **Simplicity**: For a carousel component, MVVM gives us clean separation without over-engineering
- **SwiftUI-friendly**: MVVM works naturally with SwiftUI's reactive data binding
- **Testable**: Still easy to test business logic by separating it into services
- **Maintainable**: Clear responsibility separation without too many abstraction layers

I did use protocols for the services (DataService and CalculationService) to keep things testable, but kept the overall architecture focused and practical.

## Key Features

- **Smooth drag gestures** - Works just like the native iOS photo gallery
- **Smart pagination** - Automatically snaps to the nearest item based on drag distance and velocity
- **Scaling animations** - Items scale up/down as they move to center
- **Loading states** - Shows skeleton loaders while fetching data
- **Error handling** - Proper error states with retry functionality
- **Responsive design** - Works across different screen sizes

## Tech Stack

- **SwiftUI** - For the UI and animations
- **Async/await** - For data loading
- **Combine** - For reactive state management (@Published properties)
- **GeometryReader** - For responsive positioning
- **AsyncImage** - For image loading with fallbacks


## How to Run

1. Open the `.xcodeproj` file in Xcode
2. Select your target device/simulator
3. Hit `⌘ + R` to run

That's it! No external dependencies or setup needed.

## Implementation Notes

- **Drag calculations**: Used velocity and distance thresholds to determine when to snap to next/previous item
- **Animations**: Used SwiftUI's spring animations for natural feel
- **Performance**: Images are loaded asynchronously with placeholder fallbacks
- **Error states**: Graceful handling of network failures with retry options

## What I'd Add Next

If I had more time, I'd probably add:
- Unit tests for the calculation service
- Image caching for better performance
- Haptic feedback on item selection

---
