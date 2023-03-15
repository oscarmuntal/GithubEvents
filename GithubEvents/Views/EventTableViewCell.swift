//
//  EventTableViewCell.swift
//  GithubEvents
//
//  Created by Òscar Muntal on 10/3/23.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    public var eventViewModel: EventViewModel!
    
    func configure(with viewModel: EventViewModel) {
        eventViewModel = viewModel
        avatarImage.setActorImage(with: URL(string: viewModel.event.actor.avatarUrl))
        avatarImage.rounded()
        loginLabel.text = viewModel.event.actor.name
        typeLabel.text = viewModel.event.type
        repoNameLabel.text = viewModel.event.repo.name
    }
}
