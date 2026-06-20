//
//  ContractsAll.swift
//  Learning
//
//  Created by vasantha_m on 27/04/26.
//


import SwiftUI

class JSONRepository {

    static let shared = JSONRepository()

    private var cache: AppData?

    private init() {}

    func loadAppData() -> AppData {

        if let cache {
            return cache
        }

        guard let url = Bundle.main.url(forResource: "appData", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode(AppData.self, from: data)
        else {
            fatalError("❌ Failed to load appData.json")
        }

        cache = decoded
        return decoded
    }

}
