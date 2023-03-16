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
    
    
    public var eventViewModel: EventViewModelContract!
    
    func configure(with viewModel: EventViewModelContract) {
        eventViewModel = viewModel
        avatarImage.setActorImage(with: viewModel.avatarURL)
        avatarImage.rounded()
        loginLabel.text = viewModel.actorName
        typeLabel.text = viewModel.type
        repoNameLabel.text = viewModel.repoName
    }
}
