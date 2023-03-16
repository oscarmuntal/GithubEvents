//
//  RepoDetailViewModel.swift
//  GithubEvents
//
//  Created by Òscar Muntal on 16/3/23.
//

import Foundation

struct RepoDetailViewModel {
    let repoDetail: RepoDetail
}

extension RepoDetailViewModel {
    init(_ repo: RepoDetail) {
        self.repoDetail = repo
    }
}

struct RepoDetail: Decodable {
    let htmlURL: String
    let gitURL: String
    let description: String
    
    private enum CodingKeys: String, CodingKey {
        case htmlURL = "html_url"
        case gitURL = "git_url"
        case description
    }
}

extension RepoDetail {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        htmlURL = try values.decode(String.self, forKey: .htmlURL)
        gitURL = try values.decode(String.self, forKey: .gitURL)
        description = try values.decode(String.self, forKey: .description)
    }
}
