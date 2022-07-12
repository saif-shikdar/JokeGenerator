//
//  JokeViewModel.swift
//  JokeApp
//
//  Created by Saif Shikdar on 12/07/2022.
//

import Foundation
import Combine

protocol JokeViewModelling {
    var jokeBinding: Published<Joke?>.Publisher { get }
    func getJoke()
}

class JokeViewModel {
    var subscriptions: Set<AnyCancellable> = []
    let repository: RepositoryService
    
    @Published var joke: Joke?
    
    var jokeBinding: Published<Joke?>.Publisher { $joke }
    
    init(repository: RepositoryService = Repository()) {
        self.repository = repository
    }
}

extension JokeViewModel: JokeViewModelling {
    func getJoke() {
        repository.fetchJoke(modelType: Joke.self)
            .receive(on: DispatchQueue.main).sink { [weak self] completion in
            }
                receiveValue : { [weak self] response in
                    self?.joke = response
                    print("Response is: \(response)")
                }.store(in: &subscriptions)
        
    }
}


