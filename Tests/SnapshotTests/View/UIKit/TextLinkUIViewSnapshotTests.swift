//
//  TextLinkUIViewSnapshotTests.swift
//  SparkTextLinkSnapshotTests
//
//  Created by robin.lemaire on 19/12/2023.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import SparkTextLink
@_spi(SI_SPI) import SparkCommon
@_spi(SI_SPI) import SparkCommonSnapshotTesting
import SparkTheming
import SparkTheme

final class TextLinkUIViewSnapshotTests: UIKitComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test() {
        let scenarios = TextLinkScenarioSnapshotTests.allCases

        for scenario in scenarios {
            let configurations: [TextLinkConfigurationSnapshotTests] = scenario.configuration(
                isSwiftUIComponent: false
            )
            for configuration in configurations {

                let view: TextLinkUIView = .init(
                    theme: self.theme,
                    text: configuration.type.text,
                    textHighlightRange: configuration.type.textHighlightRange,
                    intent: configuration.intent,
                    typography: configuration.size.typography,
                    variant: configuration.variant,
                    image: configuration.image?.leftValue,
                    alignment: configuration.alignment
                )
                view.textAlignment = .left
                view.numberOfLines = 0

                self.assertSnapshot(
                    matching: view,
                    modes: configuration.modes,
                    sizes: configuration.sizes,
                    testName: configuration.testName()
                )
            }
        }
    }
}
