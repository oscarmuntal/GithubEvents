//
//  UIImageView+Extensions.swift
//  GithubEvents
//
//  Created by Òscar Muntal on 11/3/23.
//

import UIKit
import Kingfisher

extension UIImageView {
    func rounded() {
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.height / 2
            self.layer.masksToBounds = true
        }
    }

    func setActorImage(with url: URL?, placehoder: UIImage? = .placeholderActor) {
        tintColor = .white
        setImage(with: url, placeholder: placehoder)
    }

    func setImage(with url: URL?, placeholder: UIImage?) {
        kf.setImage(with: url, placeholder: placeholder)
    }
}
