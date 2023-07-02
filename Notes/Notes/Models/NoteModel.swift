import Foundation
import RealmSwift

class NoteModel: Object {
	@Persisted var text: String = ""
	@Persisted var date: String = ""
}
