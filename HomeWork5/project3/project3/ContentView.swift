//
//  ContentView.swift
//  project3
//
//  Created by Денис Шакуров on 12.03.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
                NavigationLink(destination: TableView()) {
                    Text("Открыть таблицу")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .navigationBarTitle("Первый экран")
        }
    }
}

#Preview {
    ContentView()
}
