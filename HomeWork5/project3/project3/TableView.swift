//
//  TableView.swift
//  project3
//
//  Created by Денис Шакуров on 12.03.2024.
//

import SwiftUI

struct TableView: View {
    @State private var networkService = NetworkService()
    @State private var items: [News] = []
    
    var body: some View {
        List {
            ForEach(items, id: \.publicationDate) { item in
                HStack {
                    Text(formatDateFromDouble(date: item.publicationDate))
                    Divider()
                    Text(item.title)
                }
            }
        }
        .onAppear {
            networkService.getNews { news in
                self.items = news
            }
        }
        .navigationBarTitle("Таблица")
    }
    private func formatDateFromDouble(date: Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let convertedDate = Date(timeIntervalSince1970: date)
        return dateFormatter.string(from: convertedDate) 
    }
}

#Preview {
    TableView()
}
