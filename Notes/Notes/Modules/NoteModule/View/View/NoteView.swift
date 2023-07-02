import UIKit
import SnapKit

final class NoteView: UIView {

	var label: UILabel!
	var textView: UITextView!

	override init(frame: CGRect) {
		super.init(frame: frame)

		setupViews()
		setupHierarchy()
		setupConstraints()

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupViews() {

		backgroundColor = .systemBackground

		label = UILabel(
			text: "",
			textColor: .secondaryLabel,
			font: .systemFont(ofSize: 12),
			numberOfLines: 1,
			alignment: .center
		)

		textView = UITextView(
			textColor: .label,
			font: .systemFont(ofSize: 16),
			keyboardType: .default,
			returnKeyType: .default
		)

	}

	private func setupHierarchy() {
		addSubview(label)
		addSubview(textView)
	}

	func setupConstraints() {

		label.snp.makeConstraints {
			$0.centerX.equalTo(snp.centerX)
			$0.top.equalTo(safeAreaLayoutGuide.snp.top)
		}

		textView.snp.makeConstraints {
			$0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
			$0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).inset(16)
			$0.top.equalTo(label.snp.bottom).offset(4)
			$0.bottom.equalTo(keyboardLayoutGuide.snp.top).inset(-16)
		}

	}

}
