//
//  ContentView.swift
//  JokeApp
//
//  Created by Saif Shikdar on 12/07/2022.
//

import SwiftUI

struct ContentView: View {
    
    var jokeViewModel: JokeViewModel
    
    var body: some View {
        VStack {
            Text(jokeViewModel.joke?.setup ?? "")
                .bold()
                .padding()
            Text(jokeViewModel.joke?.delivery ?? "")
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var jokeViewModel: JokeViewModel {
        let vm = JokeViewModel()
        vm.joke?.setup = "What happens when you don't obey the KGB?"
        vm.joke?.delivery = "You get Putin jail."
        return vm
    }
    
    static var previews: some View {
        ContentView(jokeViewModel: jokeViewModel)
    }
}
