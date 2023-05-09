//
//  NetworkErrorEnum.swift
//  CombineSwiftUI
//
//  Created by Hamzah Azam on 05/05/2023.
//

import Foundation

enum NetworkErrorEnum :String{
    case dataNotFoundError
    case parsingError
    case invalidUrlError
    case responseError
}

extension NetworkErrorEnum : LocalizedError {
    var errorDescription: String? {
        switch self {
            
        case .dataNotFoundError:return NSLocalizedString("API Failed to give data", comment: NetworkErrorEnum.dataNotFoundError.rawValue)
        case .parsingError: return NSLocalizedString("Failed to parse API", comment: NetworkErrorEnum.parsingError.rawValue)
        case .invalidUrlError: return NSLocalizedString("Invalid URL", comment: NetworkErrorEnum.invalidUrlError.rawValue)
        case .responseError: return NSLocalizedString("Invalid response from API", comment: NetworkErrorEnum.responseError.rawValue)
        }
    }
}
