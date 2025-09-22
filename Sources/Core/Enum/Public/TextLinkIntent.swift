//
//  TextLinkIntent.swift
//  SparkComponentTextLink
//
//  Created by robin.lemaire on 05/12/2023.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

/// The intent of the text link.
public enum TextLinkIntent: CaseIterable {
    case accent
    case accentContainer
    @available(*, deprecated, message: "Use accentContainer instead.")
    case onAccentContainer
    case alert
    case alertContainer
    case basic
    case basicContainer
    case danger
    case dangerContainer
    case info
    case infoContainer
    case main
    case mainContainer
    case neutral
    case neutralContainer
    case surface
    @available(*, deprecated, message: "Use surface instead.")
    case onSurface
    case success
    case successContainer
    case support
    case supportContainer

    // MARK: - Properties

    static public var allCases: [TextLinkIntent] = [
        .accent,
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
}
