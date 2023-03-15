//
//  EventDetailViewController.swift
//  GithubEvents
//
//  Created by Òscar Muntal on 15/3/23.
//

import UIKit
import RxSwift

class EventDetailViewController: UIViewController {
    var event: EventViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        title = event.event.actor.name
    }
    
    
}
