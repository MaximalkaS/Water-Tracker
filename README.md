# Water Tracker

Water Tracker is a SwiftUI iOS app for logging daily water intake, tracking hydration progress, and reviewing drinking history over time. The project is built as a local-first app with simple persistence, modular screens, and a custom tab-based interface.

## Features

- Daily water intake progress with a circular progress indicator
- Quick water logging with configurable portion sizes
- Hydration history grouped by date
- Swipe-to-delete history entries
- Weekly statistics chart
- Custom daily goal from 1500 ml to 5000 ml
- Configurable small, medium, and large drink volumes
- Automatic daily intake reset when a new day starts
- Local data persistence with Core Data and UserDefaults

## Screens

- Main: shows today's progress and opens the water logging flow
- Add Water: lets the user choose a drink size and add it to today's total
- Statistics: displays weekly progress and remaining water for today
- History: shows previous water entries grouped by day
- Settings: lets the user edit daily goal and portion volumes

## Tech Stack

- Swift
- SwiftUI
- MVVM
- Core Data
- UserDefaults
- Xcode asset catalogs
- Custom fonts

## Architecture

The project is organized into feature modules and shared core layers:

```text
Water Tracker
|-- App
|-- Core
|   |-- Extensions
|   |-- Mapper
|   |-- Models
|   |-- Persistence
|   |-- Storage
|   `-- UI
|-- Modules
|   |-- AddWater
|   |-- History
|   |-- Main
|   |-- Setting
|   |-- Statistics
|   `-- TabBar
`-- Resources
```

Each main feature follows a lightweight MVVM structure:

- View: SwiftUI screen layout and user interaction
- ViewModel: presentation logic and state
- Component: reusable UI pieces for the feature

Core Data stores water log entries, while UserDefaults stores lightweight user preferences such as daily goal, portion sizes, daily intake, and the last reset date.

## Requirements

- Xcode 16 or newer
- iOS 18.1 or newer

## Getting Started

1. Open `Water Tracker.xcodeproj` in Xcode.
2. Select the `Water Tracker` scheme.
3. Choose an iOS simulator or a physical device.
4. Build and run the app.

If Xcode reports a signing issue, select your development team in the project settings or update the bundle identifier.

## Notable Implementation Details

- `WaterStorage` handles the daily reset logic by comparing the saved last update date with the current day.
- `CoreDataManager` wraps basic create, fetch, and delete operations for water entries.
- `WeekWaterMapper` converts stored entries into weekly chart data.
- `HistoryViewModel` safely maps Core Data entries into plain UI models before rendering them.
- The tab bar is custom-built with SwiftUI instead of using the default `TabView`.

## Future Improvements

- Add unit tests for storage, mappers, and view models
- Add empty states for history and statistics
- Improve accessibility labels and Dynamic Type support
- Add screenshots or a short demo video to the README
- Add support for editing existing water entries
- Add notifications or reminders for drinking water
