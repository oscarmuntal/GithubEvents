//
//  EventViewModel.swift
//  GithubEvents
//
//  Created by Òscar Muntal on 10/3/23.
//

import UIKit
import RxSwift
import RxCocoa

protocol EventListViewModelContract {
    var events: [EventViewModelContract] { get }
    func eventAt(_ index: Int) -> EventViewModelContract
}

struct EventListViewModel: EventListViewModelContract {
    let events: [EventViewModelContract]
}

extension EventListViewModel {
    init(_ events: [Event]) {
        self.events = events.compactMap(EventViewModel.init)
    }
    
    func eventAt(_ index: Int) -> EventViewModelContract {
        events[index]
    }
}

protocol EventViewModelContract {
    var avatarURL: URL? { get }
    var actorName: String { get }
    var type: String { get }
    var repoName: String { get }
    var repoURL: URL? { get }
    var date: String { get }
}

struct EventViewModel: EventViewModelContract {
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
        self.date = event.date.simpleFormattedDate()
    }
}
