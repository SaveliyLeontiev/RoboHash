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

        let gr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        imageView.addGestureRecognizer(gr)
    }

    func configurePresenter() {
        roboImagePresenter.delegate = self
    }
}

// MARK: - RoboImagePresenterDelegate
extension RoboImageViewController: RoboImagePresenterDelegate {
    func perfomEmptyNameAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.07, initialSpringVelocity: 3, options: [], animations: {
            self.nameField.frame.origin.x += 5
        }) { _ in
            self.nameField.frame.origin.x -= 5
        }
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
    func generateButtonAction(_ sender: UIButton) {
        guard !isLoading else { return }
        nameField.resignFirstResponder()
        roboImagePresenter.generateImage(name: nameField.text)
    }

    @objc
    func handleLongPress(_ sender: UILongPressGestureRecognizer) {
        guard let image = imageView.image else {
            return
        }

        if sender.state == .began {
            showSaveImageActionSheet(image: image)
        }
    }

    func showSaveImageActionSheet(image: UIImage) {
        let actionSheet = UIAlertController(title: nil, message: "Do you want to save this image?",
                                            preferredStyle: .actionSheet)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            self?.roboImagePresenter.saveImage(image: image)
        }
        actionSheet.addAction(saveAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            actionSheet.dismiss(animated: true, completion: nil)
        }
        actionSheet.addAction(cancelAction)

        present(actionSheet, animated: true, completion: nil)
    }
}
