//
//  TextLinkGetDimUseCaseTests.swift
//  SparkComponentTextLinkUnitTests
//
//  Created by robin.lemaire on 03/06/2025.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkComponentTextLink
import SparkTheming
@_spi(SI_SPI) import SparkThemingTesting

final class TextLinkGetDimUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_for_all_intents_when_isHighlighted_is_false() {
        // GIVEN
        let useCase = TextLinkGetDimUseCase()
        let dimsMock = DimsGeneratedMock.mocked()

        let givenIntents = TextLinkIntent.allCases

        // WHEN
        for givenIntent in givenIntents {
            let dim = useCase.execute(
                intent: givenIntent,
                isHighlighted: false,
                dims: dimsMock
            )

            let expectedDim = givenIntent.expectedDimWithoutHighlighted(
                from: dimsMock
            )

            // THEN
            XCTAssertEqual(
                dim,
                expectedDim,
                "Wrong dim for .\(givenIntent) case"
            )
        }
    }

    func test_execute_for_all_intents_when_isHighlighted_is_true() {
        // GIVEN
        let useCase = TextLinkGetDimUseCase()
        let dimsMock = DimsGeneratedMock.mocked()

        let givenIntents = TextLinkIntent.allCases

        // WHEN
        for givenIntent in givenIntents {
            let dim = useCase.execute(
                intent: givenIntent,
                isHighlighted: true,
                dims: dimsMock
            )

            let expectedDim = givenIntent.expectedDimWithHighlighted(
                from: dimsMock
            )

            // THEN
            XCTAssertEqual(
                dim,
                expectedDim,
                "Wrong dim for .\(givenIntent) case"
            )
        }
    }
}

// MARK: - Extension

private extension TextLinkIntent {

    func expectedDimWithHighlighted(from dimsMock: DimsGeneratedMock) -> CGFloat {
        return switch self {
        case .accent: dimsMock.none
        case .onAccentContainer: dimsMock.dim1
        case .alert: dimsMock.none
        case .basic: dimsMock.none
        case .danger: dimsMock.none
        case .info: dimsMock.none
        case .main: dimsMock.none
        case .neutral: dimsMock.none
        case .onSurface: dimsMock.dim1
        case .success: dimsMock.none
        case .support: dimsMock.none
        }
    }

    func expectedDimWithoutHighlighted(from dimsMock: DimsGeneratedMock) -> CGFloat {
        return dimsMock.none
    }
}
