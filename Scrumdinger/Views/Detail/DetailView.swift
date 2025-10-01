import SwiftUI
import SwiftData

struct DetailView: View {
    let scrum: DailyScrum
    
    @State private var isPresentingEditView = false
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some View {
        List {
            Section {
                NavigationLink(destination: MeetingView(scrum: scrum, errorWrapper: $errorWrapper)) {
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Lenght", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text("\(scrum.theme.name)")
                        .padding(4)
                        .foregroundStyle(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
            } header: {
                Text("Meeting Info")
            }
            
            Section {
                ForEach(scrum.attendees) { attendee in
                    Label(attendee.name, systemImage: "person")
                }
            } header: {
                Text("Attendees")
            }
            
            Section {
                if scrum.history.isEmpty {
                    Label("No meetings yet.", systemImage: "calendar.badge.exclamationmark")
                } else {
                    ForEach(scrum.history) { historyItem in
                        NavigationLink(destination: HistoryView(history: historyItem)) {
                            HStack {
                                Image(systemName: "calendar")
                                Text(historyItem.date, style: .date)
                            }
                        }
                    }
                }
            } header: {
                Text("History")
            }
        }
        .navigationTitle(scrum.title)
        .toolbar {
            Button(action: {
                isPresentingEditView = true
            }) {
                Text("Edit")
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            EditScrumSheet(scrum: scrum)
        }
        .sheet(item: $errorWrapper, onDismiss: nil) { wrapper in
            ErrorView(errorWrapper: wrapper)
        }
    }
}

#Preview(traits: .dailyScrumsSampleData) {
    @Previewable @Query(sort: \DailyScrum.title) var scrums: [DailyScrum]
    NavigationStack {
        DetailView(scrum: scrums[0])
    }
}
