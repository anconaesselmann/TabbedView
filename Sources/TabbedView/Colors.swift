//  Created by Axel Ancona Esselmann on 10/14/23.
//

import SwiftUI

#if os(macOS)
import AppKit

struct Colors {
    static let activeTab: Color = Color(NSColor(named: "activeTab", bundle: Bundle.module)!)
    static let alternateActiveTab: Color = Color(NSColor(named: "alternateActiveTab", bundle: Bundle.module)!)
    static let hoverTab: Color = Color(NSColor(named: "hoverTab", bundle: Bundle.module)!)
    static let inactiveTab: Color = Color(NSColor(named: "inactiveTab", bundle: Bundle.module)!)
    static let interimGapTabs: Color = Color(NSColor(named: "interimGapTabs", bundle: Bundle.module)!)
    static let textDisabled: Color = Color(NSColor(named: "text.disabled", bundle: Bundle.module)!)
}
#else
import UIKit

struct Colors {
    static let activeTab: Color = Color(UIColor(named: "activeTab", in: .module, compatibleWith: nil)!)
    static let alternateActiveTab: Color = Color(UIColor(named: "alternateActiveTab", in: .module, compatibleWith: nil)!)
    static let hoverTab: Color = Color(UIColor(named: "hoverTab", in: .module, compatibleWith: nil)!)
    static let inactiveTab: Color = Color(UIColor(named: "inactiveTab", in: .module, compatibleWith: nil)!)
    static let interimGapTabs: Color = Color(UIColor(named: "interimGapTabs", in: .module, compatibleWith: nil)!)
    static let textDisabled: Color = Color(UIColor(named: "text.disabled", in: .module, compatibleWith: nil)!)
}
#endif
