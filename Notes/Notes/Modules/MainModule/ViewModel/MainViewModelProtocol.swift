import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol MainViewModelProtocol {

	// MARK: - Properties
	var cellConfigureSignal: RxSwift.PublishSubject<(UITableViewCell, IndexPath)> { get set }
	var isEditingSignal: BehaviorRelay<Bool> { get set }
	var noteSignal: PublishSubject<(ContentModel?, Int, Bool)> { get set }
	var deleteSignal: RxSwift.PublishSubject<(IndexPath)> { get set }

	// MARK: - Notes
	func createNote()
	func editNote(at indexPath: IndexPath)

	func pushNote(_ content: ContentModel?, _ index: Int, _ bool: Bool)

	// MARK: - UITableViewDataSource
	var numberOfSections: Int { get }

	func numberOfRowsIn(_ section: Int) -> Int

	func cellConfigureAction(cell: UITableViewCell, at indexPath: IndexPath)
	func cellConfigure(cell: UITableViewCell, at indexPath: IndexPath)

	// MARK: - UITableViewDelegate
	func tableEditing(_ bool: Bool)

	func deleteAction(at indexPath: IndexPath)
	func deleteSource(at indexPath: IndexPath)

}
