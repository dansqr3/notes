import Foundation
import UIKit
import RxSwift
import RxCocoa

final class NoteViewModel: NoteViewModelProtocol {

	private let realmDataManager: RealmDataManagerProtocol = RealmDataManager()

	var noteTextSignal: RxSwift.PublishSubject<UITextView> = PublishSubject()
	var labelTextSignal: RxSwift.PublishSubject<String> = PublishSubject()
	var contentHandlerSignal: RxSwift.PublishSubject<(ContentModel, Int, Bool)> = PublishSubject()

	func textViewHandler(with content: ContentModel, index: Int, isNewNote: Bool) {

		contentHandlerSignal.on(
			.next(
				(content, index, isNewNote)
			)
		)

	}

	func contentHandler(with content: ContentModel, index: Int, isNewNote: Bool) {

		switch isNewNote {
			case true:
				let noteModel = NoteModel()
				noteModel.text = content.text
				noteModel.date = content.date
				realmDataManager.save(noteModel)
			case false:
				realmDataManager.update(content: content, at: index)
		}

	}

	func boldFirstLine(_ textView: UITextView) {

		let currentSelectedRange = textView.selectedRange
		let text = String(textView.text)

		let attributedString = NSMutableAttributedString(
			string: text,
			attributes: [
				NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
				NSAttributedString.Key.foregroundColor: UIColor.label
			]
		)
		textView.attributedText = attributedString

		let breakLineIndex = text.firstIndex(of: "\n") ?? text.endIndex
		let firstLineText = String(text[..<breakLineIndex])
		let range = NSRange(location: 0, length: firstLineText.count)

		attributedString.addAttribute(
			.font,
			value: UIFont.systemFont(ofSize: 28, weight: .semibold),
			range: range
		)

		textView.attributedText = attributedString
		textView.selectedRange = currentSelectedRange

	}

}
