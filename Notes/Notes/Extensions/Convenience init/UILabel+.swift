import Foundation
import UIKit

extension UILabel {

	convenience init(
		text: String,
		textColor: UIColor,
		font: UIFont,
		numberOfLines: Int = 0,
		alignment: NSTextAlignment = .natural
	) {
		self.init()

		self.text = text
		self.textColor = textColor
		self.font = font
		self.numberOfLines = numberOfLines
		self.textAlignment = alignment
	}

}
