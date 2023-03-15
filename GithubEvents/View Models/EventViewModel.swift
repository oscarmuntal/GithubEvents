//
//  EventViewModel.swift
//  GithubEvents
//
//  Created by Òscar Muntal on 10/3/23.
//

import UIKit
import RxSwift
import RxCocoa

struct EventListViewModel {
    let events: [EventViewModel]
}

extension EventListViewModel {
    init(_ events: [Event]) {
        self.events = events.compactMap(EventViewModel.init)
    }
}

extension EventListViewModel {
    func eventAt(_ index: Int) -> EventViewModel {
        events[index]
    }
}

struct EventViewModel {
    let avatarURL: URL?
    let actorName: String
    let type: String
    let repoName: String
    let repoURL: URL?
    let date: String
    
    init(_ event: Event) {
        avatarURL = URL(string: event.actor.avatarUrl)
        actorName = event.actor.name
        type = event.type
        repoName = event.repo.name
        repoURL = URL(string: event.repo.url)
        date = event.date
    }
}
