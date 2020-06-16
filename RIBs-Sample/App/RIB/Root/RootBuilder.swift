//
//  RootBuilder.swift
//  RIBs-Sample
//
//  Created by nb-058-41b on 6/16/20.
//  Copyright © 2020 Alexander Tereshkov. All rights reserved.
//

import RIBs

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build(with listener: RootListener?) -> (launchRouter: LaunchRouting, urlHandler: UrlHandler)
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build(with listener: RootListener?) -> (launchRouter: LaunchRouting, urlHandler: UrlHandler) {
        let component = RootComponent(dependency: dependency)
        let viewController = RootViewController()
        
        let interactor = RootInteractor(presenter: viewController)
        interactor.listener = listener
        
        let router = RootRouter(interactor: interactor, viewController: viewController)
        
        return (router, interactor)
    }
}
