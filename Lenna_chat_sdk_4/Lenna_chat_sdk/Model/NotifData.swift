//
//  NotifData.swift
//  Lenna
//
//  Created by Agustiar on 6/12/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import Foundation

class NotifData: NSObject {
    @objc dynamic var idUser: String = ""
    @objc dynamic var titleNotif: String = ""
    @objc dynamic var bodyNotif: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var topics: String = ""
    @objc dynamic var category: String = ""
    @objc dynamic var sub_category: String = ""
    @objc dynamic var iconType: String = ""
    @objc dynamic var status: Int = 0
    @objc dynamic var dateReceived: Date?
}
