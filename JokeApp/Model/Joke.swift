//
//  Joke.swift
//  JokeApp
//
//  Created by Saif Shikdar on 12/07/2022.
//

import Foundation

// MARK: - Joke
struct Joke: Codable {
    var error: Bool
    var category, type, setup, delivery: String
    var flags: Flags
    var id: Int
    var safe: Bool
    var lang: String
}

// MARK: - Flags
struct Flags: Codable {
    var nsfw, religious, political, racist: Bool
    var sexist, explicit: Bool
}
