import Foundation
import UIKit
import RxSwift
import RxCocoa

final class MainViewModel: MainViewModelProtocol {

	// MARK: - Properties
	var router: RouterProtocol!
	private let realmDataManager: RealmDataManagerProtocol = RealmDataManager()

	var cellConfigureSignal: RxSwift.PublishSubject<(UITableViewCell, IndexPath)> = PublishSubject()
	var isEditingSignal: RxRelay.BehaviorRelay<Bool> = BehaviorRelay(value: true)
	var noteSignal: RxSwift.PublishSubject<(ContentModel?, Int, Bool)> = PublishSubject()
	var deleteSignal: RxSwift.PublishSubject<(IndexPath)> = PublishSubject()

	private var source: [NoteModel] {
		let source = realmDataManager.load()
		return source
	}

	// MARK: - Notes
	func createNote() {
		noteSignal.on(
			.next(
				(nil, 0, true)
			)
		)
	}

	func editNote(at indexPath: IndexPath) {

		let text = source[indexPath.row].text
		let date = source[indexPath.row].date
		let content = ContentModel(text: text, date: date)

		noteSignal.on(
			.next(
				(content, indexPath.row, false)
			)
		)
	}

	func pushNote(_ content: ContentModel?, _ index: Int, _ bool: Bool) {
		router.pushNote(content: content, index: index, isNewNote: bool)
	}

	// MARK: - UITableViewDataSource
	var numberOfSections: Int {
		1
	}

	func numberOfRowsIn(_ section: Int) -> Int {
		source.count
	}

	func cellConfigureAction(cell: UITableViewCell, at indexPath: IndexPath) {
		cellConfigureSignal.on(
			.next(
				(cell, indexPath)
			)
		)
	}

	func cellConfigure(cell: UITableViewCell, at indexPath: IndexPath) {
		let content = source[indexPath.row]

		var config = cell.defaultContentConfiguration()
		config.text = getFirstLineTitle(content.text)
		let secondaryText = "\(content.date), \(getSubtitle(content.text))"
		config.secondaryAttributedText = secondaryText.stringToAttributedString(with: .secondaryLabel)
		config.secondaryTextProperties.numberOfLines = 2
		cell.contentConfiguration = config
	}

	// MARK: - UITableViewDelegate
	func tableEditing(_ bool: Bool) {
		isEditingSignal.accept(bool)
	}

	func deleteAction(at indexPath: IndexPath) {
		deleteSignal.on(
			.next(
				(indexPath)
			)
		)
	}

	func deleteSource(at indexPath: IndexPath) {
		let textObject = source[indexPath.row]
		realmDataManager.delete(textObject)
	}

	// MARK: - Private
	private func getFirstLineTitle(_ text: String) -> String {
		let firstLine = text.components(separatedBy: "\n")[0]
		return firstLine
	}

	private func getSubtitle(_ text: String) -> String {
		let textComponents = text.components(separatedBy: "\n")[1...]
		let result = textComponents.joined(separator: "\n")
		return result
	}

}
