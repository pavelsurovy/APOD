//
//  APODModel.swift
//  APOD
//
//  Created by Palino on 16/04/2022.
//

import Foundation

struct APODModel: Codable {
    let copyright: String?
    let date: String
    let explanation: String
    let url: String?
    let title: String?
}
