import Foundation
import RealmSwift

protocol RealmDataManagerProtocol {

	func save(_ object: Object)

	func update(content: ContentModel, at index: Int)

	func delete(_ object: Object)
	func deleteAll()

	func load() -> [NoteModel]

}
