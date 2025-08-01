# Task 15: Implement Remote Data Source

## Overview

In this task, you will implement the **remote data source** for the Ecommerce app. The remote data source is responsible for fetching products from the backend API when the user is online. It acts as the primary source of truth for product data and handles network requests, response parsing, and error handling.

## Requirements

* Implement the `ProductRemoteDataSource` interface (contract).
* Use the provided API to fetch product data.
* Handle both successful responses and error states.
* Parse JSON responses into product model objects.
* Implement proper error handling by throwing exceptions on failure.

## API Reference

* **Base URL:** (Provide your actual base URL here, e.g., `https://api.yourdomain.com/products`)
* Endpoints for:

  * Getting product list
  * Getting product details (if applicable)

## Implementation Details

* Create a concrete class `ProductRemoteDataSourceImpl` that uses an HTTP client (e.g., `http` package) to make API calls.
* Implement methods to fetch data from the remote server.
* Include headers such as `'Content-Type': 'application/json'`.
* Return parsed `ProductModel` instances on success.
* Throw `ServerException` on any response with a status code other than 200.

## Testing

* Write unit tests for `ProductRemoteDataSourceImpl` using mocked HTTP clients.
* Test cases should include:

  * Verifying correct API endpoint URLs and headers are used.
  * Returning valid `ProductModel` objects on HTTP 200 responses.
  * Throwing `ServerException` on HTTP error responses (e.g., 404, 500).
* Use fixtures (static JSON files) to mock API responses in tests.

## How to Verify Completion

* The remote data source class is fully implemented with all required methods.
* Unit tests cover all success and failure scenarios.
* Tests pass successfully.
* Code is pushed to the repository branch for Task 15.

## References

* This implementation follows the TDD and Clean Architecture principles demonstrated in Reso Coder’s [Flutter TDD Clean Architecture Course](https://resocoder.com/2019/09/26/flutter-tdd-clean-architecture-course-8-local-data-source/).
* HTTP package: [https://pub.dev/packages/http](https://pub.dev/packages/http)

