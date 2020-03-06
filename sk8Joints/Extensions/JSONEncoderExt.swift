//
//  JSONEncoderExt.swift
//  TonikAnalytics
//
//  Created by Student Loaner 3 on 10/24/19.
//  Copyright © 2019 HazeWritesCode. All rights reserved.
//

import Foundation

extension JSONEncoder {
    func encodeJSONObject<T: Encodable>(_ value: T, options opt: JSONSerialization.ReadingOptions = []) throws -> Any {
        let data = try encode(value)
        return try JSONSerialization.jsonObject(with: data, options: opt)
    }
}
