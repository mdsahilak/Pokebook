//
//  APIRouter.swift
//  Pokebook
//
//  Created by MD Sahil AK on 21/12/25.
//

import Foundation

// MARK: Live Implementation
final class APIRouter {
    func data<T: Decodable>(from url: URL?, decoding type: T.Type) async throws -> T {
        guard let url else { throw APIError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        print(url)
        print(response)
        print(String(data: data, encoding: .utf8))
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(T.self, from: data)
    }
}
