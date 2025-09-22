//
//  TextLinkGetColorUseCaseTests.swift
//  SparkComponentTextLinkUnitTests
//
//  Created by robin.lemaire on 05/12/2023.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkComponentTextLink
import SparkTheming
@_spi(SI_SPI) import SparkThemingTesting

final class TextLinkGetColorUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_for_all_intents_when_isHighlighted_is_false() {
        // GIVEN
        let useCase = TextLinkGetColorUseCase()
        let colorsMock = ColorsGeneratedMock.mocked()

        let givenIntents = TextLinkIntent.allCases

        // WHEN
        for givenIntent in givenIntents {
            let colorToken = useCase.execute(
                intent: givenIntent,
                isHighlighted: false,
                colors: colorsMock
            )

            let expectedColorToken = givenIntent.expectedColorTokenWithoutHighlighted(
                from: colorsMock
            )

            // THEN
            XCTAssertIdentical(
                colorToken as? ColorTokenGeneratedMock,
                expectedColorToken as? ColorTokenGeneratedMock,
                "Wrong color for .\(givenIntent) case"
            )
        }
    }

    func test_execute_for_all_intents_when_isHighlighted_is_true() {
        // GIVEN
        let useCase = TextLinkGetColorUseCase()
        let colorsMock = ColorsGeneratedMock.mocked()

        let givenIntents = TextLinkIntent.allCases

        // WHEN
        for givenIntent in givenIntents {
            let colorToken = useCase.execute(
                intent: givenIntent,
                isHighlighted: true,
                colors: colorsMock
            )

            let expectedColorToken = givenIntent.expectedColorTokenWithHighlighted(
                from: colorsMock
            )

            // THEN
            XCTAssertIdentical(
                colorToken as? ColorTokenGeneratedMock,
                expectedColorToken as? ColorTokenGeneratedMock,
                "Wrong color for .\(givenIntent) case"
            )
        }
    }
}

// MARK: - Extension

private extension TextLinkIntent {

    func expectedColorTokenWithHighlighted(from colorsMock: ColorsGeneratedMock) -> any ColorToken {
        switch self {
        case .accent: colorsMock.states.accentPressed
        case .accentContainer: colorsMock.accent.onAccentContainer
        case .onAccentContainer: colorsMock.accent.onAccentContainer
        case .alert: colorsMock.states.alertPressed
        case .alertContainer: colorsMock.feedback.onAlertContainer
        case .basic: colorsMock.states.basicPressed
        case .basicContainer: colorsMock.basic.onBasicContainer
        case .danger: colorsMock.states.errorPressed
        case .dangerContainer: colorsMock.feedback.onErrorContainer
        case .info: colorsMock.states.infoPressed
        case .infoContainer: colorsMock.feedback.onInfoContainer
        case .main: colorsMock.states.mainPressed
        case .mainContainer: colorsMock.main.onMainContainer
        case .neutral: colorsMock.states.neutralPressed
        case .neutralContainer: colorsMock.feedback.onNeutralContainer
        case .surface: colorsMock.base.onSurface
        case .onSurface: colorsMock.base.onSurface
        case .success: colorsMock.states.successPressed
        case .successContainer: colorsMock.feedback.onSuccessContainer
        case .support: colorsMock.states.supportPressed
        case .supportContainer: colorsMock.support.onSupportContainer
        }
    }

    func expectedColorTokenWithoutHighlighted(from colorsMock: ColorsGeneratedMock) -> any ColorToken {
        switch self {
        case .accent: colorsMock.accent.accent
        case .accentContainer: colorsMock.accent.onAccentContainer
        case .onAccentContainer: colorsMock.accent.onAccentContainer
        case .alert: colorsMock.feedback.alert
        case .alertContainer: colorsMock.feedback.onAlertContainer
        case .basic: colorsMock.basic.basic
        case .basicContainer: colorsMock.basic.onBasicContainer
        case .danger: colorsMock.feedback.error
        case .dangerContainer: colorsMock.feedback.onErrorContainer
        case .info: colorsMock.feedback.info
        case .infoContainer: colorsMock.feedback.onInfoContainer
        case .main: colorsMock.main.main
        case .mainContainer: colorsMock.main.onMainContainer
        case .neutral: colorsMock.feedback.neutral
        case .neutralContainer: colorsMock.feedback.onNeutralContainer
        case .surface: colorsMock.base.onSurface
        case .onSurface: colorsMock.base.onSurface
        case .success: colorsMock.feedback.success
        case .successContainer: colorsMock.feedback.onSuccessContainer
        case .support: colorsMock.support.support
        case .supportContainer: colorsMock.support.onSupportContainer
        }
    }
}
