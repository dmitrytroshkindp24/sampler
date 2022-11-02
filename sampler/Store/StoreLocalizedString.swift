//
//  Created by Karina Lipnyagova on 04.05.2021
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

import Foundation
import DrumPads24LocalizationCore

private enum Constants {
    static let tableName = "StoreLocalizable"
}

public func StoreLocalizedString(_ key: String) -> String {

    return localizedString(key, tableName: Constants.tableName)
}
