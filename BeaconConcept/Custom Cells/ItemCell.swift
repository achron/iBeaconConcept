 import UIKit

class ItemCell: UITableViewCell {
  
  @IBOutlet weak var imgIcon: UIImageView!
  @IBOutlet weak var lblName: UILabel!
  @IBOutlet weak var lblLocation: UILabel!
  
  var item: Item? = nil {
    didSet {
      if let item = item {
        imgIcon.image = Icons(rawValue: item.icon)?.image()
          lblName.text = "RSSI \(item.locationRssi()) UUID: \(item.uuid)"
          lblLocation.text = "\(item.locationValue())"
      } else {
        imgIcon.image = nil
        lblName.text = ""
        lblLocation.text = ""
      }
    }
  }
  
  func refreshLocation() {
    lblLocation.text = item?.locationString() ?? ""
  }
}
