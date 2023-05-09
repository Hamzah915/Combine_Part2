//
//  FakeNetworkManager.swift
//  CombineSwiftUITests
//
//  Created by Hamzah Azam on 05/05/2023.
//

import Foundation
import Combine
@testable import CombineSwiftUI

class FakeNetworkManager:NetworkableProtocol{
    func getDataFromApi<T>(url: URL, type: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
        do{
            let bundle = Bundle(for: FakeNetworkManager.self)
            guard let path = bundle.url(forResource: url.absoluteString, withExtension: "json") else{
                return Fail(error:NetworkErrorEnum.invalidUrlError).eraseToAnyPublisher()
            }
            
            let data = try Data(contentsOf: url)
            let planetsList = try JSONDecoder().decode(T.self, from: data)
            return Just(planetsList)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }catch{
            return Fail(error: NetworkErrorEnum.dataNotFoundError)
                .eraseToAnyPublisher()
        }
        
    }
    
}
    
