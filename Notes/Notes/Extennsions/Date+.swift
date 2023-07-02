import Foundation

extension Date {

	func getString(dateFormatter: String) -> String {
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		formatter.dateFormat = dateFormatter
		let title = formatter.string(from: self)
		return title
	}

}
