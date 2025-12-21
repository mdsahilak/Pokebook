//
//  NetworkService.swift
//  Pokebook
//
//  Created by MD Sahil AK on 21/12/25.
//

import Foundation

protocol NetworkService {
    func data<T: Decodable>(from: URL?, decoding type: T.Type) async throws -> T
}
