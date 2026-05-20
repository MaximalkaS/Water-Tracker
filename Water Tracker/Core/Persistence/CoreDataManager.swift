
import Foundation
import CoreData

protocol CoreDataManagerProtocol: AnyObject {
    var waterEntries: [WaterEntry] { get }
    func fetchWaterEntries()
    func fetchWaterEntries(from startDate: Date, to endDate: Date) -> [WaterEntry]
    func addWaterEntry(for entry: WaterEntryModel)
    func deleteWaterEntry(with id: String)
}

class CoreDataManager: CoreDataManagerProtocol {
    
    static let shared = CoreDataManager()
    
    private let viewContext: NSManagedObjectContext
    
    var waterEntries: [WaterEntry] = []
    
    private init() {
        viewContext = PersistenceController.shared.container.viewContext
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
        }
    }
    
    func fetchWaterEntries() {
        let request = WaterEntry.fetchRequest()
        
        do {
            let waterEntries = try viewContext.fetch(request)
            self.waterEntries = waterEntries
        } catch {
            print("Failure to fetch water entries: \(error.localizedDescription)")
        }
    }
    
    func fetchWaterEntries(from startDate: Date, to endDate: Date) -> [WaterEntry] {
        let request = WaterEntry.fetchRequest()
        
        request.predicate = NSPredicate(
            format: "createdAt >= %@ AND createdAt < %@",
            startDate as NSDate,
            endDate as NSDate
        )
        
        request.sortDescriptors = [
            NSSortDescriptor(key: "createdAt", ascending: true)
        ]
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print("Ошибка загрузки записей за неделю: \(error.localizedDescription)")
            return []
        }
    }
    
    func addWaterEntry(for entry: WaterEntryModel) {
        let newEntry = WaterEntry(context: viewContext)
        newEntry.id = entry.id
        newEntry.amount = Int64(entry.amount)
        newEntry.remaining = Int64(entry.remaining)
        newEntry.dailyGoalAtMoment = Int64(entry.dailyGoalAtMoment)
        newEntry.createdAt = entry.createdAt
        
        saveContext()
        fetchWaterEntries()
    }
    
    func deleteWaterEntry(with id: String) {
        let request = WaterEntry.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let result = try viewContext.fetch(request)
            
            if let deleteEntry = result.first {
                viewContext.delete(deleteEntry)
                try viewContext.save()
                fetchWaterEntries()
            }
        } catch {
            print("Failure to delete water entry: \(error.localizedDescription)")
        }
    }
}
