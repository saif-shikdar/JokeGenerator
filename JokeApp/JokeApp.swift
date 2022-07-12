//
//  JokeApp.swift
//  Joke
//
//  Created by Saif Shikdar on 12/07/2022.
//

import SwiftUI

@main
struct JokeApp: App {
    
    var jokeViewModel: JokeViewModel {
        let vm = JokeViewModel()
        vm.getJoke()
        return vm
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(jokeViewModel: jokeViewModel)
        }
    }
}
