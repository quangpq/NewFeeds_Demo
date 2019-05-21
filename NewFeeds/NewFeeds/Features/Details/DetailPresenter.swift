//
//  DetailPresenter.swift
//  NewFeeds
//
//  Created by Quang Phan on 21/05/2019.
//  Copyright © 2019 Quang Phan. All rights reserved.
//

import Foundation

protocol IDetailView: class {
    func requestRefreshData()
    func refreshData()
}

class DetailPresenter {
    private weak var view: IDetailView?
    let network: INetwork
    private let feedID: String
    
    private(set) var detail: NFDetail?
    
    init(view: IDetailView, feedID: String, network: INetwork) {
        self.view = view
        self.network = network
        self.feedID = feedID
    }
    
    func getSections() -> [NFDetailSection] {
        return detail?.sections ?? []
    }
    
    func getTitle() -> String? {
        return detail?.title
    }
    
    func getDescription() -> String? {
        return detail?.description
    }
    
    func refreshData() {
        network.getDetail(id: feedID) { [weak self] result in
            guard let wself = self else {return}
            switch result {
            case .success(let data):
                wself.detail = data
            case .failure(let error):
                print("Get Detail failed: \(error.localizedDescription)")
            }
            wself.view?.refreshData()
        }
    }
}
