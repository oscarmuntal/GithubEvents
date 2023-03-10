//
//  EventsTableViewController.swift
//  GithubEvents
//
//  Created by Òscar Muntal on 10/3/23.
//

import Foundation
import UIKit

class EventsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell else { fatalError("EventTableViewCell not found") }
        
        
        return cell
    }
}
