//
//  Title.swift
//  The Next View
//
//  Created by UTF LABS on 25/11/2025.
//

import Foundation

struct APIObject: Decodable {
    var results: [Title] = []
}

struct Title: Decodable, Identifiable , Hashable{
    var id: Int
    var title: String?
    var name: String?
    var overview: String?
    var poster_path: String?
    var release_date: String?

    static var previewTitles = [

        Title(
            id: 1,
            title: "BeetleJuice",
            name: "BeetleJuice",
            overview:
                "A young couple teams up with a ghostly prospector to rid their home of a swarm of bloodsucking insects.",
            poster_path: ImageConstants.testTitleURL,
        ),
        Title(
            id: 2,
            title: "Pulp Fiction",
            name: "Pulp Fiction",
            overview:"A movie about Pulp Fiction",
            poster_path: ImageConstants.testTitleURL2,
        ),
        Title(
            id: 3,
            title: "The Dark Knight",
            name: "The Dark Knight",
            overview:"A movie about The Dark Knight",
            poster_path: ImageConstants.testTitleURL3,
        )


    ]
}
