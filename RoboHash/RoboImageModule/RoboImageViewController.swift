//
//  RoboImageViewController.swift
//  RoboHash
//

import UIKit

class RoboImageViewController: UIViewController {
    private let roboImagePresenter = RoboImagePresenter()

    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var generateButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

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
        setLoading(false)
    }

    func configurePresenter() {
        roboImagePresenter.delegate = self
    }
}

// MARK: - RoboImagePresenterDelegate
extension RoboImageViewController: RoboImagePresenterDelegate {
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
        print("TODO: Add generation action")
    }

    private func setLoading(_ isLoading: Bool) {
        activityIndicator.isHidden = !isLoading
        imageView.alpha = isLoading ? 0.2 : 1
    }
}
