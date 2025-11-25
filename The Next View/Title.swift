//
//  Title.swift
//  The Next View
//
//  Created by UTF LABS on 25/11/2025.
//

import Foundation


struct APIObject: Decodable {
    var results: [Title]=[]
}

struct Title: Decodable, Identifiable {
    var id: String?
    var title: String?
    var name: String?
    var overview: String?
    var poster_path: String?
    var release_date: String?

}
