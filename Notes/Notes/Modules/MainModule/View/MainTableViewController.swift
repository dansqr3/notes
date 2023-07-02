import UIKit
import RxSwift

final class MainTableViewController: UITableViewController {

	// MARK: - Properties
	var mainViewModel: MainViewModelProtocol!

	private var indexForUpdate: Int = 0

	private let disposeBag = DisposeBag()

	// MARK: - Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()

		setupViews()

		setupNotification()

		setupSubscribers()

	}

	// MARK: - Methods
	private func setupSubscribers() {

		mainViewModel.isEditingSignal.asObservable()
			.subscribe { [weak self] bool in
				guard let self else { return }
				self.tableViewIsEditing(bool)
			}
			.disposed(by: disposeBag)

		mainViewModel.noteSignal.asObservable()
			.subscribe { [weak self] (content, index, bool) in
				guard let self else { return }
				self.mainViewModel.pushNote(content, index, bool)
			}
			.disposed(by: disposeBag)

		mainViewModel.cellConfigureSignal.asObservable()
			.subscribe { [weak self] (cell, index) in
				guard let self else { return }
				self.mainViewModel.cellConfigure(cell: cell, at: index)
			}
			.disposed(by: disposeBag)

		mainViewModel.deleteSignal.asObservable()
			.subscribe { [weak self] indexPath in
				guard let self else { return }
				self.mainViewModel.deleteSource(at: indexPath)
			}
			.disposed(by: disposeBag)

	}

	private func setupViews() {

		view.backgroundColor = .secondarySystemBackground

		navigationController?.navigationBar.prefersLargeTitles = true

		title = "Notes"

		tableView.register(
			UITableViewCell.self,
			forCellReuseIdentifier: Constants.Table.cellIdentifier
		)

		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .add,
			target: self,
			action: #selector(rightBarButtonItemAction)
		)
		navigationItem.leftBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .edit,
			target: self,
			action: #selector(leftBarButtonItemAction)
		)

		navigationController?.navigationBar.barTintColor = .systemGray6

	}

	private func setupNotification() {
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(updateTableView),
			name: NSNotification.Name(Constants.NotificationName.tableUpdate),
			object: nil
		)
	}

	private func tableViewIsEditing(_ bool: Bool) {
		tableView.isEditing = !bool
	}

	// MARK: - @objc
	@objc private func rightBarButtonItemAction() {
		mainViewModel.createNote()
	}

	@objc private func leftBarButtonItemAction() {
		mainViewModel.tableEditing(tableView.isEditing)
	}

	@objc private func updateTableView() {
		tableView.reloadSections(.init(integer: 0), with: .fade)
	}

}
