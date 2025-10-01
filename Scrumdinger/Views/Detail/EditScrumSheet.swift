import SwiftUI
import SwiftData

struct EditScrumSheet: View {
    let scrum: DailyScrum
    
    var body: some View {
        NavigationStack {
            DetailEditView(scrum: scrum)
                .navigationTitle(scrum.title)
        }
    }
}

#Preview(traits: .dailyScrumsSampleData) {
    @Previewable @Query(sort: \DailyScrum.title) var scrums: [DailyScrum]
    EditScrumSheet(scrum: scrums[0])
}
