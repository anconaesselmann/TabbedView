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

    private let borderColor: Color = Colors.inactiveTab

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
                    }.background(Colors.interimGapTabs)
                }.background(Colors.inactiveTab)
                onNavigation(selected)
                Spacer()
            }
        }
    }

    private(set) var isShowingTopSpacer: Bool = false

    public func showTopSpacer() -> Self {
        var copy = self
        copy.isShowingTopSpacer = true
        return copy
    }

    private(set) var isShowingBottomSpacer: Bool = false

    public func showBottomSpacer() -> Self {
        var copy = self
        copy.isShowingBottomSpacer = true
        return copy
    }

    @ViewBuilder
    internal var staticView: some View {
        VStack(alignment: .leading, spacing: 0) {
            if isShowingTopSpacer {
                Spacer()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .background(Colors.interimGapTabs)
            }
            HStack(spacing: 1) {
                ForEach(tabs) { path in
                    TabView(path: path, isEnabled: path.isEnabled, tabIsHidden: tabs.count <= 1, selected: $selected, isScrolling: isScrolling, tabsFillWidth: tabsFillWidth) { tab in
                        selected = tab
                    }
                }
            }.background(Colors.interimGapTabs)
            if isShowingBottomSpacer {
                Spacer()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .background(Colors.interimGapTabs)
            }
            onNavigation(selected)
        }
    }
}

//struct TabbedView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabbedView()
//    }
//}
