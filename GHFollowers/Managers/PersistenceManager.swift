//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Kovs on 21.01.2023.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completed: @escaping (GFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(var favorites):
                
                switch actionType {
                case .add:
                    
                    guard !favorites.contains(favorite) else {
                        // if contains:
                        completed(.alreadyInFavorites)
                        return
                    }
                    
                    // if you didn't add this user yet:
                    favorites.append(favorite)
                    
                case .remove:
                    favorites.removeAll { $0.login == favorite.login}
                }
                
                completed(save(favorites: favorites))
                
                
            case .failure(let error):
                completed(error)
            }
        }
    }

    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            // if nil, so there's no favorite
            completed(.success([]))
            return
        }
        
        // decode into followers array:
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
        
    }
    
    static func save(favorites: [Follower]) -> GFError? { // GFError with ? because the result can be successfull
        // encode:
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            
            // save to dafaults:
            defaults.set(encodedFavorites, forKey: "favorites")
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
    
}

