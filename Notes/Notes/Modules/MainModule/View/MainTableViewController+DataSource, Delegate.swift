import Foundation
import UIKit

extension MainTableViewController {

	// MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		return mainViewModel.numberOfSections
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return mainViewModel.numberOfRowsIn(section)
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .subtitle, reuseIdentifier: Constants.Table.cellIdentifier)

		mainViewModel.cellConfigureAction(cell: cell, at: indexPath)

		return cell
	}

	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}

	override func tableView(
		_ tableView: UITableView,
		commit editingStyle: UITableViewCell.EditingStyle,
		forRowAt indexPath: IndexPath
	) {
		if editingStyle == .delete {
			mainViewModel.deleteAction(at: indexPath)
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}

	// MARK: - Table view delegate
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)

		mainViewModel.editNote(at: indexPath)
	}

}
