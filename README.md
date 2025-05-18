
# Quizzy - Flutter Quiz App

A modern, clean, and user-friendly quiz application built with Flutter.

## Features

- Clean and modern UI with support for both light and dark themes
- User authentication via username
- Multiple quiz categories
- Score tracking and results page
- Responsive design for various screen sizes

## Project Structure

The project follows a modular architecture:

- `lib/`
  - `constants/` - App-wide constants and configurations
  - `models/` - Data models
  - `Screens/` - UI screens
  - `theme/` - App theme configuration
  - `utils/` - Utility functions

## Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Dart SDK
- Android Studio / VSCode with Flutter plugins

### Installation

1. Clone this repository:

   ```
   git clone https://github.com/yourusername/quizz_app.git
   ```

2. Navigate to the project directory:

   ```
   cd quizz_app
   ```

3. Get dependencies:

   ```
   flutter pub get
   ```

4. Run the app:
   ```
   flutter run
   ```

## Best Practices Implemented

- Consistent theming with ThemeData
- Extracted styles and constants
- Form validation
- Proper state management
- Responsive design
- Code organization
- Null safety implementation

## Future Improvements

- Add actual quiz questions and answers
- Implement user authentication with Firebase
- Add more categories and difficulty levels
- Save quiz history
- Implement online leaderboard
