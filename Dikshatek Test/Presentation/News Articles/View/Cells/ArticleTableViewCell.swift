//
//  ArticleTableViewCell.swift
//  Dikshatek Test
//
//  Created by Arya Ilham on 23/02/24.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    static let ID = "ArticleTableViewCell"
    static let nib = UINib(nibName: "ArticleTableViewCell", bundle: nil)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    func setData(title: String, author: String?) {
        self.titleLabel.text = title
        if let author = author {
            self.authorLabel.text = "Author: \(author)"
        } else {
            self.authorLabel.text = ""
        }
    }
}
