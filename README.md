# RealTimePriceTracker
Real-time stock feed app using WebSocket echo simulation. Generates live price updates for 25 symbols every 2 seconds, displays sorted prices with change indicators, connection status, and detailed symbol view.

<img width="200" height="500" alt="IMG_0186" src="https://github.com/user-attachments/assets/b34b830f-8c41-4783-a9bb-24f6064c44c8" /> <img width="200" height="500" alt="IMG_0187" src="https://github.com/user-attachments/assets/a896a4a3-4f88-4315-a189-a2403b87ad74" />
<img width="200" height="500" alt="IMG_0184" src="https://github.com/user-attachments/assets/bc5b6b64-d431-4b9c-aee5-b5433cd8a9da" />
<img width="200" height="500" alt="IMG_0184 2" src="https://github.com/user-attachments/assets/073b50b5-ec3d-4395-9a24-4d91ff296163" />


The goal was to demonstrate:

* WebSocket handling
* Clean architecture
* MVVM
* Real-time UI updates
* Testability

The app connects to a WebSocket echo server and simulates stock price updates every 2 seconds.

## Development Environment

* Xcode 15.4
* Swift 5
* iOS 16+
* SwiftUI
* Combine

## Architecture Overview

I used Clean Architecture principles to keep the project structured and testable.

The project is separated into:

**Domain**

* Stock entity
* PriceTick model
* Repository protocol
* Start / Stop use cases

**Data**

* URLSessionWebSocketClient
* WebSocketPriceStreamingRepository
* Random price generator
* JSON coder

**Presentation**

* FeedViewModel
* DetailViewModel
* SwiftUI views
* UI mapping for ConnectionState

**App Layer**

* AppContainer for dependency injection
* Deep link handling
* Navigation setup

## Architectural Decisions

* Only one shared WebSocket connection is created through AppContainer.
* ViewModels depend only on protocols.
* All state updates happen inside ViewModels.
* SwiftUI views are passive and only render state.
* Sorting logic is handled inside FeedViewModel.
* UI-specific formatting (colors, icons) is separated from domain logic.

## Features Implemented

* 25 predefined stock symbols
* WebSocket connection to:
  wss://ws.postman-echo.com/raw
* Random price updates every 2 seconds
* Real-time UI updates
* Sorting by price (descending)
* Start / Stop streaming
* Connection state indicator
* Detail screen updates in real time
* Flash animation on price change
* Light and Dark mode support
* Deep link support
* Unit tests for FeedViewModel

## Deep Link

iOS reserves `stocks://` for Apple Stocks app.

The parser supports it, but for testing purposes I also added:

`pricetracker://symbol/{symbol}`

Example:

`pricetracker://symbol/AAPL`

## Unit Testing

I focused on testing the ViewModel layer:

* Start / Stop behavior
* Tick updates
* Sorting logic
* Connection state updates


## Final Notes

This project focuses on structure, testability, and clarity.

