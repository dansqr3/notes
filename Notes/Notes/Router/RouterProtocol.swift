import Foundation
import UIKit

protocol RouterProtocol {

	var navigationController: UINavigationController? { get }
	var assembly: AssemblyProtocol? { get }

	func initialMain()

	func pushNote(content: ContentModel?, index: Int, isNewNote: Bool)

}
