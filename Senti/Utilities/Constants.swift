//
//  Constants.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/4/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import Foundation

struct Constants {
    
    struct TwitterKit {
        static let consumerKey = "uxk3Zyejp3wybsmJmEXF6gcn4"
        static let consumerSecret = "wjgXSA9c8nRpKFnFfCHLaxM5wquB0c4ayeIWBGNB7Vg2ouwGj9"
        static let baseUrl = "https://api.twitter.com/1.1/statuses/user_timeline.json"
    }
    
    struct GoogleCloud {
        static let apiKey = "AIzaSyCWSV9hI7ILZKjqU7-ETwS1jobbsKVXsWs"
        static let baseUrl = "https://language.googleapis.com/v1/documents:analyzeSentiment?fields=documentSentiment&key=\(apiKey)"
    }
    
    struct Home {
        static let searchTextFieldPlaceholder = "@username"
        static let searchButtonTitle = "Search"
        static let message1 = "Sentiment analysis refers to the use of natural language processing, text analysis and computational linguistics to identify and extract subjective information in source materials."
        static let message2 = "Generally speaking, sentiment analysis aims to determine the attitude of a speaker or a writer with respect to some topic or the overall contextual polarity of a document."
        static let message3 = "The attitude may be his or her judgment or evaluation, affective state, or the intended emotional communication."
    }
    
    struct Tweets {
        static let title = "Tweets"
        static let emptyTitle = "Oh no!"
        static let emptySubtitle = "We couldn’t find the user you were looking for! Please, check the user name and try again."
    }
    
    struct Analysis {
        static let title = "Analysis"
        static let score = "Score"
        static let magnitude = "Magnitude"
    }
    
    struct Info {
        static let title = "Information"
        static let scoreTitle = "Score"
        static let magnitudeTitle = "Magnitude"
        static let scoreDescription = "Score of sentiment ranges from -1.0 (very negative) to 1.0 (very positive)."
        static let magnitudeDescription = "Magnitude is the strength of sentiment regardless of score, ranges from 0 to infinity."
        static let copyright = "Copyright © 2019 TouchBlue.Co\nAll rights reserved"
    }
    
    struct Accessibility {
        static let dismiss = "dismiss screen"
        static let backButton = "return to previous screen"
        static let search = "search for a twitter username"
        static let info = "more information about the analysis"
    }
    
    static func appVersion() -> String {
        guard let dictionary = Bundle.main.infoDictionary else { return "" }
        let version = dictionary["CFBundleShortVersionString"] as! String
        let build = dictionary["CFBundleVersion"] as! String
        return "\(version) (\(build))"
    }
}
