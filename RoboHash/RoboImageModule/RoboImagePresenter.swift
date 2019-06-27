//
//  RoboImagePresenter.swift
//  RoboHash
//

import Foundation
import UIKit

protocol RoboImagePresenterDelegate: class {
    func perfomEmptyNameAnimation()
    func setImage(_ image: UIImage)
    func showError(message: String)
    func setLoading(isLoading: Bool)
}

class RoboImagePresenter {
    private let roboImageServie: RoboImageServiceType

    weak var delegate: RoboImagePresenterDelegate?

    init(roboImageService: RoboImageServiceType) {
        self.roboImageServie = roboImageService
    }
}

extension RoboImagePresenter {
    func generateImage(name: String?) {
        guard let name = name, name.isEmpty == false else {
            delegate?.perfomEmptyNameAnimation()
            return
        }
        delegate?.setLoading(isLoading: true)
        roboImageServie.roboImage(name: name, callbackQueue: .main) { [weak self] result in
            switch result {
            case .success(let image):
                self?.delegate?.setImage(image)
            case .error(let error):
                self?.delegate?.showError(message: error.localizedDescription)
            }
            self?.delegate?.setLoading(isLoading: false)
        }
    }

    func saveImage(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}
