# Task 7: Implementing Navigation and Routing in an eCommerce Mobile App

This task focuses on integrating navigation and routing features into a Flutter-based eCommerce mobile application. The goal is to enable smooth navigation between screens, proper data passing, and handling of navigation events using Flutter best practices.

## Features Implemented

### 1. Screen Navigation
- The application includes the following screens:
  - Home Screen: Displays a list of all products.
  - Add/Edit Product Screen: Used to create a new product or modify an existing one.
  - Product Detail Screen: Displays full information of a selected product.
- Navigation between screens is implemented using Flutter’s built-in `Navigator`.

### 2. Named Routes
- Each screen is registered with a named route in a centralized routing configuration.
- Navigation is handled using `Navigator.pushNamed` and `Navigator.pop`.

### 3. Passing Data Between Screens
- When adding or editing a product, the user can input a title and description.
- Product data is passed between the Home screen and Add/Edit screens using route arguments or constructors, depending on the navigation direction.

### 4. Navigation Animations
- Smooth and default animations are used for transitions between screens.
- The app supports clean navigation animations for a more polished user experience.

### 5. Handling Navigation Events
- The back button behavior is managed properly using `Navigator.pop` to return to the Home screen from the Add/Edit Product screen.
- Other navigation events are handled as needed for consistent app flow.

## How to Run the App

### Prerequisites
- Flutter SDK installed (version 3.0 or higher recommended)
- A working IDE such as Android Studio or Visual Studio Code

### Steps
1. Clone the repository.
2. Run `flutter pub get` to fetch dependencies.
3. Run the application using `flutter run`.



## Evaluation Criteria

- Correct implementation of screen navigation, named routes, and data passing
- Proper handling of back navigation and navigation events
- Smooth navigation animations
- Clean code and adherence to Flutter best practices

## Notes

This implementation adheres to Clean Architecture where possible and maintains separation of concerns for UI, domain, and data layers.

