import CronstructCore
import CronstructUI
import CronstructUtils
import OSLog
import SwiftUI

private let log = Logger(for: ___FILEBASENAMEASIDENTIFIER___.self)

struct ___FILEBASENAMEASIDENTIFIER___: View {
    // MARK: - Props

    // MARK: - Environment
    //@Environment(\.managedObjectContext) private var moc

    // MARK: - State
    // MARK: - Property Helpers


    // MARK: -
    //init() { }
    
    // MARK: -
    var body: some View {
        #if VERBOSE
            let _ = Self._printChanges()
        #endif

        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }

    // MARK: - Actions
    // MARK: - Events
    // MARK: - Helpers
}

#Preview(traits: .appTint) {
    ___FILEBASENAMEASIDENTIFIER___()
}
