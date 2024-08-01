import Foundation
import UIKit


enum Icons: Int {
  case bag = 0
  
  func image() -> UIImage? {
      if #available(iOS 13.0, *) {
          return UIImage(systemName: "location.circle.fill")
      } else {
          return UIImage(named: "location.circle.fill")
      }
  }

  
  static func icon(forTag tag: Int) -> Icons {
    return Icons(rawValue: tag) ?? .bag
  }
  
  static let allIcons: [Icons] = {
    var all = [Icons]()
    var index: Int = 0
    while let icon = Icons(rawValue: index) {
      all += [icon]
      index += 1
    }
    return all.sorted { $0.rawValue < $1.rawValue }
  }()
}
