//
//  EventDetailViewController.swift
//  GithubEvents
//
//  Created by Òscar Muntal on 15/3/23.
//

import UIKit
import RxSwift

class EventDetailViewController: UIViewController {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var htmlUrlLabel: UILabel!
    @IBOutlet weak var gitUrlLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var event: EventViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        title = event.actorName
        
        avatarImage.setActorImage(with: event.avatarURL)
        typeLabel.text = event.type
        repoName.text = event.repoName
        dateLabel.text = event.date
        populateRepoData()
    }
}

private extension EventDetailViewController {
    func populateRepoData() {
        guard let url = event.repoURL else { fatalError("URL doesn't work") }
        let resource = Resource<RepoDetail>(url: url)
        
        URLRequest.requestDecodable(resource: resource)
            .subscribe(onNext: { [weak self] repo in
                let repoVM = RepoDetailViewModel(repo)
                
                DispatchQueue.main.async {
                    self?.htmlUrlLabel.text = repoVM.repoDetail.htmlURL
                    self?.gitUrlLabel.text = repoVM.repoDetail.gitURL
                    self?.descriptionLabel.text = repoVM.repoDetail.description
                }
            }).disposed(by: disposeBag)
    }
}

struct RepoDetailViewModel {
    let repoDetail: RepoDetail
}

extension RepoDetailViewModel {
    init(_ repo: RepoDetail) {
        self.repoDetail = repo
    }
}

struct RepoDetail: Decodable {
    let htmlURL: String
    let gitURL: String
    let description: String
    
    private enum CodingKeys: String, CodingKey {
        case htmlURL = "html_url"
        case gitURL = "git_url"
        case description
    }
}

extension RepoDetail {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        htmlURL = try values.decode(String.self, forKey: .htmlURL)
        gitURL = try values.decode(String.self, forKey: .gitURL)
        description = try values.decode(String.self, forKey: .description)
    }
}
