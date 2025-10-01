import Foundation

struct ErrorWrapper: Identifiable {
    let id: UUID
    let error: Error
    let guadance: String
    
    init(id: UUID = UUID(), error: Error, guadance: String) {
        self.id = id
        self.error = error
        self.guadance = guadance
    }
}
