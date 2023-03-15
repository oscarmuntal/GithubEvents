//
//  EventsTableViewController.swift
//  GithubEvents
//
//  Created by Òscar Muntal on 10/3/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

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
        
        cell.configure(with: eventVM)
        return cell
    }
    
    var eventSelected: EventViewModel?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        guard let currentCell = tableView.cellForRow(at: indexPath)! as? EventTableViewCell else { return }
        
        eventSelected = currentCell.eventViewModel
        performSegue(withIdentifier: "toEventDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toEventDetail",
              let eventDetailVC = segue.destination as? EventDetailViewController,
              let eventSelected = eventSelected else { fatalError("EventDetailViewController not found") }
        
        eventDetailVC.event = eventSelected
    }
}

private extension EventsTableViewController {
    func populateNews() {
        guard let url = URL(string: "https://api.github.com/events") else { fatalError("URL doesn't work") }
        let resource = Resource<[Event]>(url: url)
        
        URLRequest.requestDecodable(resource: resource)
            .subscribe(onNext: { [weak self] events in
                self?.eventListViewModel = EventListViewModel(events)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }).disposed(by: disposeBag)
    }
}
