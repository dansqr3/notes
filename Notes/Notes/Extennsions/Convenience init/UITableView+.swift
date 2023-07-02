import Foundation
import UIKit

extension UITableView {

	convenience init(
		separatorInset: UIEdgeInsets = .init(),
		refreshControl: UIRefreshControl? = nil
	) {
		self.init()

		self.separatorInset = separatorInset
		self.refreshControl = refreshControl
	}

}
