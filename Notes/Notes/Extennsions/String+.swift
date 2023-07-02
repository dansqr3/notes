import Foundation
import UIKit

extension String {

	func stringToAttributedString(with color: UIColor) -> NSAttributedString {
		let attributedString = NSMutableAttributedString(string: self)
		attributedString.addAttribute(
			.foregroundColor,
			value: color,
			range: NSRange(self.startIndex..<self.endIndex, in: self)
		)
		return attributedString
	}
}
