//
//  ContentView.swift
//  FictionalNetworkingSample
//
//  Created by Joshua Erasmus on 2024/09/20.
//

import SwiftUI
import FictionalNetworking

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            ConcreteFictionalNetworking()
        }
    }
}

#Preview {
    ContentView()
}
