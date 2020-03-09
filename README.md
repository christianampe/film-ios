# Film

#### Goal
* Reflect upon decisions made on my last project [Films] (https://github.com/christianampe/films-ios) (submitted in July of 2019) and make improvements on my findings.

#### Reflective Findings
* Was an overly complicated project which made the codebase extremely hard to navigate.

#### Improvements
* Reduced lines of code from 3623 to 1595 (56% decrease).
    * Project migrated from using storyboard to now being purely programmatic.
    * Adjusting for autolayout and setup code which was previously managed in Storyboards, the number of lines is further reduced to 1278 (65% decrease).

#### Discussion
* `VIPER`/`MVVM` hybrid design pattern utilized in the home screen.
* Custom `in-memory cache` - `CRAMemoryCache` which supports `structs`.
* Custom `networking` impelementation mimics `Moya` in terms of public API.
* An in-memory cache lives on the `2nd level` of the networking layer and caches the constructed `https` result objects.
* By default `Apple's` implementation of `URLSession` contains a `URLCache` which is internally managed by the caching policy returned from the server. This cache will also persist to disk which is the reason for my omitting a `disk cache` implementation. Assuming a correctly developed `REST API` returning proper header values, `Apple's` `URLCache` will appropriately manage the storing and purging of data.
* `HTTP` vs `HTTPS` - Both endpoints provided were non-secure with required the allowance of `arbitrary loads` in the `Xcode` project settings. This is extremely unsafe as it exposes all traffic running through the app; however, as this is a non-production application I opted for allowing it. The other option is to set custom `subdomain` exceptions which could be an improvement on my implementation.

#### Known Issues
* `Cell dequeueing` - In the home screen cell dequeueing causes issues where the embedded collection view looses track of its scroll position when it gets reused.

#### Improvements
* `Better logging` - a custom logger could have come in extremely handy; however, considering the time frame I felt if was better if I omitted it.
* `Error handling` - error handling is crucial to a great application; however, it is often the bulk of the development effort.  Errors in this project were handled by placeholders and fake data.
* `Detail screen` - 95% of my effort went into the home screen and the functionality involved with its features. Given more time I would have thought more about what information to provide the user and cleaned up the interface a bit.
* `Sorting logic` - There is a lot of redundant code here.  The way the filters are applied is extremely static meaning that on the server-side, nothing can be done to add or remove filters and the applied behavior to the data. This boils down to the endpoints and how they are provided. Ideally you could request data from the server with a different filter parameter and receive already-filtered data to populate the collection with; however, with the provided static file, this was not a luxury that was able to be had. Filtering on-device was necessary so it required a less-than-ideal impelementation here.
