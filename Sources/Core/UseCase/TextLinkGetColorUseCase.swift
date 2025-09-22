//
//  TextLinkGetColorUseCase.swift
//  SparkComponentTextLink
//
//  Created by robin.lemaire on 05/12/2023.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import SparkTheming

// sourcery: AutoMockable, AutoMockTest
protocol TextLinkGetColorUseCaseable {

    // sourcery: colors = "Identical", return = "Identical"
    func execute(
        intent: TextLinkIntent,
        isHighlighted: Bool,
        colors: any Colors
    ) -> any ColorToken
}

struct TextLinkGetColorUseCase: TextLinkGetColorUseCaseable {

    // MARK: - Methods

    func execute(
        intent: TextLinkIntent,
        isHighlighted: Bool,
        colors: any Colors
    ) -> any ColorToken {
        return switch intent {

        case .accent: isHighlighted ? colors.states.accentPressed : colors.accent.accent
        case .accentContainer, .onAccentContainer: colors.accent.onAccentContainer

        case .alert: isHighlighted ? colors.states.alertPressed : colors.feedback.alert
        case .alertContainer: colors.feedback.onAlertContainer

        case .basic: isHighlighted ? colors.states.basicPressed : colors.basic.basic
        case .basicContainer: colors.basic.onBasicContainer

        case .danger: isHighlighted ? colors.states.errorPressed : colors.feedback.error
        case .dangerContainer: colors.feedback.onErrorContainer

        case .info: isHighlighted ? colors.states.infoPressed : colors.feedback.info
        case .infoContainer: colors.feedback.onInfoContainer

        case .main: isHighlighted ? colors.states.mainPressed : colors.main.main
        case .mainContainer: colors.main.onMainContainer

        case .neutral: isHighlighted ? colors.states.neutralPressed : colors.feedback.neutral
        case .neutralContainer: colors.feedback.onNeutralContainer

        case .surface, .onSurface: colors.base.onSurface

        case .success: isHighlighted ? colors.states.successPressed : colors.feedback.success
        case .successContainer: colors.feedback.onSuccessContainer

        case .support: isHighlighted ? colors.states.supportPressed : colors.support.support
        case .supportContainer: colors.support.onSupportContainer
        }
    }
}
