//
//  ViewController.swift
//  MVVM_github_client
//
//  Created by 堀知海 on 2020/05/18.
//  Copyright © 2020 umichan. All rights reserved.
//

import UIKit
import RxSwift
import SafariServices

class ViewController: UIViewController {
    
    private var viewModel: UserListViewModel!

    private var tableView: UITableView!
    private var refreshControl: UIRefreshControl!
    
    private var userList: Array<User> = []
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TimelineCell.self, forCellReuseIdentifier: "TimelineCell")
        view.addSubview(tableView)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        viewModel = UserListViewModel(userRepository: GithubUserRepository())
        observe()
        
        viewModel.getUsers()
    }
    
    private func observe() {
        viewModel.userListState.subscribe(onNext: { (state: UserListState) in
            switch (state) {
            case .loading:
                self.tableView.isUserInteractionEnabled = false
            case .completed:
                self.tableView.isUserInteractionEnabled = true
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            case .error(let error):
                self.tableView.isUserInteractionEnabled = true
                self.refreshControl.endRefreshing()
                print((error as? APIStatus)?.description ?? "error")
            case .empty: break
            }
        }).disposed(by: disposeBag)
        
        viewModel.userList.subscribe(onNext: { (userList: Array<User>) in
            self.userList = userList
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }


    @objc func refresh(_ sender: UIRefreshControl) {
        viewModel.getUsers()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let timelineCell = tableView.dequeueReusableCell(withIdentifier: "TimelineCell") as? TimelineCell {
            let index = indexPath.row
            let cellViewModel = viewModel.userCellViewModelList[index]
            
            timelineCell.setNickName(nickName: cellViewModel.nickName)
            timelineCell.setIcon(imageUrlString: cellViewModel.webURL)
            
            return timelineCell
        }
        
        fatalError()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cellViewModel = viewModel.userCellViewModelList[indexPath.row]
        let webViewController = SFSafariViewController(url: URL(string: cellViewModel.webURL)!)
        navigationController?.pushViewController(webViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userCount()
    }
}

