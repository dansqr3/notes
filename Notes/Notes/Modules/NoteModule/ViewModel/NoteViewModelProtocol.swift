import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol NoteViewModelProtocol {

	var noteTextSignal: PublishSubject<UITextView> { get set }
	var labelTextSignal: RxSwift.PublishSubject<String> { get set }
	var contentHandlerSignal: RxSwift.PublishSubject<(ContentModel, Int, Bool)> { get set }

	func textViewHandler(with content: ContentModel, index: Int, isNewNote: Bool)
	func contentHandler(with content: ContentModel, index: Int, isNewNote: Bool)

	func boldFirstLine(_ textView: UITextView)

}
