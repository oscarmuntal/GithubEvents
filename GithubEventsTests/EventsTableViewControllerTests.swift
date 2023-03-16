//
//  EventsTableViewControllerTests.swift
//  GithubEventsTests
//
//  Created by Òscar Muntal on 16/3/23.
//

import XCTest
@testable import GithubEvents

class EventsTableViewControllerTest: XCTestCase {

    var sut: EventsTableViewController!
    var viewModelMock: EventListViewModelMock!

    override func setUp() {
        super.setUp()
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "EventsTableViewController") as? EventsTableViewController
        viewModelMock = eventListViewModelMock
        sut.eventListViewModel = viewModelMock
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        viewModelMock = nil
        super.tearDown()
    }

    func testTableView_hasDelegate() {
        XCTAssertNotNil(sut.tableView.delegate)
    }

    func testTableView_numberOfRows() {
        // Given
        let expectedCount = viewModelMock.events.count
        
        // When
        let actualCount = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        
        // Then
        XCTAssertEqual(actualCount, expectedCount)
    }

    func testTableView_didSelectRowAt() {
        // When
        sut.tableView.reloadData()
        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertNotNil(sut.eventSelected)
    }

    func testPrepareForSegue() {
        // Given
        let segue = UIStoryboardSegue(identifier: "toEventDetail", source: sut, destination: EventDetailViewController())
        sut.eventSelected = EventViewModelMock()
        
        // When
        sut.prepare(for: segue, sender: nil)
        
        // Then
        XCTAssertNotNil(sut.eventSelected)
        XCTAssertEqual(sut.eventSelected?.actorName, (segue.destination as! EventDetailViewController).event.actorName)
        XCTAssertEqual(sut.eventSelected?.repoName, (segue.destination as! EventDetailViewController).event.repoName)
    }
}

let actor = Actor(id: 0, name: "", avatarUrl: "")
let repo = Repo(id: 0, name: "", url: "")
let eventMock = Event(id: "", type: "", actor: actor, repo: repo, date: "")
let eventViewModelMock = EventViewModel(eventMock)
let eventListViewModelMock = EventListViewModelMock([eventViewModelMock])

class EventListViewModelMock: EventListViewModelContract {
    var events: [EventViewModelContract] = []
    var eventAtCalled = false
    
    init(_ events: [EventViewModelContract]) {
        self.events = events
    }
    
    func eventAt(_ index: Int) -> EventViewModelContract {
        self.eventAtCalled = true
        return events[index]
    }
}

class EventViewModelMock: EventViewModelContract {
    var avatarURL: URL?
    var actorName: String = ""
    var type: String = ""
    var repoName: String = ""
    var repoURL: URL?
    var date: String = ""
}

class EventTableViewCell: UITableViewCell {
    var configured = false
    var viewModel: EventViewModel!
    func configure(with viewModel: EventViewModel) {
        configured = true
        self.viewModel = viewModel
    }
}
