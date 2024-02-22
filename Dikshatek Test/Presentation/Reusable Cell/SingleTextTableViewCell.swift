//
//  SingleTextTableViewCell.swift
//  Dikshatek Test
//
//  Created by Arya Ilham on 22/02/24.
//

import UIKit

class SingleTextTableViewCell: UITableViewCell {
    static let ID = "SingleTextTableViewCell"
    static let nib = UINib(nibName: "SingleTextTableViewCell", bundle: nil)

    @IBOutlet weak var titleLabel: UILabel!
}
