import Foundation
import UIKit

extension UITextView {

	convenience init(
		textColor: UIColor,
		font: UIFont,
		keyboardType: UIKeyboardType = .default,
		returnKeyType: UIReturnKeyType = .default
	) {
		self.init()

		self.textColor = textColor
		self.font = font
		self.keyboardType = keyboardType
		self.returnKeyType = returnKeyType
	}

}
