//
//  RootViewController.swift
//  RIBs-Sample
//
//  Created by nb-058-41b on 6/16/20.
//  Copyright © 2020 Alexander Tereshkov. All rights reserved.
//

import RIBs
import UIKit

protocol RootPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {

    weak var listener: RootPresentableListener?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
    }

    // MARK: - RootViewControllable

    func replaceModal(viewController: ViewControllable?) {
        targetViewController = viewController

        guard !animationInProgress else { return }

        if presentedViewController != nil {
            animationInProgress = true
            dismiss(animated: true) { [weak self] in
                guard let this = self else { return }

                if this.targetViewController != nil {
                    this.presentTargetViewController()
                } else {
                    this.animationInProgress = false
                }
            }
        } else {
            presentTargetViewController()
        }
    }

    // MARK: - Private

    private var targetViewController: ViewControllable?
    private var animationInProgress = false

    private func presentTargetViewController() {
        if let targetViewController = targetViewController {
            animationInProgress = true
            present(targetViewController.uiviewController, animated: true) { [weak self] in
                self?.animationInProgress = false
            }
        }
    }
}
