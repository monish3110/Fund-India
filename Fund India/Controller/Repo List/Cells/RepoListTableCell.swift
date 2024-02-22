//
//  RepoListTableCell.swift
//  Fund India
//
//  Created by Monish M on 20/02/24.
//

import UIKit
import Alamofire
import AlamofireImage

class RepoListTableCell: UITableViewCell {

    @IBOutlet weak var repoImage: UIImageView!
    @IBOutlet weak var repoTitle: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setRepoDetails(data: RepoListItems) {
        repoTitle.text = data.name
        repoDescription.text = data.description
        repoImage.af.setImage(withURL: URL(string: data.owner?.avatarUrl ?? API.defaultImageUrl)!)
    }
    
}
