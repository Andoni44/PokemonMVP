//
//  CoreDataManager.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 21/2/21.
//

import UIKit
import CoreData

protocol CoreDataManagerProtocol {
    
    var appDelegate: AppDelegate? { get set }
    var manageObjectContext: NSManagedObjectContext? { get set }
    
    func saveData(results: Results)
    func removeData(byName: String)
    func getRecentSearches() -> Results
}

final class CoreDataManager: CoreDataManagerProtocol {
    
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    var manageObjectContext: NSManagedObjectContext? = nil
    private let entityName = "PokemonCoreDataList"
    
    func saveData(results: Results) {
        resetEntity()
        loadContext()
        guard let context = manageObjectContext else { return }
        results.forEach {
            let newEntry = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
            newEntry.setValue($0.name, forKey: "name")
            newEntry.setValue($0.url, forKey: "url")
            newEntry.setValue(Date(), forKey: "date")
        }
        do {
            try context.save()
        } catch {
            debugPrint("Error saving context: \(error)")
        }
    }
    
    func removeData(byName name: String) {
        loadContext()
        guard let context = manageObjectContext else { return }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        let predicate = NSPredicate(format: "name == %@", name)
        fetchRequest.predicate = predicate
        do {
            try context.delete(context.fetch(fetchRequest)[0])
            try context.save()
        } catch {
            debugPrint("Error saving context: \(error)")
        }
    }
    
    func getRecentSearches() -> Results {
        loadContext()
        var toRet: Results = []
        guard let context = manageObjectContext else { return [] }
        let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        do {
            let pokemonResult = try context.fetch(request)
            for item in pokemonResult {
                if let pokmeonCoreDataListItem = item as? PokemonCoreDataList {
                    let pokemon = PokemonResultElement(name: pokmeonCoreDataListItem.name ?? "", url: pokmeonCoreDataListItem.url ?? "")
                    toRet.append(pokemon)
                }
            }
        } catch let nserror as NSError{
            print("ERROR: Coredata error \(nserror)")
        }
        return toRet
    }
}

// MARK: - Private local
fileprivate extension CoreDataManager {
    
    func resetEntity() {
        loadContext()
        if let manageObjectContext = manageObjectContext {
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let request = NSBatchDeleteRequest(fetchRequest: fetch)
            do {
                try manageObjectContext.execute(request)
            } catch let nserror as NSError{
                print("ERROR: Coredata deleting batch error \(nserror)")
            }
        }
    }
    
    func loadContext() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        manageObjectContext = appDelegate.persistentContainer.viewContext
    }
}
