//
//  ButtonComponent.swift
//  The Next View
//
//  Created by UTF LABS on 24/11/2025.
//

import SwiftUI

extension Text{
    func buttonUI() -> some View {
        self   .frame(width: 120, height: 50)
        .foregroundStyle(.buttonText)
        .bold()
        .background{
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(  .buttonBorder , lineWidth: 3)
        }
    }
}
