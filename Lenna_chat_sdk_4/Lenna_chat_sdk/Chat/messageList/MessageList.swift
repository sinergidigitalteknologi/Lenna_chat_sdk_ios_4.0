//
//  MessageList.swift
//  Lenna
//
//  Created by MacBook Air on 7/8/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import UIKit

protocol ListMessageDelegate {
    func listMessage(newMessage : String)
}

class MessageList: UITableViewCell, UITableViewDataSource, UITableViewDelegate {

    var arrList = [ColumnList]()
    
    var listmessage : ListMessageDelegate?

    @IBOutlet weak var imagePaket: UIImageView!
    @IBOutlet weak var heightList: NSLayoutConstraint!
    @IBOutlet weak var collectionList: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionList.register(UINib.init(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "ListCell")
        
        collectionList.delegate = self
        collectionList.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : ListCell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        
        cell.descriptionLabel.text = arrList[indexPath.row].text
        cell.priceList.text = arrList[indexPath.row].subText
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        listmessage?.listMessage(newMessage: arrList[indexPath.row].defaultAction!.data)
    }

    
}
