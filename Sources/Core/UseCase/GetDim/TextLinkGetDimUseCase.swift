//
//  TextLinkGetDimUseCase.swift
//  SparkTextLink
//
//  Created by robin.lemaire on 03/06/2025.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import SparkTheming
import Foundation

// sourcery: AutoMockable, AutoMockTest
protocol TextLinkGetDimUseCaseable {

    // sourcery: dims = "Identical"
    func execute(intent: TextLinkIntent,
                 isHighlighted: Bool,
                 dims: Dims) -> CGFloat
}

struct TextLinkGetDimUseCase: TextLinkGetDimUseCaseable {

    // MARK: - Methods

    func execute(
        intent: TextLinkIntent,
        isHighlighted: Bool,
        dims: Dims
    ) -> CGFloat {
        switch intent {
        case .onAccentContainer, .onSurface:
            isHighlighted ? dims.dim1 : dims.none
        default:
            dims.none
        }
    }
}
