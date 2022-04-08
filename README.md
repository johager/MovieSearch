# MovieSearch

This is the fourth self-assessment project for the Devmountain iOS App Developer Bootcamp.

The app fetches movie data from the TMDB API (https://developers.themoviedb.org/3/getting-started/introduction) and presents the results in a table view.


Additions to the baseline project:

- The UI is created programmatically: Interface Builder isn't used.
- The API key is stored in a .plist file that is not included in the repo. A sample.plist file is included in the repo, but not the build target, and is copied to the required .plist file using a build phase _run script_ if it doesn't exist. (This approach is modeled after https://peterfriese.dev/posts/reading-api-keys-from-plist-files/.)
- The release date is presented.
- Sort results by title, release data, or rating.


### Technoloy

Swift, UIKit, URLSession
