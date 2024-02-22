//
//  Extension-Url.swift
//  Fund India
//
//  Created by Monish M on 22/02/24.
//

import Foundation

extension URL {
    func valueOf(_ queryParameterName: String) -> String? {
        let components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        let queryItems = components?.queryItems
        return queryItems?.first(where: { $0.name == queryParameterName })?.value
    }
}
