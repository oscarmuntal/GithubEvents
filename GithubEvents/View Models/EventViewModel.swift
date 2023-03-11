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
    let event: Event
    
    init(_ event: Event) {
        self.event = event
    }
}
