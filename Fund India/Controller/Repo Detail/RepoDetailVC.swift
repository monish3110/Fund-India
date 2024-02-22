//
//  RepoDetailVC.swift
//  Fund India
//
//  Created by Monish M on 21/02/24.
//

import UIKit
import Alamofire
import AlamofireImage

class RepoDetailVC: UIViewController {

    @IBOutlet weak var repoImage: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    
    @IBOutlet weak var detailView: UIView!
    var repoDetails: RepoListItems?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setRepoDetails()
    }
    
    
    func setRepoDetails() {
        repoName.text = repoDetails?.name
        repoImage.af.setImage(withURL: URL(string: repoDetails?.owner?.avatarUrl ?? API.defaultImageUrl)!)
        repoDescription.text = repoDetails?.description
        fullName.text = repoDetails?.fullName
    }

    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        detailView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
    }
}
