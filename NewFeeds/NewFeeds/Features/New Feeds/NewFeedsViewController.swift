//
//  NewFeedsViewController.swift
//  NewFeeds
//
//  Created by Quang Phan on 21/05/2019.
//  Copyright © 2019 Quang Phan. All rights reserved.
//

import UIKit
import KRProgressHUD

class NewFeedsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var presenter: NewFeedsPresenter!
    private var needShowLoading = true
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let network = LocalNetwork()
        let network = AlamofireNetwork()
        presenter = NewFeedsPresenter(view: self, network: network)

        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        requestRefreshData()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        
        tableView.register(UINib(nibName: NewFeedTableCell.reuseID, bundle: nil), forCellReuseIdentifier: NewFeedTableCell.reuseID)
    }

}

extension NewFeedsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: NewFeedTableCell.self, at: indexPath)
        
        cell.setData(presenter.items[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let data = presenter.items[indexPath.row]
        let vc = DetailViewController.create(id: data.id, network: presenter.network)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension NewFeedsViewController: INewFeedsView {
    func requestRefreshData() {
        if needShowLoading {
            KRProgressHUD.show(withMessage: "Loading...")
            needShowLoading = false
        }
        presenter.refreshData()
    }
    
    func refreshData() {
        KRProgressHUD.dismiss()
        tableView.reloadData()
    }
}
