
# Wikipedia – Places Deep Link Assignment


## Overview

The goal of the assignment was to modify the Wikipedia iOS app so that it can be opened from another app and display a specific location on the **Places** tab based on provided coordinates.
A simple SwiftUI test app was created to fetch and display a list of locations. Tapping on a location, opens the Wikipedia app using the new deep link.

## Project Structure

The project is divided into several Swift packages to maintain clear separation of concerns.

Network package:

Provides a generic and reusable network layer for making API requests.
The intention is to isolate networking logic so that different parts of the app can fetch data without depending on implementation details.

DataProvider package:

Contains repository responsible for fetching and providing data.
The intention is to centralize data access and separate it from view and business logic, making the codebase easier to maintain and test.

Utils package:

Encapsulates the deep link logic and handles communication with the Wikipedia app.
The intention is to keep the deep link handling independent and reusable across different contexts or features.

## Modified Wikipedia App

Repository: forked version of [wikipedia-ios](https://github.com/wikimedia/wikipedia-ios)
Reviewers must switch to 'places' branch to see the changes.

https://github.com/onurkara/wikipedia-ios/tree/places

Changes made:

* Implemented deep link handling logic.
* Added support for URLs like `wikipedia://places?lat=52.3791&lon=4.8994`.
* Modified the Places tab to open automatically and center the map on the provided coordinates instead of the current location.
* If the provided coordinates are invalid or cannot be parsed, an alert is displayed to the user.

## Test App

Features:

* Fetches a list of places from
  `https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json`
* Displays the fetched places in a list.
* Opens the Wikipedia app at the selected place.
* If the location validation for the deep link fails, an alert is shown to the user.

## Unit Tests

Unit tests are implemented using Swift Testing.
They cover:

* Network layer functionality.
* Data repository logic.
* Deep link creation and validation.


## Notes

* The work was done locally using git.
* The modified Wikipedia app is located on the `places` branch. Reviewers need to switch to this branch to see the changes.
