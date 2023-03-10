//
//  EventsTableViewController.swift
//  GithubEvents
//
//  Created by Òscar Muntal on 10/3/23.
//

import Foundation
import UIKit
import RxSwift

class EventsTableViewController: UITableViewController {
    private let disposeBag = DisposeBag()
    private var eventListViewModel: EventListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        populateNews()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let eventListVM = eventListViewModel else { return 0 }
        return eventListVM.events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell else { fatalError("EventTableViewCell not found") }
        
        guard let eventVM = eventListViewModel?.eventAt(indexPath.row) else { return cell }
        
        eventVM.actorName.asDriver(onErrorJustReturn: "")
            .drive(cell.loginLabel.rx.text)
            .disposed(by: disposeBag)
        
        eventVM.eventType.asDriver(onErrorJustReturn: "")
            .drive(cell.typeLabel.rx.text)
            .disposed(by: disposeBag)
        
        eventVM.repoName.asDriver(onErrorJustReturn: "")
            .drive(cell.repoNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        return cell
    }
}

private extension EventsTableViewController {
    func populateNews() {
        guard let url = URL(string: "https://api.github.com/events") else { fatalError("URL doesn't work") }
        let resource = Resource<[Event]>(url: url)
        
        URLRequest.requestDecodable(resource: resource)
            .subscribe(onNext: { events in
                self.eventListViewModel = EventListViewModel(events)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }).disposed(by: disposeBag)
    }
}
