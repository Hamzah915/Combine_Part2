//
//  NetworkableProtocol.swift
//  CombineSwiftUI
//
//  Created by Hamzah Azam on 05/05/2023.
//

import Foundation
import Combine

protocol NetworkableProtocol {
    func getDataFromApi<T:Decodable>(url:URL, type: T.Type) -> AnyPublisher<T, Error>
}
