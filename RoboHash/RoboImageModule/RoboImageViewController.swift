//
//  RoboImageViewController.swift
//  RoboHash
//

import UIKit

class RoboImageViewController: UIViewController {
    private let roboImagePresenter = RoboImagePresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension RoboImageViewController {
    func configurePresenter() {
        roboImagePresenter.delegate = self
    }
}

// MARK: - RoboImagePresenterDelegate
extension RoboImageViewController: RoboImagePresenterDelegate {
}
