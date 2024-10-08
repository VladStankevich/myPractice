//
//  NetworkingError.swift
//  Networking
//
//  Created by Владислав Станкевич on 28.08.24.
//

import Foundation

enum NetworkingError: String, Error {
    case ivalidURL = "The URL address is invalid"
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidData = "The data received from the server was invalid. Please try again"
    case invalidResponse = "Invalid response from the server. Please try again"
}
