//
//  DetailViewController.swift
//  NewFeeds
//
//  Created by Quang Phan on 21/05/2019.
//  Copyright © 2019 Quang Phan. All rights reserved.
//

import UIKit
import AVKit
import KRProgressHUD

class DetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var presenter: DetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        setupTableView()
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
        tableView.allowsSelection = false
        tableView.allowsMultipleSelection = false
        
        tableView.register(UINib(nibName: DetailTextTableCell.reuseID, bundle: nil), forCellReuseIdentifier: DetailTextTableCell.reuseID)
        tableView.register(UINib(nibName: DetailImageTableCell.reuseID, bundle: nil), forCellReuseIdentifier: DetailImageTableCell.reuseID)
        tableView.register(UINib(nibName: DetailVideoTableCell.reuseID, bundle: nil), forCellReuseIdentifier: DetailVideoTableCell.reuseID)

    }
    
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return presenter.getSections().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return cellForDetail(in: tableView, at: indexPath)
        }
        
        return cellForSection(in: tableView, at: indexPath)
    }
    
    private func cellForDetail(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: DetailTextTableCell.self, at: indexPath)
        
        let text: String?
        if indexPath.row == 0 {
            text = presenter.getTitle()
            cell.textView.font = UIFont.boldSystemFont(ofSize: 16)
        } else {
            text = presenter.getDescription()
        }
        
        cell.textView.text = text
        
        return cell
    }
    
    private func cellForSection(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let data = presenter.getSections()[indexPath.row]
        
        switch data.content {
        case .image(let image):
            let cell = tableView.dequeueReusableCell(ofType: DetailImageTableCell.self, at: indexPath)
            cell.setData(image)
            
            return cell
        case .text(let text):
            let cell = tableView.dequeueReusableCell(ofType: DetailTextTableCell.self, at: indexPath)
            cell.setData(text)
            
            return cell
        case .video(let video):
            let cell = tableView.dequeueReusableCell(ofType: DetailVideoTableCell.self, at: indexPath)
            cell.setData(video)
            cell.delegate = self
            
            return cell
        }
    }
}

extension DetailViewController: DetailVideoTableCellDelegate {
    func videoCell(didRequestShowVideo cell: DetailVideoTableCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        
        let data = presenter.getSections()[indexPath.row]
        
        guard case let .video(video) = data.content else {return}
        guard let url = URL(string: video.href) else {return}
        
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        present(playerViewController, animated: true) {
            player.play()
        }
    }
}

extension DetailViewController: IDetailView {
    func requestRefreshData() {
        KRProgressHUD.show(withMessage: "Loading...")
        presenter.refreshData()
    }
    
    func refreshData() {
        KRProgressHUD.dismiss()
        tableView.reloadData()
    }
}

extension DetailViewController {
    static func create(id: String, network: INetwork) -> DetailViewController {
        guard let vc = viewController(DetailViewController.reuseID, storyboard: "Main") as? DetailViewController else {
            return DetailViewController()
        }
        
        vc.presenter = DetailPresenter(view: vc, feedID: id, network: network)
        
        return vc
    }
}
