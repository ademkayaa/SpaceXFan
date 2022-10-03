//
//  JsonUtils.swift
//  SpaceXFan
//
//  Created by Adem Kaya 
//

import Foundation

class JsonUtils {

    static let shared = JsonUtils()

    func encodeData<T: Encodable>(from data: T) -> String {
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(data)
            guard let jsonString = String(data: jsonData, encoding: .utf8) else {
                return ""
            }
            return jsonString
        } catch {
            print(error)
        }
        return ""
    }

    func decodeFrom<T: Decodable>(string data: String) -> T? {

        guard let strData = data.data(using: .utf8) else {
            print("DecodeFrom string")
            return nil
        }

        do {
            let decoded = try JSONDecoder().decode(T.self, from: strData)
            return decoded
        } catch {
            print("DecodeFrom string:  \(error)")
            return nil
        }
    }

    func decodeFrom<T: Decodable>(dictinary data: [String: Any]) -> T? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
            guard let decoded = String(data: jsonData, encoding: .utf8) else {
                print("DecodeFrom dictinary")
                return nil
            }
            return decodeFrom(string: decoded)
        } catch {
            print("DecodeFrom dictinary:  \(error)")
            return nil
        }
    }
}
