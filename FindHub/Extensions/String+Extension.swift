//
//  Date+Extension.swift
//  FindHub
//
//  Created by Caio Alcântara on 04/04/21.
//

import Foundation

extension String {
    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ssZ")-> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date
    }
    
    func setLanguageColor() -> String {
        guard let langColors = loadJson(fileName: "github-colors") else { return ""}
        
        let selectedColor = langColors.filter({ $0.name == self }).first
        
        return selectedColor?.color ?? ""
    }
    
    private func loadJson(fileName: String) -> [GitHubColors]? {
        let decoder = JSONDecoder()
        guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let colors = try? decoder.decode([GitHubColors].self, from: data)
        else {
            return nil
        }
        return colors
    }
}
