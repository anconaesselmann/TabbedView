//  Created by Axel Ancona Esselmann on 6/12/23.
//

import SwiftUI

// https://www.avanderlee.com/swiftui/conditional-view-modifier/
extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
}
