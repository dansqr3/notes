import Foundation
import UIKit

final class Router: RouterProtocol {

	var navigationController: UINavigationController?

	var assembly: AssemblyProtocol?

	init(navigationController: UINavigationController?, assembly: AssemblyProtocol?) {
		self.navigationController = navigationController
		self.assembly = assembly
	}

	func initialMain() {
		if navigationController != nil {
			guard let mainViewController = assembly?.createMain(router: self) else { return }
			navigationController?.viewControllers = [mainViewController]
		}
	}

	func pushNote(content: ContentModel?, index: Int, isNewNote: Bool) {
		if navigationController != nil {
			guard let noteViewController = assembly?.createNote(content, index, isNewNote) else { return }
			navigationController?.pushViewController(noteViewController, animated: true)
		}
	}

}
