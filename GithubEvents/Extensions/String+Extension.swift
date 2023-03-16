//
//  String+Extension.swift
//  GithubEvents
//
//  Created by Òscar Muntal on 15/3/23.
//

import Foundation

extension String {
    func simpleFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: self) else { return "" }
        
        let dateformat = DateFormatter()
        dateformat.dateFormat = "dd-MM-yyyy"
        return dateformat.string(from: date)
    }
}
