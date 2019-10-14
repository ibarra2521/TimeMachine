//
//  HomeViewController+TableView.swift
//  TimeMachine
//
//  Created by Nick Ibarra on 14/10/19.
//  Copyright © 2019 Nick iOS. All rights reserved.
//

import UIKit

// MARK: - TableView
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finalArray.prefix(Constant.closest).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = homeTableView.dequeueReusableCell(withIdentifier: k.cellIdentifier, for: indexPath) as? PrizeCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.setup(prize: finalArray[indexPath.row], number: indexPath.row + 1)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
