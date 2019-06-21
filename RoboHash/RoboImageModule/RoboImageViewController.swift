//
//  RoboImageViewController.swift
//  RoboHash
//

import UIKit

class RoboImageViewController: UIViewController {
    private let roboImagePresenter = RoboImagePresenter(roboImageService: RoboImageService())

    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var generateButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    var isLoading: Bool = false {
        didSet {
            activityIndicator.isHidden = !isLoading
            imageView.alpha = isLoading ? 0.2 : 1
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configurePresenter()
    }
}

private extension RoboImageViewController {
    func configureView() {
        nameField.delegate = self
        nameField.autocapitalizationType = .none
        nameField.autocorrectionType = .no
        generateButton.addTarget(self, action: #selector(generateButtonAction(_:)),
                                 for: .touchUpInside)
        isLoading = false
    }

    func configurePresenter() {
        roboImagePresenter.delegate = self
    }
}

// MARK: - RoboImagePresenterDelegate
extension RoboImageViewController: RoboImagePresenterDelegate {
    func perfomEmptyNameAnimation() {
        print("TODO: add empty animation")
    }

    func setImage(_ image: UIImage) {
        imageView.image = image
    }

    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func setLoading(isLoading: Bool) {
        self.isLoading = isLoading
    }

}

// MARK: - UITextFieldDelegate
extension RoboImageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

// MARK: - Actions
extension RoboImageViewController {
    @objc
    func generateButtonAction(_ sender: Any) {
        guard !isLoading else { return }
        nameField.resignFirstResponder()
        roboImagePresenter.generateImage(name: nameField.text)
    }
}
