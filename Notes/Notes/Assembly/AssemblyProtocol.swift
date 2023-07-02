import Foundation
import UIKit

protocol AssemblyProtocol {

	func createMain(router: RouterProtocol) -> UIViewController

	func createNote(_ content: ContentModel?, _ index: Int, _ isNewNote: Bool) -> UIViewController

}
