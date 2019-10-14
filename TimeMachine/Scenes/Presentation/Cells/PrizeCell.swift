//
//  PrizeCell.swift
//  TimeMachine
//
//  Created by Nick Ibarra on 14/10/19.
//  Copyright © 2019 Nick iOS. All rights reserved.
//

import UIKit

class PrizeCell: UITableViewCell {

    // MARK: - IBOulets
    @IBOutlet weak var numberValue: UILabel!
    @IBOutlet weak var costValue: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var awardedLabel: UILabel!
    @IBOutlet weak var awardedValue: UILabel!
    @IBOutlet weak var countryValue: UILabel!
    @IBOutlet weak var motivationValue: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Setup Cell
    func setup(prize: Prize, number: Int) {
        numberValue.text = "\(number).-"
        costValue.text = "\(Int(prize.cost ?? 0))"
        year.text = prize.year ?? String()
        category.text = prize.category ?? String()
        awardedValue.text = "\(prize.firstname ?? String()) \(prize.surname ?? String())"
        countryValue.text = prize.country ?? String()
        motivationValue.text = prize.motivation ?? String()
    }
}
