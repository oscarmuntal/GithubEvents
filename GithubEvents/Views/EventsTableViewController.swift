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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        populateNews()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell else { fatalError("EventTableViewCell not found") }
        
        
        return cell
    }
}

private extension EventsTableViewController {
    func populateNews() {
        guard let url = URL(string: "https://api.github.com/events") else { fatalError("URL doesn't work") }
        let resource = Resource<[Event]>(url: url)
        
        URLRequest.requestDecodable(resource: resource)
            .subscribe(onNext: { events in
                
                guard let first = events.first else { return }
                print(first.id)
                print(first.type)
                print(first.actor.name)
                print(first.actor.avatarUrl)
                print(first.repo.name)
                
            }).disposed(by: disposeBag)
    }
}
