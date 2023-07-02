import UIKit
import RxSwift
import RxCocoa

final class NoteViewController: UIViewController {

	// MARK: - Properties
	var noteViewModel: NoteViewModelProtocol!

	private let disposeBag: RxSwift.DisposeBag = DisposeBag()

	private var content: ContentModel?
	var index: Int
	var isNewNote: Bool
	var date: Date = Date()
	var attributedText = NSAttributedString()

	let noteView = NoteView()

	// MARK: - Life Cycle
	override func loadView() {
		view = noteView
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		setupViews()
		setupDelegate()

		configure(content)

		subscribe()

	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		saveContent()
	}

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		makeNotification()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		noteView.setupConstraints()
	}

	// MARK: - init
	init(content: ContentModel?, index: Int, isNewNote: Bool) {
		self.index = index
		self.isNewNote = isNewNote
		self.content = content
		super.init(nibName: nil, bundle: nil)

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Methods
	func configure(_ content: ContentModel?) {

		guard let text = content?.text else { return }

		noteView.label.text = content?.date
		noteView.textView.text = text

		noteViewModel.boldFirstLine(noteView.textView)

	}

	// MARK: - Private
	private func subscribe() {

		noteViewModel.noteTextSignal.asObservable()
			.subscribe { [weak self] value in
				guard let self else { return }
				self.noteViewModel.boldFirstLine(value)
			}.disposed(by: disposeBag)

		noteViewModel.labelTextSignal.asObservable()
			.subscribe { [weak self] text in
				guard let self else { return }
				self.labelTextUpdate(text)
			}.disposed(by: disposeBag)

		noteViewModel.contentHandlerSignal.asObservable()
			.subscribe { [weak self] (content, index, isNewNote) in
				guard let self else { return }
				noteViewModel.contentHandler(
					with: content,
					index: index,
					isNewNote: isNewNote
				)
			}.disposed(by: disposeBag)

	}

	private func makeNotification() {
		NotificationCenter.default.post(
			name: NSNotification.Name(Constants.NotificationName.tableUpdate),
			object: nil
		)
	}

	private func setupViews() {

		navigationItem.largeTitleDisplayMode = .never

		navigationItem.rightBarButtonItem = UIBarButtonItem(
			title: "Ok",
			style: .plain,
			target: self,
			action: #selector(rightBarButtonItemAction)
		)

	}

	private func setupDelegate() {
		noteView.textView.delegate = self
	}

	private func saveContent() {
		guard let text = noteView.textView.text,
			  !text.isEmpty,
			  let dateString = noteView.label.text else { return }

		let content = ContentModel(text: text, date: dateString)

		noteViewModel.textViewHandler(
			with: content,
			index: index,
			isNewNote: isNewNote
		)
	}

	private func labelTextUpdate(_ text: String) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
			guard let self else { return }
			self.noteView.label.text = text
		}
	}

	// MARK: - @objc
	@objc private func rightBarButtonItemAction() {
		noteView.textView.resignFirstResponder()
	}
}
