### Task 13: Implement Network Connectivity Detection

This task enhances the eCommerce mobile app with network connectivity awareness by introducing a `NetworkInfo` utility. This allows the app to check internet status before performing remote operations, improving reliability and user experience.

#### 🔌 What Was Implemented:

* **NetworkInfo Abstraction**
  A new abstract class `NetworkInfo` was created in `network_info.dart`. It defines a single property:

  ```dart
  abstract class NetworkInfo {
    Future<bool> get isConnected;
  }
  ```

  This ensures a clear contract for checking connectivity regardless of the implementation.

* **NetworkInfoImpl Implementation**
  The `NetworkInfoImpl` class provides the actual implementation of the `NetworkInfo` interface. It uses the [`internet_connection_checker`](https://pub.dev/packages/internet_connection_checker) package to determine whether the device has an active internet connection:

  ```dart
  class NetworkInfoImpl implements NetworkInfo {
    final InternetConnectionChecker connectionChecker;

    NetworkInfoImpl(this.connectionChecker);

    @override
    Future<bool> get isConnected => connectionChecker.hasConnection;
  }
  ```

* **Repository Integration**
  The `NetworkInfo` instance was injected into the repository via the constructor. The repository now checks for internet connectivity using `networkInfo.isConnected` before making API calls (e.g., fetching products). This ensures that operations requiring network access are only attempted when connectivity is available.

* **Offline Handling**
  In case of no network connection, the repository gracefully handles the scenario by returning a relevant failure or exception. This prevents the app from crashing and allows the UI to respond appropriately (e.g., showing an error message or offline indicator).

---