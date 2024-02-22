//
//  RepositoryListVC.swift
//  Fund India
//
//  Created by Monish M on 20/02/24.
//

import UIKit
import Alamofire

class RepositoryListVC: UIViewController {

    @IBOutlet weak var repoListTableView: UITableView!
    
    var repoListData = [RepoListItems]()
    private let itemsPerPage = 10
    private var currentPage = 1
    private var totalItems = 0
    private var isFetching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repoListTableView.prefetchDataSource = self
        repoListTableView.register(UINib(nibName: "RepoListTableCell", bundle: .main), forCellReuseIdentifier: "RepoListTableCell")
        
        getRepoList()
    }
    
    func getRepoList() {
        isFetching = true
        let url = APIManager.shared.baseURL + API.repoList + "&page=\(currentPage)&per_page=\(itemsPerPage)"
        
        NetworkManager.shared.getApiRequest(url: url, parameters: nil) { (response) in
            switch(response?.result) {
            case .success(_):
                guard let data = response?.data else { return }
                    let decoder = JSONDecoder()
                        do {
                            let repoList = try decoder.decode(RepoListModel.self, from: data)
                            self.repoListData += repoList.items ?? []
                            self.totalItems = repoList.totalCount ?? 0
                            DispatchQueue.main.async {
                                self.repoListTableView.reloadData()
                            }
                            self.currentPage += 1
                            self.isFetching = false
                        } catch {
                            print(error)
                        }
            case .failure(let error):
                print(error.localizedDescription)
            case .none:
                print("server timeout")
            }
        }
    }
}

extension RepositoryListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoListTableCell") as! RepoListTableCell
        cell.selectionStyle = .none
        cell.setRepoDetails(data: repoListData[indexPath.row])
        return cell
    }
    
}

extension RepositoryListVC: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if (index.row >= repoListData.count - 1) && !isFetching {
                getRepoList()
            }
        }
    }
    
}

extension RepositoryListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRepoDetail = repoListData[indexPath.row]
        
        let repoDetailVC = RepoDetailVC()
        repoDetailVC.repoDetails = selectedRepoDetail
        self.navigationController?.pushViewController(repoDetailVC, animated: true)
    }
}

