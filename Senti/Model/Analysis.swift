//
//  Analysis.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/6/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import Foundation

struct SentimentAnalysis: Decodable {
    let documentSentiment: DocumentSentiment
}

struct DocumentSentiment: Decodable {
    let magnitude, score: Double
}

