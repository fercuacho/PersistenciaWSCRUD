//
//  PostDataManager.swift
//  PersistenciaWSCRUD
//
//  Created by José Fernando Cristóbal Huerta on 12/10/23.
//


import Foundation
import CoreData

class PostDataManager{
    
    private let context : NSManagedObjectContext
    
    init(context : NSManagedObjectContext){
        self.context = context
    }
    
    //MARK: CRUD Methods
    
    //Create a post
    
    func createPost(title : String, body : String, id : Int16, userId : Int16 ) -> Publicacion?{
        
        let newPost = Publicacion (context: context)
        newPost.title = title
        newPost.body = body
        newPost.id = id
        newPost.userId = userId
        
        do{
            try context.save()
            return newPost
        }
        catch let error{
            print("Error: ", error)
            return nil
        }
    }
    
    func getAllPosts() -> [Publicacion]{
        if let posts = try? self.context.fetch(Publicacion.fetchRequest()){
            return posts
        }
        else{
            return []
        }
    }
    
    func getLastPost() -> Publicacion?{
        if let posts = try? self.context.fetch(Publicacion.fetchRequest()){
            return posts.last
        }
        else{
            return nil
        }
    }
    
    //Return a post with an specified ID
    func getPostByID(id : Int16) -> Publicacion?{
        let fetchRequest = NSFetchRequest<Publicacion>(entityName: "Publicacion")
        var predicate : NSPredicate?
        
        predicate = NSPredicate(format: "id = %@", id as CVarArg)
        
        fetchRequest.predicate = predicate
        
        
        do{
            let post = try context.fetch(fetchRequest)
            return post.first
        }
        catch let error {
            print ("Error: ", error)
            return nil
        }
    }
    
    //Update a post
    func updatePost(publicacion : Publicacion, title : String, body : String) -> Publicacion{
        publicacion.title = title
        publicacion.body = body
        
        do{
            try context.save()
        }
        catch let error{
            print("Error, ", error)
        }
        return publicacion
    }
    
    //Delete a post
        func deletePost(publicacion : Publicacion) -> Bool{
            
            self.context.delete(publicacion)
            
            do {
                try context.save()
                return true
            }
            catch let error {
                print("Error: ", error)
                return false
            }
        }
    
    
}
