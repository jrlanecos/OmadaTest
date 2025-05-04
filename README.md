# OmadaTest
Omada Take Home Test

**Video Links**

- https://youtu.be/DM-22NDq42I // App demo
- [https://youtu.be/XmnqPBy_590 ](https://youtu.be/fBaM1BTs36k) // Coding session

**Overview**

This project is a lightweight SwiftUI app for browsing movies using a simple search interface. It presents a searchable list of movie results from The Movie Database (TMDb) and allows users to view detailed information about any selected movie.

**Unit tests**

1. Basic unit test validating decoding of the `Movie` object model
2. Basic UI test launching the app and typing in a search query.

**Features**

1. Movie search with dynamic results as you type
2. synchronous image loading using AsyncImage
3. Detail view with additional movie information
4. Simple loading/error/empty states
5. Clean, modular SwiftUI layout

The goal was to demonstrate clean architectural choices, **separation of concerns**, **thoughtful UI composition**, **and SwiftUI best practices**.

**Separation of concerns**

Hit the TMdb endpoint via a View Model object and have it manage the search results and pass them into the main SwiftUI interface. The View model also has a busy state, takes dynamic search bar input, and a dynamic error message field. The ViewModel uses the `.debounce` operator to slow down responding to the high-frequency keystroke events so that we won't excessively hit the API and **instead delay to every 5 seconds**.

**UI Composition**

Separate out the 2 SwiftUI Screens and the Movie List Row View. Use single argument initializers that accept the `Movie` data model. 

**Main design considerations**

1. MVVM Architecture with @StateObject ViewModel
The main ContentView owns a MoviesViewModel, marked as @StateObject to ensure proper lifecycle and memory management. This separates view logic (search state, no results handling, movie list) keeping the view clean and declarative.

2. SwiftUI NavigationStack & NavigationLink for Detail Routing
I used NavigationStack and NavigationLink to maintain a modern SwiftUI navigation approach that is future-proof and cleanly separates list and detail concerns.

3. Async Image Loading with Placeholder Fallbacks
Using SwiftUI's built-in AsyncImage simplifies remote image loading. I chose a basic `Rectangle().fill(.gray)` placeholder to visually indicate loading OR if there is no poster image present since it's nullable which is the case for a handful of the search results

4. Minimal Error Handling to Focus on Structure
For the purposes of this coding interview, I focused on building a solid, testable structure rather than exhaustive error and edge case handling (e.g., failed image loads, networking errors, pagination).

**Movie Model Design**

The Movie struct conforms to Identifiable for easy use in List. I included computed properties like posterUrlString, yearString, and ratingString to keep the UI clean and avoid repetitive logic in views.**This keeps parsing logic tightly coupled to the model, reducing view complexity and promoting single responsibility.**


**Potential Improvements (Given More Time)**

1. Add pagination support/infinite scrolling for large result sets (fetch the API more than once and increment page +=1)
2. Make search bar clear current search results
3. Add unit tests for the ViewModel
4. Lengthen the UI Test to actually tap a movie from the search result, go to the detail view, inspect the labels on both screens, etc.
5. Use dependency injection for network/data fetching to mock it in a unit test.
 
