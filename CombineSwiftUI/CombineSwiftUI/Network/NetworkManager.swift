//
//  NetworkManager.swift
//  CombineSwiftUI
//
//  Created by Hamzah Azam on 05/05/2023.
//

import Foundation
import Combine

class NetworkManager:NetworkableProtocol{
    func getDataFromApi<T>(url: URL, type: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
        return URLSession.shared.dataTaskPublisher(for: url)
            .delay(for: .seconds(5.0), scheduler: DispatchQueue.main)
            .tryMap{ (data: Data, response: URLResponse) in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw NetworkErrorEnum.responseError
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
    
        

}
