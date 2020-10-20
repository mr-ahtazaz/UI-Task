//
//  AKError.swift
//  Knipklok_v1
//
//  Created by Ahtazaz on 02/07/2020.
//  Copyright © 2020 SD. All rights reserved.
//

import Foundation


enum AKError: String, Error {
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again"
}
