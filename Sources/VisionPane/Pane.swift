import UIKit
import SwiftUI

struct PanePreferenceData: Equatable {
    let id: UUID
    let binding: Binding<Bool>
    var presented: Bool
    let view: AnyView
    
    init<C: View>(id: UUID, binding: Binding<Bool>, presented: Bool, view: @escaping () -> C) {
        self.id = id
        self.binding = binding
        self.presented = presented
        self.view = AnyView(view())
    }
    
    static func == (lhs: PanePreferenceData, rhs: PanePreferenceData) -> Bool {
        lhs.id == rhs.id && lhs.binding.wrappedValue == rhs.binding.wrappedValue && lhs.presented == rhs.presented
    }
}

struct PanePreferenceKey: PreferenceKey {
    typealias Value = [PanePreferenceData]
    static var defaultValue: [PanePreferenceData] = []
    static func reduce(value: inout [PanePreferenceData], nextValue: () -> [PanePreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}

public struct DismissPaneAction {
    let isPresented: Binding<Bool>
    func callAsFunction() {
        isPresented.wrappedValue = false
    }
}

struct DismissPaneActionKey: EnvironmentKey {
    static let defaultValue = DismissPaneAction(isPresented: .constant(false))
}

extension EnvironmentValues {
    var _dismissPane: DismissPaneAction {
        get { self[DismissPaneActionKey.self] }
        set { self[DismissPaneActionKey.self] = newValue }
    }
}

extension EnvironmentValues {
    public var dismissPane: DismissPaneAction {
        get { self[DismissPaneActionKey.self] }
    }
}

struct PanePresentationViewModifier<C: View>: ViewModifier {
    
    @Binding
    var isPresented: Bool
    
    var view: () -> C
 
    @Environment(\.dismissPane)
    private var dismissPane
    
    @Namespace
    private var id
    
    func body(content: Content) -> some View {
        content
            .background {
                Color.clear
                    .preference(
                        key: PanePreferenceKey.self,
                        value: [
                            PanePreferenceData(
                                id: .init(),
                                binding: $isPresented,
                                presented: isPresented,
                                view: view
                            )
                        ])
            }
    }
}

struct AuxiliaryPane: View {
    
    var model: DualPaneViewController
    var view: AnyView
    
    var body: some View {
        view
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .glassBackgroundEffect()
            .offset(z: model.isShowingBothPanes ? 0 : -64)
            .opacity(model.isShowingBothPanes ? 1.0 : 0.0)
            .animation(.spring, value: model.isShowingBothPanes)
    }
}

@Observable public class DualPaneViewController: UIViewController, ObservableObject {
    
    let padding: CGFloat = 20
    var width: CGFloat = 320
    
    var paneController: UIHostingController<AuxiliaryPane>?
    var mainController: UIHostingController<AnyView>
    
    var panes: [PanePreferenceData] = []
    
    var isShowingBothPanes = false {
        didSet {
            if oldValue != isShowingBothPanes {
                updateWindowGeometry()
            }
        }
    }
    
    init<C: View>(rootView: C) {
        self.mainController = UIHostingController(rootView: AnyView(EmptyView()))
        super.init(nibName: nil, bundle: nil)
        self.addChildViewController(self.mainController)
        self.paneController = UIHostingController(rootView: .init(model: self, view: AnyView(EmptyView())))
        self.addChildViewController(self.paneController!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update<C: View>(_ view: C) {
        self.mainController.rootView = AnyView(
            view
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .glassBackgroundEffect()
                .onPreferenceChange(PanePreferenceKey.self) { [weak self] preferences in
                    self?.handlePreferenceChange(preferences)
                }
        )
    }
    
    private func addChildViewController<C: View>(_ controller: UIHostingController<C>) {
        addChild(controller)
        view.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
    
    private func handlePreferenceChange(_ preferences: [PanePreferenceData]) {
        if let pane = preferences.last(where: { $0.presented }) {
            let rootView = AnyView(pane.view.environment(\._dismissPane, DismissPaneAction(isPresented: pane.binding)))
            self.paneController?.rootView = AuxiliaryPane(model: self, view: rootView)
            self.isShowingBothPanes = true
        } else if !preferences.isEmpty {
            self.isShowingBothPanes = false
        }
    }
    
    private func updateWindowGeometry() {
        guard let window = view.window, let scene = window.windowScene else { return }
        var newSize = window.bounds.size
        newSize.width += isShowingBothPanes ? (width + padding) : -(width + padding)
        let geometryPreferences = UIWindowScene.GeometryPreferences.Vision()
        geometryPreferences.size = newSize
        scene.requestGeometryUpdate(geometryPreferences)
    }
    
    private func adjustSubviewFrames() {
        let division = view.bounds.divided(atDistance: width + padding, from: .maxXEdge)
        mainController.view.frame = isShowingBothPanes ? division.remainder : view.bounds
        paneController?.view.frame = division.slice.divided(atDistance: padding, from: .minXEdge).remainder
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        adjustSubviewFrames()
    }
    
    public override var preferredContainerBackgroundStyle: UIContainerBackgroundStyle {
        .hidden
    }
}

public struct PaneProvider<Content: View>: UIViewControllerRepresentable {
    
    var content: Content
    
    public func makeUIViewController(context: Context) -> DualPaneViewController {
        DualPaneViewController(rootView: content)
    }
    
    public func updateUIViewController(_ uiViewController: DualPaneViewController, context: Context) {
        uiViewController.update(content)
    }
}

extension View {
    
    /// Presents a pane when a binding to a Boolean value that you
    /// provide is true.
    ///
    /// Use this method when you want to present a pane view to the
    /// user when a Boolean value you provide is true. The example
    /// below displays a pane view of the mockup for a software license
    /// agreement when the user toggles the `isShowingPane` variable by
    /// clicking or tapping on the "Show License Agreement" button:
    ///
    ///     struct ShowLicenseAgreement: View {
    ///         @State private var isShowingSheet = false
    ///         var body: some View {
    ///             Button(action: {
    ///                 isShowingPane.toggle()
    ///             }) {
    ///                 Text("Show License Agreement")
    ///             }
    ///             .pane(isPresented: $isShowingPane) {
    ///                 VStack {
    ///                     Text("License Agreement")
    ///                         .font(.title)
    ///                         .padding(50)
    ///                     Text("""
    ///                             Terms and conditions go here.
    ///                         """)
    ///                         .padding(50)
    ///                     Button("Dismiss",
    ///                            action: { isShowingPane.toggle() })
    ///                 }
    ///             }
    ///         }
    ///     }
    ///     
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether
    ///     to present the pane that you create in the modifier's
    ///     `content` closure.
    ///   - content: A closure that returns the content of the pane.
    public func pane<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        modifier(PanePresentationViewModifier(isPresented: isPresented, view: content))
    }
}
