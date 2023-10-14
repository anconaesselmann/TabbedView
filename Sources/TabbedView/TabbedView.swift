//  Created by Axel Ancona Esselmann on 6/7/23.
//

import SwiftUI

public struct TabbedView<Path, Content>: View where Path: TabPath, Content: View {

    public enum TabBehaviors: Int, Hashable {
        case hideSingleTab
        case tabsDontFillWidth
        case tabsAreScrolling
    }

    public var tabs: [Path]

    @Binding
    public var selected: Path

    private var isScrolling: Bool {
        tabBehaviours.contains(.tabsAreScrolling)
    }

    public var tabsFillWidth: Bool {
        !tabBehaviours.contains(.tabsDontFillWidth)
    }

    public var tabBehaviours: Set<TabBehaviors> = []

    @ViewBuilder
    public let onNavigation: (Path) -> Content

    public init(tabs: [Path], selected: Binding<Path>, behaviours: Set<TabBehaviors>, @ViewBuilder onNavigation: @escaping (Path) -> Content) {
        self.tabBehaviours = behaviours
        self.tabs = tabs
        _selected = selected
        self.onNavigation = onNavigation
    }

    public init(tabs: [Path], selected: Binding<Path>, isScrolling: Bool = false, tabsFillWidth: Bool = true, singleTabIsHidden: Bool = true, @ViewBuilder onNavigation: @escaping (Path) -> Content) {
        var tabBehaviours: Set<TabBehaviors> = []
        if isScrolling {
            tabBehaviours.insert(.tabsAreScrolling)
        }
        if !tabsFillWidth {
            tabBehaviours.insert(.tabsDontFillWidth)
        }
        if singleTabIsHidden {
            tabBehaviours.insert(.hideSingleTab)
        }
        self.init(tabs: tabs, selected: selected, behaviours: tabBehaviours, onNavigation: onNavigation)
    }

    private let borderColor: Color = Color("inactiveTab")

    public var body: some View {
        if isScrolling {
            scrollingView
        } else {
            staticView
        }
    }

    @ViewBuilder
    internal var scrollingView: some View {
        if tabs.isEmpty {

        } else {
            VStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 1) {
                        ForEach(tabs) { path in
                            TabView(path: path, isEnabled: path.isEnabled, tabIsHidden: tabs.count <= 1, selected: $selected, isScrolling: isScrolling, tabsFillWidth: tabsFillWidth) { tab in
                                selected = tab
                            }
                        }
                    }.background(Color("interimGapTabs"))
                }.background(Color("inactiveTab"))
                onNavigation(selected)
                Spacer()
            }
        }
    }

    @ViewBuilder
    internal var staticView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 1) {
                ForEach(tabs) { path in
                    TabView(path: path, isEnabled: path.isEnabled, tabIsHidden: tabs.count <= 1, selected: $selected, isScrolling: isScrolling, tabsFillWidth: tabsFillWidth) { tab in
                        selected = tab
                    }
                }
            }.background(Color("interimGapTabs"))
            onNavigation(selected)
        }
    }
}

//struct TabbedView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabbedView()
//    }
//}
