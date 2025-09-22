//
//  TextLinkIntentTests.swift
//  SparkComponentTextLinkUnitTests
//
//  Created by robin.lemaire on 05/12/2023.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import XCTest
@testable import SparkComponentTextLink

final class TextLinkIntentTests: XCTestCase {

    // MARK: - Tests

    func test_all_cases() {
        // GIVEN / WHEN
        let allCases = TextLinkIntent.allCases

        let expectedAllCases = [
            TextLinkIntent.accent,
            .accentContainer,
            .alert,
            .alertContainer,
            .basic,
            .basicContainer,
            .danger,
            .dangerContainer,
            .info,
            .infoContainer,
            .main,
            .mainContainer,
            .neutral,
            .neutralContainer,
            .surface,
            .success,
            .successContainer,
            .support,
            .supportContainer
        ]

        // THEN
        XCTAssertEqual(
            allCases,
            expectedAllCases
        )
    }
}
