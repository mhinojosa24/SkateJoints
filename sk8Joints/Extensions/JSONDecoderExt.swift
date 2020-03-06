//
//  JSONDecoderExt.swift
//  TonikAnalytics
//
//  Created by Student Loaner 3 on 10/24/19.
//  Copyright © 2019 HazeWritesCode. All rights reserved.
//

import Foundation

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, withJSONObject object: Any, options opt: JSONSerialization.WritingOptions = []) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: object, options: opt)
        return try decode(T.self, from: data)
    }
}
