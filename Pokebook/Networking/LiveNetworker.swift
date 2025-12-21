//
//  LiveNetworker.swift
//  Pokebook
//
//  Created by MD Sahil AK on 21/12/25.
//

import Foundation

final class LiveNetworker: NetworkService {
    func data<T>(from url: URL?, decoding type: T.Type) async throws -> T where T : Decodable {
        guard let url else { throw NetworkError.invalidURL }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(T.self, from: data)
    }
}
