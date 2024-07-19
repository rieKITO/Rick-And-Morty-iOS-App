//
//  File.swift
//  
//
//  Created by Александр Потёмкин on 17.07.2024.
//

import Foundation
import SwiftUI

struct Colors {
    static let backgroundColor = Color.black
    static let textColor = Color.white
    static let characterCellBackgroundColor = Color(#colorLiteral(red: 0.1143198237, green: 0.1196901128, blue: 0.1169909909, alpha: 1))
    
    static func getStatusColor(character: Character) -> Color {
        let statusColor = if character.status == "Alive" { Color.green }
        else if character.status == "Dead" { Color.red }
        else { Color.gray }
        return statusColor
    }
}
