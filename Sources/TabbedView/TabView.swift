//  Created by Axel Ancona Esselmann on 6/7/23.
//

import SwiftUI

public protocol TabPath: Identifiable, Equatable {
    var title: String { get }

    var isEnabled: Bool { get }
}

public struct TabView<Path>: View where Path: TabPath {

    public let path: Path
    public let isEnabled: Bool
    public let tabIsHidden: Bool

    @Binding
    public var selected: Path

    @State
    private var hovering: Bool = false

    public var isScrolling: Bool

    public var tabsFillWidth: Bool

    public var didSelect: (Path) -> Void

    private var isSelected: Bool {
        path == selected
    }

    public var body: some View {
        Group {
            if !tabIsHidden {
                if isSelected {
                    Text(path.title)
                        .lineLimit(1)
                        .if(tabsFillWidth) {
                            $0.frame(maxWidth: .infinity)
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
//                        .background(Color.detailBackground)
                } else if !isEnabled {
                    Text(path.title)
                        .lineLimit(1)
                        .if(tabsFillWidth) {
                            $0.frame(maxWidth: .infinity)
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(Color("inactiveTab"))
                        .foregroundColor(Color("text.disabled"))
                } else {
                    Text(path.title)
                        .lineLimit(1)
                        .if(tabsFillWidth) {
                            $0.frame(maxWidth: .infinity)
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(Color(hovering ? "hoverTab" : "inactiveTab"))
                        .onTapGesture {
                            didSelect(path)
                        }
                        .onHover { hovering in
                            self.hovering = hovering
                        }
                }
            }
        }
    }
}

//struct TabView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabView()
//    }
//}
