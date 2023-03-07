//
//  TimeStamp.swift
//  ExchangeRate
//
//  Created by Paul Ive on 27.02.23.
//

import Foundation

class TimeStamp {
    func lastUpdate(timeString: String?) -> (String) {
        guard var time = timeString else { return "Загрузка..." }
        let range = time.index(time.endIndex, offsetBy: -6)..<time.endIndex
        time.removeSubrange(range)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let lastUpdate = dateFormatter.date(from: time) else { return "Загрузка..." }
        dateFormatter.dateFormat = "dd.MM.yyyy HH:ss"
        let lastUpdateString = dateFormatter.string(from: lastUpdate)
        return "Послденее обновление: " + lastUpdateString
    }
}
