//
//  ViewController.swift
//  Practica02
//
//  Created by MacBooK Pro on 8/10/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var imgPelicula: UIImageView!
    
    @IBOutlet weak var txtNombrePelicula: UITextField!
    
    @IBOutlet weak var txtNombreArchivoPeliucla: UITextField!
    
    @IBOutlet weak var btnAgregarPelicula: UIButton!
    
    @IBOutlet weak var lblNombrePelicula: UILabel!
    
    //NameMovie, NameFile
    private var Movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
    }


    private func setViews(){
        Movies.removeAll()
        segment.removeAllSegments()
    
        Movies.append(Movie(name: "Ironman", file: "ironman"))
        Movies.append(Movie(name: "Ironman 2", file: "ironman2"))
        Movies.append(Movie(name: "Ironman 3", file: "ironman3"))
        
        segment.insertSegment(withTitle: Movies[0].nameMovie, at: 0, animated: true)
        segment.insertSegment(withTitle: Movies[1].nameMovie, at: 1, animated: true)
        segment.insertSegment(withTitle: Movies[2].nameMovie, at: 2, animated: true)
        
        segment.selectedSegmentIndex = 0
        cambiandoSegment(segment)
    }
    
    @IBAction func cambiandoSegment(_ sender: Any) {
        let index = segment.selectedSegmentIndex
        
        lblNombrePelicula.text = Movies[index].nameMovie
        
        if let file = UIImage(named: Movies[index].nameFile){
            imgPelicula.image = file
        }else{
            imgPelicula.image = UIImage(named: "cine") //imagen x defecto
        }
        
    }
    
    @IBAction func saveMovie(_ sender: Any) {
        let nombrePelicula : String = txtNombrePelicula.text ?? ""
        let nombreArchivoPelicula : String = txtNombreArchivoPeliucla.text ?? ""
        
        if isEmpty(str: nombrePelicula) {
            showAlert(title: "Practica2", msg: "Debes ingresar el nombre de tu pelicula")
            return
        }
        
        if isEmpty(str: nombreArchivoPelicula) {
            showAlert(title: "Practica2", msg: "Debes ingresar el nombre del archivo de tu pelicula")
            return
        }
        
        Movies.append(Movie(name: nombrePelicula, file: nombreArchivoPelicula))
        segment.insertSegment(withTitle: nombrePelicula, at: (Movies.count - 1), animated: true)
        
        segment.selectedSegmentIndex = (segment.numberOfSegments - 1)
        cambiandoSegment(segment)
        
        txtNombrePelicula.text = ""
        txtNombreArchivoPeliucla.text = ""
    }
    
    private func isEmpty(str : String)->Bool{
        let trimmedStr = str.trimmingCharacters(in: .whitespaces)
        
        if(trimmedStr.count == 0){
            return true
        }

        return false
    }
    
    private func showAlert (title : String , msg : String){
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
}

struct Movie {
    public var nameMovie : String
    public var nameFile : String
    
    init(name : String, file : String) {
        nameMovie = name
        nameFile = file
    }
}
