//
//  ViewController.swift
//  PersistenciaWSCRUD
//
//  Created by José Fernando Cristóbal Huerta on 12/10/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let postService = PostServiceManager ()

    var myPost = Post(id: nil, title: "Hello Post", body: "Post content", userId: 1)
    var ultimoPost : Publicacion?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let postManager = PostDataManager(context: context)

        /*
         //MARK: 1. Implementar el guardado el post recuperados desde el servidor remoto
        postService.getAllPosts { posts in
            if let posts = posts {
                // Verifica si los posts devueltos son los que esperas
                for post in posts {
                    //print("post: ", post.id ?? "Not id found")
                    
                    //MARK: Insert posts
                    let newPost = postManager.createPost(title: post.title, body: post.body, id: Int16(post.id ?? post.userId), userId: Int16(post.userId))
                }
            } else {
                print("Failed to fetch posts")
            }
        }*/
        
        //MARK: Insertando post de pruba
        //let newPost = postManager.createPost(title: "Post de prueba", body: "Contenido de pruba", id: 9657, userId: 1)

        
        //MARK: 2. Get all post (implementar la visualización del listado de post guardado en la base de datos local)
       for persistedPost in postManager.getAllPosts(){
           print("ID: ", persistedPost.id, "title: ", persistedPost.title ?? "No title", "Content: ", persistedPost.body ?? "default body")
       }
        
        /*
        //MARK: Get post by ID
        if let postWithID = postManager.getPostByID(id : 3141){
            print("ID: ", postWithID.id, "title: ", postWithID.title ?? "No title", "content: ", postWithID.body ?? "defualt body")
            myfavoritePost = postWithID
        }else {
            print("Song unavailable!")
        }*/
        
        ultimoPost = postManager.getLastPost()
        print("ID del ultimo post: ", ultimoPost?.id, "title: ", ultimoPost?.title ?? "No title", "Content: ", ultimoPost?.body ?? "default body")
        
        //MARK: 3. Update simulado en la API remota (implementar la visualización del listado de post guardado en la base de datos local)
        myPost = Post(id: 10, title: "updated post", body: "New content", userId: 5) // Post a actualizar
        //myPost = Post(id: ultimoPost?.id, title: ultimoPost?.title, body: ultimoPost?.body, userId: ultimoPost?.userId) // Post a actualizar
        postService.updatePost(post: myPost){ updatePost in
            if let updatePost = updatePost{
                print("updated post in the remote API: ", updatePost)
                
                //MARK: 3.5 Update en la base local
                let updatedPost = postManager.updatePost(publicacion: (self.ultimoPost)!, title: (self.ultimoPost?.title)!, body: "contenido actualizado")
                print("Updated post in the local storege ID: ", updatedPost.id, "title: ", updatedPost.title ?? "No title", "body: ", updatedPost.body)
            }
            else{
                print("Error: Failed to update post")
            }
        }
        /*
        //MARK: Imprimiento todo lo que està guardado comprobando que se actualizo el ultimo elemento en la base local
       for persistedPost in postManager.getAllPosts(){
           print("ID: ", persistedPost.id, "title: ", persistedPost.title ?? "No title", "Content: ", persistedPost.body ?? "default body")
       }*/
        
        //MARK: 4. Delete simulado en la API remota (implementar la visualización del listado de post guardado en la base de datos local)
        postService.deletePost(id: 50){ statusCode in
            if statusCode == 200{
                print("Post deleted en la API")
                //MARK: 4.5 Delete en la base local
                let result = postManager.deletePost(publicacion: self.ultimoPost!)
                if result == true{
                    print("Message: My last post was deleted!!")
                }
                else{
                    print("Unable to delete that post")
                }
            }
            else{
                print("Failed to delete post")
            }
        }
        
        /*
        //MARK: Imprimiento todo lo que està guardado comprobando que se actualizo el ultimo elemento en la base local
       for persistedPost in postManager.getAllPosts(){
           print("ID: ", persistedPost.id, "title: ", persistedPost.title ?? "No title", "Content: ", persistedPost.body ?? "default body")
       }
        */
                                        
        
    }


}

