import Foundation
import RealmSwift

final class RealmDataManager: RealmDataManagerProtocol {

	private lazy var realm: Realm = {
		do {
			let realm = try Realm(configuration: .defaultConfiguration)
			return realm
		} catch let realmError {
			fatalError("Realm error: \(realmError)")
		}
	}()

	func save(_ object: RealmSwift.Object) {
		do {
			try realm.write { realm.add(object) }
		} catch let saveError {
			print("Save error:", saveError)
		}
	}

	func update(content: ContentModel, at index: Int) {
		let noteTitleModel = realm.objects(NoteModel.self)
		let sortedModel = noteTitleModel.sorted(
			by: \.date,
			ascending: false
		)
		let note = sortedModel[index]
		do {
			try realm.write {
				note.text = content.text
				note.date = content.date
			}
		} catch let updateError {
			print("Update error:", updateError)
		}
	}

	func delete(_ object: RealmSwift.Object) {
		do {
			try realm.write { realm.delete(object) }
		} catch let deleteError {
			print("Delete error:", deleteError)
		}
	}

	func deleteAll() {
		do {
			try realm.write { realm.deleteAll() }
		} catch let deleteAllError {
			print("DeleteAll error:", deleteAllError)
		}
	}

	func load() -> [NoteModel] {
		let model = realm.objects(NoteModel.self)
		let sortedNotes = model.sorted(
			by: \.date,
			ascending: false
		)
		let result = Array(sortedNotes)
		return result
	}

}
