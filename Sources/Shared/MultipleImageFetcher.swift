import Foundation

// Fetch multiple images
public class MultipleImageFetcher {

  var fetchers: [ImageFetcher] = []

  /// Fetch multiple urls at once
  ///
  /// - Parameters:
  ///   - urls: The urls to fetch
  ///   - each: Called when each fetcher completes
  ///   - completion: Called when all fetcher completes
  public func fetch(urls: [URL],
                    each: ((Result) -> Void)? = nil,
                    completion: (([Result]) -> Void)? = nil) {
    var results: [Result] = []

    self.fetchers = urls.map { url in
      let fetcher = ImageFetcher()
      fetcher.fetch(url: url, completion: { result in
        each?(result)

        results.append(result)

        if results.count == urls.count {
          completion?(results)
        }
      })

      return fetcher
    }
  }
}
