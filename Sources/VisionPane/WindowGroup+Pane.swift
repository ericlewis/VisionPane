import SwiftUI

extension WindowGroup {
    /// Creates a window group with an identifier.
    ///
    /// The window group uses the given view as a
    /// template to form the content of each window in the group.
    ///
    /// - Parameters:
    ///   - id: A string that uniquely identifies the window group. Identifiers
    ///     must be unique among the window groups in your app.
    ///   - content: A closure that creates the content for each instance
    ///     of the group.
    public static func Pane<T>(id: String, @ViewBuilder content: @escaping () -> T) -> some Scene where Content == PaneProvider<T> {
        WindowGroup(id: id) { PaneProvider(content: content()) }
    }

    /// Creates a window group with a text view title and an identifier.
    ///
    /// The window group uses the specified content as a
    /// template to create each window in the group.
    /// The system uses the title to distinguish the window group in the user
    /// interface, such as in the name of commands associated with the group.
    ///
    /// > Important: The system ignores any text styling that you apply to
    ///   the ``Text`` view title, like bold or italics. However, you can use
    ///   the formatting controls that the view offers, like for localization,
    ///   dates, and numerical representations.
    ///
    /// - Parameters:
    ///   - title: The ``Text`` view to use for the group's title.
    ///   - id: A string that uniquely identifies the window group. Identifiers
    ///     must be unique among the window groups in your app.
    ///   - content: A closure that creates the content for each instance
    ///     of the group.
    public static func Pane<T>(_ title: Text, id: String, @ViewBuilder content: @escaping () -> T) -> some Scene where Content == PaneProvider<T> {
        WindowGroup(title, id: id) { PaneProvider(content: content()) }
    }

    /// Creates a window group with a localized title string and an
    /// identifier.
    ///
    /// The window group uses the specified content as a
    /// template to create each window in the group.
    /// The system uses the title to distinguish the window group in the user
    /// interface, such as in the name of commands associated with the group.
    ///
    /// - Parameters:
    ///   - titleKey: The title key to use for the title of the group.
    ///   - id: A string that uniquely identifies the window group. Identifiers
    ///     must be unique among the window groups in your app.
    ///   - content: A closure that creates the content for each instance
    ///     of the group.
    public static func Pane<T>(_ titleKey: LocalizedStringKey, id: String, @ViewBuilder content: @escaping () -> T) -> some Scene where Content == PaneProvider<T> {
        WindowGroup(titleKey, id: id) { PaneProvider(content: content()) }
    }

    /// Returns a window group with a title string and an identifier.
    ///
    /// The window group uses the specified content as a
    /// template to create each window in the group.
    /// The system uses the title to distinguish the window group in the user
    /// interface, such as in the name of commands associated with the group.
    ///
    /// - Parameters:
    ///   - title: The string to use for the title of the group.
    ///   - id: A string that uniquely identifies the window group. Identifiers
    ///     must be unique among the window groups in your app.
    ///   - content: A closure that creates the content for each instance
    ///     of the group.
    public static func Pane<S, T>(_ title: S, id: String, @ViewBuilder content: @escaping () -> T) -> some Scene where S : StringProtocol, Content == PaneProvider<T> {
        WindowGroup(title, id: id) { PaneProvider(content: content()) }
    }

    /// Returns a window group.
    ///
    /// The window group uses the given view as a template to form the
    /// content of each window in the group.
    ///
    /// - Parameter content: A closure that creates the content for each
    ///   instance of the group.
    public static func Pane<T>(@ViewBuilder content: @escaping () -> T) -> some Scene where Content == PaneProvider<T> {
        WindowGroup { PaneProvider(content: content()) }
    }

    /// Returns a window group with a text view title.
    ///
    /// The window group uses the given view as a
    /// template to form the content of each window in the group.
    /// The system uses the title to distinguish the window group in the user
    /// interface, such as in the name of commands associated with the group.
    ///
    /// > Important: The system ignores any text styling that you apply to
    ///   the ``Text`` view title, like bold or italics. However, you can use
    ///   the formatting controls that the view offers, like for localization,
    ///   dates, and numerical representations.
    ///
    /// - Parameters:
    ///   - title: The ``Text`` view to use for the group's title.
    ///   - content: A closure that creates the content for each instance
    ///     of the group.
    public static func Pane<T>(_ title: Text, @ViewBuilder content: @escaping () -> T) -> some Scene where Content == PaneProvider<T> {
        WindowGroup(title) { PaneProvider(content: content()) }
    }

    /// Returns a window group with a localized title string.
    ///
    /// The window group uses the specified content as a
    /// template to create each window in the group.
    /// The system uses the title to distinguish the window group in the user
    /// interface, such as in the name of commands associated with the group.
    ///
    /// - Parameters:
    ///   - titleKey: The title key to use for the group's title.
    ///   - content: A closure that creates the content for each instance
    ///     of the group.
    public static func Pane<T>(_ titleKey: LocalizedStringKey, @ViewBuilder content: @escaping () -> T) -> some Scene where Content == PaneProvider<T> {
        WindowGroup(titleKey) { PaneProvider(content: content()) }
    }

    /// Returns a window group with a title string.
    ///
    /// The window group uses the specified content as a
    /// template to create each window in the group.
    /// The system uses the title to distinguish the window group in the user
    /// interface, such as in the name of commands associated with the group.
    ///
    /// - Parameters:
    ///   - title: The string to use for the title of the group.
    ///   - content: A closure that creates the content for each instance
    ///     of the group.
    ///         public static func Pane<T>(@ViewBuilder content: @escaping () -> T) -> some Scene where Content == PaneProvider<T> {

    public static func Pane<S, T>(_ title: S, @ViewBuilder content: @escaping () -> T) -> some Scene where S : StringProtocol, Content == PaneProvider<T> {
        WindowGroup(title) { PaneProvider(content: content()) }
    }
    
    /// Returns a data-presenting window group with an identifier.
    ///
    /// The window group uses the specified content as a
    /// template to create each window in the group.
    ///
    /// SwiftUI creates a window from the group when you present a value
    /// of the specified type using the ``EnvironmentValues/openWindow`` action.
    ///
    /// - Parameters:
    ///   - id: A string that uniquely identifies the window group. Identifiers
    ///     must be unique among the window groups in your app.
    ///   - type: The type of presented data this window group accepts.
    ///   - content: A closure that creates the content for each instance
    ///     of the group. The closure receives a binding to the value that you
    ///     pass into the ``EnvironmentValues/openWindow`` action when you open
    ///     the window. SwiftUI automatically persists and restores the value
    ///     of this binding as part of the state restoration process.
    public static func Pane<D, C>(id: String, for type: D.Type, @ViewBuilder content: @escaping (Binding<D?>) -> C) -> some Scene where Content == PresentedWindowContent<D, PaneProvider<C>>, D : Decodable, D : Encodable, D : Hashable, C : View {
        WindowGroup(id: id, for: type) { d in PaneProvider(content: content(d)) }
    }

    /// Returns a data-presenting window group with a text view title and an
    /// identifier.
    ///
    /// The window group uses the specified content as a
    /// template to create each window in the group.
    ///
    /// The system uses the title to distinguish the window group in the user
    /// interface, such as in the name of commands associated with the group.
    ///
    /// > Important: The system ignores any text styling that you apply to
    ///   the ``Text`` view title, like bold or italics. However, you can use
    ///   the formatting controls that the view offers, like for localization,
    ///   dates, and numerical representations.
    ///
    /// SwiftUI creates a window from the group when you present a value
    /// of the specified type using the ``EnvironmentValues/openWindow`` action.
    ///
    /// - Parameters:
    ///   - title: The ``Text`` view to use for the group's title.
    ///   - id: A string that uniquely identifies the window group. Identifiers
    ///     must be unique among the window groups in your app.
    ///   - type: The type of presented data this window group accepts.
    ///   - content: A closure that creates the content for each instance
    ///     of the group. The closure receives a binding to the value that you
    ///     pass into the ``EnvironmentValues/openWindow`` action when you open
    ///     the window. SwiftUI automatically persists and restores the value
    ///     of this binding as part of the state restoration process.
    static func Pane<D, C>(_ title: Text, id: String, for type: D.Type, @ViewBuilder content: @escaping (Binding<D?>) -> C) -> some Scene where Content == PresentedWindowContent<D, PaneProvider<C>>, D : Decodable, D : Encodable, D : Hashable, C : View {
        WindowGroup(title, id: id, for: type) { d in PaneProvider(content: content(d)) }
    }

    /// Returns a data-presenting window group with a localized title
    /// string and an identifier.
    ///
    /// The window group uses the specified content as a
    /// template to create each window in the group.
    ///
    /// The system uses the title to distinguish the window group in the user
    /// interface, such as in the name of commands associated with the group.
    ///
    /// SwiftUI creates a window from the group when you present a value
    /// of the specified type using the ``EnvironmentValues/openWindow`` action.
    ///
    /// - Parameters:
    ///   - titleKey: The title key to use for the group's title.
    ///   - id: A string that uniquely identifies the window group. Identifiers
    ///     must be unique among the window groups in your app.
    ///   - type: The type of presented data this window group accepts.
    ///   - content: A closure that creates the content for each instance
    ///     of the group. The closure receives a binding to the value that you
    ///     pass into the ``EnvironmentValues/openWindow`` action when you open
    ///     the window. SwiftUI automatically persists and restores the value
    ///     of this binding as part of the state restoration process.
    public static func Pane<D, C>(_ titleKey: LocalizedStringKey, id: String, for type: D.Type, @ViewBuilder content: @escaping (Binding<D?>) -> C) -> some Scene where Content == PresentedWindowContent<D, PaneProvider<C>>, D : Decodable, D : Encodable, D : Hashable, C : View {
        WindowGroup(titleKey, id: id, for: type) { d in PaneProvider(content: content(d)) }
    }

    /// Returns a data-presenting window group with a title string and an
    /// identifier.
    ///
    /// The window group uses the specified content as a
    /// template to create each window in the group.
    ///
    /// The system uses the title to distinguish the window group in the user
    /// interface, such as in the name of commands associated with the group.
    ///
    /// SwiftUI creates a window from the group when you present a value
    /// of the specified type using the ``EnvironmentValues/openWindow`` action.
    ///
    /// - Parameters:
    ///   - title: The string to use for the title of the group.
    ///   - id: A string that uniquely identifies the window group. Identifiers
    ///     must be unique among the window groups in your app.
    ///   - type: The type of presented data this window group accepts.
    ///   - content: A closure that creates the content for each instance
    ///     of the group. The closure receives a binding to the value that you
    ///     pass into the ``EnvironmentValues/openWindow`` action when you open
    ///     the window. SwiftUI automatically persists and restores the value
    ///     of this binding as part of the state restoration process.
    public static func Pane<S, D, C>(_ title: S, id: String, for type: D.Type, @ViewBuilder content: @escaping (Binding<D?>) -> C) -> some Scene where Content == PresentedWindowContent<D, PaneProvider<C>>, S : StringProtocol, D : Decodable, D : Encodable, D : Hashable, C : View {
        WindowGroup(title, id: id, for: type) { d in PaneProvider(content: content(d)) }
    }

    /// Returns a data-presenting window group.
    ///
    /// The window group uses the given view as a template to form the
    /// content of each window in the group.
    ///
    /// SwiftUI creates a window from the group when you present a value
    /// of the specified type using the ``EnvironmentValues/openWindow`` action.
    ///
    /// - Parameters:
    ///   - type: The type of presented data this window group accepts.
    ///   - content: A closure that creates the content for each instance
    ///     of the group. The closure receives a binding to the value that you
    ///     pass into the ``EnvironmentValues/openWindow`` action when you open
    ///     the window. SwiftUI automatically persists and restores the value
    ///     of this binding as part of the state restoration process.
    public static func Pane<D, C>(for type: D.Type, @ViewBuilder content: @escaping (Binding<D?>) -> C) -> some Scene where Content == PresentedWindowContent<D, PaneProvider<C>>, D : Decodable, D : Encodable, D : Hashable, C : View {
        WindowGroup(for: type) { d in PaneProvider(content: content(d)) }
    }

    /// Returns a data-presenting window group with a text view title.
    ///
    /// The window group uses the given view as a
    /// template to form the content of each window in the group.
    ///
    /// The system uses the title to distinguish the window group in the user
    /// interface, such as in the name of commands associated with the group.
    ///
    /// > Important: The system ignores any text styling that you apply to
    ///   the ``Text`` view title, like bold or italics. However, you can use
    ///   the formatting controls that the view offers, like for localization,
    ///   dates, and numerical representations.
    ///
    /// SwiftUI creates a window from the group when you present a value
    /// of the specified type using the ``EnvironmentValues/openWindow`` action.
    ///
    /// - Parameters:
    ///   - title: The ``Text`` view to use for the group's title.
    ///   - type: The type of presented data this window group accepts.
    ///   - content: A closure that creates the content for each instance
    ///     of the group. The closure receives a binding to the value that you
    ///     pass into the ``EnvironmentValues/openWindow`` action when you open
    ///     the window. SwiftUI automatically persists and restores the value
    ///     of this binding as part of the state restoration process.
    public static func Pane<D, C>(_ title: Text, for type: D.Type, @ViewBuilder content: @escaping (Binding<D?>) -> C) -> some Scene where Content == PresentedWindowContent<D, PaneProvider<C>>, D : Decodable, D : Encodable, D : Hashable, C : View {
        WindowGroup(title, for: type) { d in PaneProvider(content: content(d)) }
    }

    /// Returns a data-presenting window group with a localized title
    /// string.
    ///
    /// The window group uses the specified content as a
    /// template to create each window in the group.
    ///
    /// The system uses the title to distinguish the window group in the user
    /// interface, such as in the name of commands associated with the group.
    ///
    /// SwiftUI creates a window from the group when you present a value
    /// of the specified type using the ``EnvironmentValues/openWindow`` action.
    ///
    /// - Parameters:
    ///   - titleKey: The title key to use for the group's title.
    ///   - type: The type of presented data this window group accepts.
    ///   - content: A closure that creates the content for each instance
    ///     of the group. The closure receives a binding to the value that you
    ///     pass into the ``EnvironmentValues/openWindow`` action when you open
    ///     the window. SwiftUI automatically persists and restores the value
    ///     of this binding as part of the state restoration process.
    public static func Pane<D, C>(_ titleKey: LocalizedStringKey, for type: D.Type, @ViewBuilder content: @escaping (Binding<D?>) -> C) -> some Scene where Content == PresentedWindowContent<D, PaneProvider<C>>, D : Decodable, D : Encodable, D : Hashable, C : View {
        WindowGroup(titleKey, for: type) { d in PaneProvider(content: content(d)) }
    }

    /// Returns a data-presenting window group with a title string.
    ///
    /// The window group uses the specified content as a
    /// template to create each window in the group.
    ///
    /// The system uses the title to distinguish the window group in the user
    /// interface, such as in the name of commands associated with the group.
    ///
    /// SwiftUI creates a window from the group when you present a value
    /// of the specified type using the ``EnvironmentValues/openWindow`` action.
    ///
    /// - Parameters:
    ///   - title: The string to use for the title of the group.
    ///   - type: The type of presented data this window group accepts.
    ///   - content: A closure that creates the content for each instance
    ///     of the group. The closure receives a binding to the value that you
    ///     pass into the ``EnvironmentValues/openWindow`` action when you open
    ///     the window. SwiftUI automatically persists and restores the value
    ///     of this binding as part of the state restoration process.
    public static func Pane<S, D, C>(_ title: S, for type: D.Type, @ViewBuilder content: @escaping (Binding<D?>) -> C) -> some Scene where Content == PresentedWindowContent<D, PaneProvider<C>>, S : StringProtocol, D : Decodable, D : Encodable, D : Hashable, C : View {
        WindowGroup(title, for: type) { d in PaneProvider(content: content(d)) }
    }

    /// Returns a data-presenting window group with an identifier and a default
    /// value.
    ///
    /// The window group uses the given view as a
    /// template to form the content of each window in the group.
    ///
    /// SwiftUI creates a window from the group when you present a value
    /// of the specified type using the ``EnvironmentValues/openWindow`` action.
    ///
    /// - Parameters:
    ///   - id: A string that uniquely identifies the window group. Identifiers
    ///     must be unique among the window groups in your app.
    ///   - type: The type of presented data this window group accepts.
    ///   - content: A closure that creates the content for each instance
    ///     of the group. The closure receives a binding to the value that you
    ///     pass into the ``EnvironmentValues/openWindow`` action when you open
    ///     the window. SwiftUI automatically persists and restores the value
    ///     of this binding as part of the state restoration process.
    ///   - defaultValue: A closure that returns a default value to present.
    ///     SwiftUI calls this closure when it has no data to provide, like
    ///     when someone opens a new window from the File > New Window menu
    ///     item.
    public static func Pane<D, C>(id: String, for type: D.Type = D.self, @ViewBuilder content: @escaping (Binding<D>) -> C, defaultValue: @escaping () -> D) -> some Scene where Content == PresentedWindowContent<D, PaneProvider<C>>, D : Decodable, D : Encodable, D : Hashable, C : View {
        WindowGroup(id: id, for: type, content: { d in PaneProvider(content: content(d)) }, defaultValue: defaultValue)
    }

    /// Returns a data-presenting window group with a text view title, an
    /// identifier, and a default value.
    ///
    /// The window group uses the specified content as a
    /// template to create each window in the group.
    ///
    /// The system uses the title to distinguish the window group in the user
    /// interface, such as in the name of commands associated with the group.
    ///
    /// > Important: The system ignores any text styling that you apply to
    ///   the ``Text`` view title, like bold or italics. However, you can use
    ///   the formatting controls that the view offers, like for localization,
    ///   dates, and numerical representations.
    ///
    /// SwiftUI creates a window from the group when you present a value
    /// of the specified type using the ``EnvironmentValues/openWindow`` action.
    ///
    /// - Parameters:
    ///   - title: The ``Text`` view to use for the group's title.
    ///   - id: A string that uniquely identifies the window group. Identifiers
    ///     must be unique among the window groups in your app.
    ///   - type: The type of presented data this window group accepts.
    ///   - content: A closure that creates the content for each instance
    ///     of the group. The closure receives a binding to the value that you
    ///     pass into the ``EnvironmentValues/openWindow`` action when you open
    ///     the window. SwiftUI automatically persists and restores the value
    ///     of this binding as part of the state restoration process.
    ///   - defaultValue: A closure that returns a default value to present.
    ///     SwiftUI calls this closure when it has no data to provide, like
    ///     when someone opens a new window from the File > New Window menu
    ///     item.
    public static func Pane<D, C>(_ title: Text, id: String, for type: D.Type = D.self, @ViewBuilder content: @escaping (Binding<D>) -> C, defaultValue: @escaping () -> D) -> some Scene where Content == PresentedWindowContent<D, PaneProvider<C>>, D : Decodable, D : Encodable, D : Hashable, C : View {
        WindowGroup(title, id: id, for: type, content: { d in PaneProvider(content: content(d)) }, defaultValue: defaultValue)
    }

    /// Returns a data-presenting window group with a localized title
    /// string, an identifier, and a default value.
    ///
    /// The window group uses the specified content as a
    /// template to create each window in the group.
    ///
    /// The system uses the title to distinguish the window group in the user
    /// interface, such as in the name of commands associated with the group.
    ///
    /// SwiftUI creates a window from the group when you present a value
    /// of the specified type using the ``EnvironmentValues/openWindow`` action.
    ///
    /// - Parameters:
    ///   - titleKey: The title key to use for the group's title.
    ///   - id: A string that uniquely identifies the window group. Identifiers
    ///     must be unique among the window groups in your app.
    ///   - type: The type of presented data this window group accepts.
    ///   - content: A closure that creates the content for each instance
    ///     of the group. The closure receives a binding to the value that you
    ///     pass into the ``EnvironmentValues/openWindow`` action when you open
    ///     the window. SwiftUI automatically persists and restores the value
    ///     of this binding as part of the state restoration process.
    ///   - defaultValue: A closure that returns a default value to present.
    ///     SwiftUI calls this closure when it has no data to provide, like
    ///     when someone opens a new window from the File > New Window menu
    ///     item.
    public static func Pane<D, C>(_ titleKey: LocalizedStringKey, id: String, for type: D.Type = D.self, @ViewBuilder content: @escaping (Binding<D>) -> C, defaultValue: @escaping () -> D) -> some Scene where Content == PresentedWindowContent<D, PaneProvider<C>>, D : Decodable, D : Encodable, D : Hashable, C : View {
        WindowGroup(titleKey, id: id, for: type, content: { d in PaneProvider(content: content(d)) }, defaultValue: defaultValue)
    }

    /// Returns a data-presenting window group with a title string, an
    /// identifier, and a default value.
    ///
    /// The window group uses the specified content as a
    /// template to create each window in the group.
    ///
    /// The system uses the title to distinguish the window group in the user
    /// interface, such as in the name of commands associated with the group.
    ///
    /// SwiftUI creates a window from the group when you present a value
    /// of the specified type using the ``EnvironmentValues/openWindow`` action.
    ///
    /// - Parameters:
    ///   - title: The string to use for the title of the group.
    ///   - id: A string that uniquely identifies the window group. Identifiers
    ///     must be unique among the window groups in your app.
    ///   - type: The type of presented data this window group accepts.
    ///   - content: A closure that creates the content for each instance
    ///     of the group. The closure receives a binding to the value that you
    ///     pass into the ``EnvironmentValues/openWindow`` action when you open
    ///     the window. SwiftUI automatically persists and restores the value
    ///     of this binding as part of the state restoration process.
    ///   - defaultValue: A closure that returns a default value to present.
    ///     SwiftUI calls this closure when it has no data to provide, like
    ///     when someone opens a new window from the File > New Window menu
    ///     item.
    public static func Pane<S, D, C>(_ title: S, id: String, for type: D.Type = D.self, @ViewBuilder content: @escaping (Binding<D>) -> C, defaultValue: @escaping () -> D) -> some Scene where Content == PresentedWindowContent<D, PaneProvider<C>>, S : StringProtocol, D : Decodable, D : Encodable, D : Hashable, C : View {
        WindowGroup(title, id: id, for: type, content: { d in PaneProvider(content: content(d)) }, defaultValue: defaultValue)
    }

    /// Returns a data-presenting window group with a default value.
    ///
    /// The window group using the given view as a template to form the
    /// content of each window in the group.
    ///
    /// SwiftUI creates a window from the group when you present a value
    /// of the specified type using the ``EnvironmentValues/openWindow`` action.
    ///
    /// - Parameters:
    ///   - type:The type of presented data this window group accepts.
    ///   - content: A closure that creates the content for each instance
    ///     of the group. The closure receives a binding to the value that you
    ///     pass into the ``EnvironmentValues/openWindow`` action when you open
    ///     the window. SwiftUI automatically persists and restores the value
    ///     of this binding as part of the state restoration process.
    ///   - defaultValue: A closure that returns a default value to present.
    ///     SwiftUI calls this closure when it has no data to provide, like
    ///     when someone opens a new window from the File > New Window menu
    ///     item.
    public static func Pane<D, C>(for type: D.Type = D.self, @ViewBuilder content: @escaping (Binding<D>) -> C, defaultValue: @escaping () -> D) -> some Scene where Content == PresentedWindowContent<D, PaneProvider<C>>, D : Decodable, D : Encodable, D : Hashable, C : View {
        WindowGroup(for: type, content: { d in PaneProvider(content: content(d)) }, defaultValue: defaultValue)
    }

    /// Returns a data-presenting window group with a text view title and a
    /// default value.
    ///
    /// The window group uses the given view as a
    /// template to form the content of each window in the group.
    ///
    /// The system uses the title to distinguish the window group in the user
    /// interface, such as in the name of commands associated with the group.
    ///
    /// > Important: The system ignores any text styling that you apply to
    ///   the ``Text`` view title, like bold or italics. However, you can use
    ///   the formatting controls that the view offers, like for localization,
    ///   dates, and numerical representations.
    ///
    /// SwiftUI creates a window from the group when you present a value
    /// of the specified type using the ``EnvironmentValues/openWindow`` action.
    ///
    /// - Parameters:
    ///   - title: The ``Text`` view to use for the group's title.
    ///   - type: The type of presented data this window group accepts.
    ///   - content: A closure that creates the content for each instance
    ///     of the group. The closure receives a binding to the value that you
    ///     pass into the ``EnvironmentValues/openWindow`` action when you open
    ///     the window. SwiftUI automatically persists and restores the value
    ///     of this binding as part of the state restoration process.
    ///   - defaultValue: A closure that returns a default value to present.
    ///     SwiftUI calls this closure when it has no data to provide, like
    ///     when someone opens a new window from the File > New Window menu
    ///     item.
    public static func Pane<D, C>(_ title: Text, for type: D.Type = D.self, @ViewBuilder content: @escaping (Binding<D>) -> C, defaultValue: @escaping () -> D) -> some Scene where Content == PresentedWindowContent<D, PaneProvider<C>>, D : Decodable, D : Encodable, D : Hashable, C : View {
        WindowGroup(title, for: type, content: { d in PaneProvider(content: content(d)) }, defaultValue: defaultValue)
    }

    /// Returns a data-presenting window group with a localized title
    /// string and a default value.
    ///
    /// The window group uses the specified content as a
    /// template to create each window in the group.
    ///
    /// The system uses the title to distinguish the window group in the user
    /// interface, such as in the name of commands associated with the group.
    ///
    /// SwiftUI creates a window from the group when you present a value
    /// of the specified type using the ``EnvironmentValues/openWindow`` action.
    ///
    /// - Parameters:
    ///   - titleKey: The title key to use for the group's title.
    ///   - type: The type of presented data this window group accepts.
    ///   - content: A closure that creates the content for each instance
    ///     of the group. The closure receives a binding to the value that you
    ///     pass into the ``EnvironmentValues/openWindow`` action when you open
    ///     the window. SwiftUI automatically persists and restores the value
    ///     of this binding as part of the state restoration process.
    ///   - defaultValue: A closure that returns a default value to present.
    ///     SwiftUI calls this closure when it has no data to provide, like
    ///     when someone opens a new window from the File > New Window menu
    ///     item.
    public static func Pane<D, C>(_ titleKey: LocalizedStringKey, for type: D.Type = D.self, @ViewBuilder content: @escaping (Binding<D>) -> C, defaultValue: @escaping () -> D) -> some Scene where Content == PresentedWindowContent<D, PaneProvider<C>>, D : Decodable, D : Encodable, D : Hashable, C : View {
        WindowGroup(titleKey, for: type, content: { d in PaneProvider(content: content(d)) }, defaultValue: defaultValue)
    }

    /// Returns a data-presenting window group with a title string and a default
    /// value.
    ///
    /// The window group uses the specified content as a
    /// template to create each window in the group.
    ///
    /// The system uses the title to distinguish the window group in the user
    /// interface, such as in the name of commands associated with the group.
    ///
    /// SwiftUI creates a window from the group when you present a value
    /// of the specified type using the ``EnvironmentValues/openWindow`` action.
    ///
    /// - Parameters:
    ///   - title: The string to use for the title of the group.
    ///   - type: The type of presented data this window group accepts.
    ///   - content: A closure that creates the content for each instance
    ///     of the group. The closure receives a binding to the value that you
    ///     pass into the ``EnvironmentValues/openWindow`` action when you open
    ///     the window. SwiftUI automatically persists and restores the value
    ///     of this binding as part of the state restoration process.
    ///   - defaultValue: A closure that returns a default value to present.
    ///     SwiftUI calls this closure when it has no data to provide, like
    ///     when someone opens a new window from the File > New Window menu
    ///     item.
    public static func Pane<S, D, C>(_ title: S, for type: D.Type = D.self, @ViewBuilder content: @escaping (Binding<D>) -> C, defaultValue: @escaping () -> D) -> some Scene where Content == PresentedWindowContent<D, PaneProvider<C>>, S : StringProtocol, D : Decodable, D : Encodable, D : Hashable, C : View {
        WindowGroup(title, for: type, content: { d in PaneProvider(content: content(d)) }, defaultValue: defaultValue)
    }
}

