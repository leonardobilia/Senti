//
//  String+Ext.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/4/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import Foundation

extension String {
    
    func validateTwitterUsername() -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", "@[A-Za-z0-9_]{3,15}").evaluate(with: self)
    }
    
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM d HH:mm:ss Z yyyy"
        guard let date = dateFormatter.date(from: self) else { return "" }
        dateFormatter.dateFormat = "E, MMM d, yyyy HH:mm"
        dateFormatter.locale = Locale.current
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}
