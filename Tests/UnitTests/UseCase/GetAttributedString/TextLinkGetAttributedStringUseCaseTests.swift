//
//  TextLinkGetAttributedStringTests.swift
//  SparkTextLinkUnitTests
//
//  Created by robin.lemaire on 05/12/2023.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkTextLink
@_spi(SI_SPI) @testable import SparkTextLinkTesting
@_spi(SI_SPI) import SparkCommon
@_spi(SI_SPI) import SparkThemingTesting

final class TextLinkGetAttributedStringTests: XCTestCase {

    // MARK: - UIKit Tests

    func test_execute_for_UIKit_without_range() {
        // GIVEN
        let mock = Mock()
        let useCase = mock.createUseCase()

        let expectedAttributedString = NSMutableAttributedString(
            mock: mock,
            isRange: false
        )

        // WHEN
        let attributedString = useCase.execute(
            frameworkType: .uiKit,
            text: mock.textMock,
            textColorToken: mock.colorTokenMock,
            textHighlightRange: nil,
            isHighlighted: mock.isHighlightedMock,
            variant: mock.variantMock,
            typographies: mock.typographiesMock
        )

        // THEN
        XCTAssertEqual(
            attributedString.leftValue,
            expectedAttributedString,
            "Wrong attributed string"
        )

        // Use Case
        self.testUseCase(from: mock)
    }

    func test_execute_for_UIKit_with_range() {
        // GIVEN
        for range in RangePosition.allCases {
            let mock = Mock(rangePosition: range)
            let useCase = mock.createUseCase()

            let expectedAttributedString = NSMutableAttributedString(
                mock: mock,
                isRange: true
            )

            // WHEN
            let attributedString = useCase.execute(
                frameworkType: .uiKit,
                text: mock.textMock,
                textColorToken: mock.colorTokenMock,
                textHighlightRange: mock.textHighlightRangeMock,
                isHighlighted: mock.isHighlightedMock,
                variant: mock.variantMock,
                typographies: mock.typographiesMock
            )

            // THEN
            XCTAssertEqual(
                attributedString.leftValue,
                expectedAttributedString,
                "Wrong attributed string for \(range.rawValue) range position"
            )

            // Use Case
            self.testUseCase(from: mock)
        }
    }

    // MARK: - SwiftUI Test

    func test_execute_for_SwiftUI_without_range() {
        // GIVEN
        let mock = Mock()
        let useCase = mock.createUseCase()

        let expectedAttributedString = AttributedString(
            mock: mock,
            isRange: false
        )

        // WHEN
        let attributedString = useCase.execute(
            frameworkType: .swiftUI,
            text: mock.textMock,
            textColorToken: mock.colorTokenMock,
            textHighlightRange: nil,
            isHighlighted: mock.isHighlightedMock,
            variant: mock.variantMock,
            typographies: mock.typographiesMock
        )

        // THEN
        XCTAssertEqual(
            attributedString.rightValue,
            expectedAttributedString,
            "Wrong attributed string"
        )

        // Use Case
        self.testUseCase(from: mock)
    }

    func test_execute_for_SwiftUI_with_range() throws {
        // GIVEN
        for range in RangePosition.allCases {
            let mock = Mock(rangePosition: range)
            let useCase = mock.createUseCase()

            var expectedAttributedString = AttributedString(
                mock: mock,
                isRange: true
            )

            let textHighlightRange = try XCTUnwrap(
                Range(mock.textHighlightRangeMock, in: expectedAttributedString),
                "Range should not be nil"
            )
            expectedAttributedString[textHighlightRange].font = mock.typographiesMock.highlight.font
            expectedAttributedString[textHighlightRange].underlineStyle = mock.underlineStyleMock

            // WHEN
            let attributedString = useCase.execute(
                frameworkType: .swiftUI,
                text: mock.textMock,
                textColorToken: mock.colorTokenMock,
                textHighlightRange: mock.textHighlightRangeMock,
                isHighlighted: mock.isHighlightedMock,
                variant: mock.variantMock,
                typographies: mock.typographiesMock
            )

            // THEN
            XCTAssertEqual(
                attributedString.rightValue,
                expectedAttributedString,
                "Wrong attributed string for \(range.rawValue) range position"
            )

            // Use Case
            self.testUseCase(from: mock)
        }
    }
}

// MARK: - Use Case Testing

private extension TextLinkGetAttributedStringTests {

    func testUseCase(from mock: Mock) {
        TextLinkGetUnderlineUseCaseableMockTest.XCTAssert(
            mock.getUnderlineUseCaseMock,
            expectedNumberOfCalls: 1,
            givenVariant: mock.variantMock,
            givenIsHighlighted: mock.isHighlightedMock,
            expectedReturnValue: mock.underlineStyleMock
        )
    }
}

// MARK: - Enum

private enum RangePosition: String, CaseIterable {
    case start
    case end
}

// MARK: - Mock

private final class Mock {

    let textMock = "My Text"
    var rangePosition: RangePosition
    lazy var textHighlightRangeMock: NSRange = {
        switch self.rangePosition {
        case .start:
            NSRange(location: 0, length: 2)
        case .end:
            NSRange(location: 3, length: 4)
        }
    }()
    let variantMock: TextLinkVariant = .underline
    let typographiesMock: TextLinkTypographies = .mocked()
    let isHighlightedMock: Bool = true
    let colorTokenMock = ColorTokenGeneratedMock()

    let underlineStyleMock: NSUnderlineStyle = .double

    init(rangePosition: RangePosition = .start) {
        self.rangePosition = rangePosition
    }

    lazy var getUnderlineUseCaseMock: TextLinkGetUnderlineUseCaseableGeneratedMock = {
        let mock = TextLinkGetUnderlineUseCaseableGeneratedMock()
        mock.executeWithVariantAndIsHighlightedReturnValue = self.underlineStyleMock
        return mock
    }()

    func createUseCase() -> TextLinkGetAttributedStringUseCase {
        TextLinkGetAttributedStringUseCase(
            getUnderlineUseCaseable: self.getUnderlineUseCaseMock
        )
    }
}

// MARK: - Extension

private extension NSMutableAttributedString {

    convenience init(mock: Mock, isRange: Bool) {
        let highlightAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: mock.colorTokenMock.uiColor,
            .font: mock.typographiesMock.highlight.uiFont,
            .underlineStyle: mock.underlineStyleMock.rawValue,
            .underlineColor: mock.colorTokenMock.uiColor,
        ]

        let attributes: [NSAttributedString.Key: Any]
        if isRange {
            attributes = [
                .foregroundColor: mock.colorTokenMock.uiColor,
                .font: mock.typographiesMock.normal.uiFont
            ]
        } else {
            attributes = highlightAttributes
        }

        self.init(
            string: mock.textMock,
            attributes: attributes
        )

        if isRange {
            self.addAttributes(
                highlightAttributes,
                range: mock.textHighlightRangeMock
            )
        }
    }
}

private extension AttributedString {

    init(mock: Mock, isRange: Bool) {
        self.init(mock.textMock)

        if isRange {
            self.foregroundColor = mock.colorTokenMock.color
            self.font = mock.typographiesMock.normal.font
        } else {
            self.foregroundColor = mock.colorTokenMock.color
            self.font = mock.typographiesMock.highlight.font
            self.underlineStyle = mock.underlineStyleMock
        }
    }
}
