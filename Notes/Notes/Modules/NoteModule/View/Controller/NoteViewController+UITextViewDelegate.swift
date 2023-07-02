import Foundation
import UIKit

extension NoteViewController: UITextViewDelegate {

	func textViewDidChange(_ textView: UITextView) {
		noteViewModel.noteTextSignal.on(.next(textView))
	}

	func textViewDidBeginEditing(_ textView: UITextView) {

		let text = date.getString(dateFormatter: Constants.DateFormat.format1)

		noteViewModel.labelTextSignal.on(
			.next(text)
		)

	}

}
