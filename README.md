# Film

#### Goal
* Reflect upon decisions made on my last project [Films](https://github.com/christianampe/films-ios) (submitted in July of 2019) and make improvements on my findings.
* Be more pragmatic with my approach to solving problems in code.
* Spend less than 24 hours designing and implementing (18 hours spent in total)

#### Reflective findings when revisiting the previous project
* It was an overly complicated project which made the codebase extremely hard to navigate.
* The networking logic would make redundant calls whenever a cell came into view as there was no caching logic for `OMDB` calls.
* The procedural image loading on the cell was buggy due to improper delegate management.
* The nesting of collection views within table view cells was extremely heavy and resulted in good, but not great, scroll performance.

#### Improvements made over previous project
* Reduced lines of code from `3623` to `1633` (55% decrease).
    * Project migrated from using `Storyboard` to now being purely `programmatic`.
    * Adjusting for autolayout, setup, and styling code which was previously managed in Storyboards, the number of lines is further reduced to `1278` (65% decrease).
    * `$ find . \( -iname \*.swift \) -exec wc -l '{}' \+`
* `Sorting logic` has been replaced with a dynamic debounced search query which has a custom cache backing to avoid redundant filters.
* `Cell dequeuing` previously caused issues by not retaining scroll position offset which have since been fixed.
* The detail screen is more informative and slightly cleaner.
* Declared `subdomains` for `HTTP` payloads on the `nflx` and `omdb` endpoints as to not expose all traffic through the application.
* By utilizing `systemColors`, this new application supports both `light` and `dark` modes.

#### Cool discoveries
* `UICollectionViewCompositionalLayout` is awesome. I decided to take a swing at using this new API as it aligned nicely with the requirements with `Discover` screen design.
    * It only took 13 lines of code to implement the layout the collection view. Yes, really.
* `UICollectionViewDiffableDataSource` is another awesome addition to the SDK.
    * Snapshots avoid index out of bound errors and eliminate the need for data source lookups (typically).
    * Out of the box diffing - sign me up. Diffable data source is definitely a keeper.

#### Discussion
* `MVVM` design pattern utilized as `VIPER` became a bit overkill with an application of this size. 
* In-memory `cache` utilized at the service level to avoid reconstructing custom objects.
* Cache used to store searches to avoid re-indexing the entire response for duplicate queries. 

#### Potential improvements
* `Offline mode` - `Core Data` could have been utilized to persist data to the disk; however, due to time constraints I ended up not implementing this logic.
* `Better logging` - A custom logger could have come in extremely handy; however, considering the time frame I felt if was better if I omitted it.
* `Error handling` - Error handling is crucial to a great application; however, it is often the bulk of the development effort.  
    * Errors in this project were handled by placeholders and fake data.
