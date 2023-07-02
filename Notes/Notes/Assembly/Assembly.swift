import Foundation
import UIKit

final class Assembly: AssemblyProtocol {

	func createMain(router: RouterProtocol) -> UIViewController {

		let mainTableViewController = MainTableViewController(style: .insetGrouped)

		let mainViewModel = MainViewModel()

		mainTableViewController.mainViewModel = mainViewModel

		mainViewModel.router = router

		return mainTableViewController
	}

	func createNote(_ content: ContentModel?, _ index: Int, _ isNewNote: Bool) -> UIViewController {

		let noteViewController = NoteViewController(content: content, index: index, isNewNote: isNewNote)

		let noteViewModel = NoteViewModel()

		noteViewController.noteViewModel = noteViewModel

		return noteViewController
	}

}
