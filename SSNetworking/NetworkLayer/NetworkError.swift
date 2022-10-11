//
//  NetworkError.swift
//  SPlayer
//
//  Created by Santosh Sahoo on 07/10/22.
//

import Foundation

public enum NetworkError: Error {
    case noInternet
    case noData
    case parsingError(Error)
    case invalidUrl
    case apiError(Error)
}
