//
//  NewFeedsPresenter.swift
//  NewFeeds
//
//  Created by Quang Phan on 21/05/2019.
//  Copyright © 2019 Quang Phan. All rights reserved.
//

import Foundation

protocol INewFeedsView: class {
    func requestRefreshData()
    func refreshData()
}

class NewFeedsPresenter {
    private weak var view: INewFeedsView?
    let network: INetwork
    
    private(set) var items: [NFFeed] = []
    
    init(view: INewFeedsView, network: INetwork) {
        self.view = view
        self.network = network
    }
    
    func refreshData() {
        network.getNewFeeds { [weak self] result in
            guard let wself = self else {return}
            switch result {
            case .success(let data):
                wself.items = data
            case .failure(let error):
                print("Get NewsFeed failed: \(error.localizedDescription)")
            }
            wself.view?.refreshData()
        }
    }
}
