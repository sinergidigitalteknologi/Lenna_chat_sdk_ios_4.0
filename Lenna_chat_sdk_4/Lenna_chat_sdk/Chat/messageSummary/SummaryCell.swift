//
//  SummaryCell.swift
//  Lenna
//
//  Created by MacBook Air on 5/2/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import UIKit

class SummaryCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageSummary: UIImageView!
    @IBOutlet weak var summaryTable: UITableView!
    
    var summaryInfocellIdentifoer = "SummaryInfoCell"
    
    var arrSummaryInfo = [ColumnSummary]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        summaryTable.delegate = self
        summaryTable.dataSource = self
        summaryTable.register(UINib.init(nibName: summaryInfocellIdentifoer, bundle: nil), forCellReuseIdentifier: summaryInfocellIdentifoer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSummaryInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let summaryInfo = arrSummaryInfo[indexPath.item]
        
        let cell : SummaryInfoCell = tableView.dequeueReusableCell(withIdentifier: summaryInfocellIdentifoer, for: indexPath) as! SummaryInfoCell
        
        cell.label.text = summaryInfo.field
        cell.valueLabel.text = summaryInfo.value
        
        return cell
    }
    
    
    
}
