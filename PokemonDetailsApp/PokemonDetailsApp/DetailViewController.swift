//
//  DetailViewController.swift
//  PokemonDetailsApp
//
//  Created by Yavuz Güner on 17.10.2022.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
   
  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pokemonStat: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var pokemon : Result?
    
    var pokemonImage : [String] = [String]()
    
    var stat = [Stat]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        
        downloadPokemonDetails()

    }
    
    //Kingfisher ile url olan arrayimi image'a parse edeceğim.
    
    // Aşağıda yazdığım fonksiyonla Api'den gelen verileri Parse ederek yukarıda oluşturduğunm değişkenlere atamasını gerçekleştirip akabinde aşağıda yazmış olduğum tableview ve collectionview yapısında kullanmak üzere tasniflerim.
    func downloadPokemonDetails() {
        
        guard let url = URL(string: pokemon!.url) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { [self] result, response, error in
           
            let pokemonDetails = try? JSONDecoder().decode(PokemonDetail.self, from: result!)
            //
            self.pokemonImage.append((pokemonDetails?.sprites.backDefault)!)
            self.pokemonImage.append((pokemonDetails?.sprites.frontDefault)!)
            self.pokemonImage.append((pokemonDetails?.sprites.backShiny)!)
            self.pokemonImage.append((pokemonDetails?.sprites.frontShiny)!)
            
            //Tableview'ıma yapacağım şeyleri yazacağım.
            stat = pokemonDetails!.stats
            
            DispatchQueue.main.async {
                self.pokemonNameLabel.text = pokemonDetails?.name
                self.collectionView.reloadData()
                self.tableView.reloadData()
            }
           }
          task.resume()
    }
    
    
}

//Resimleri listeleyeceğim CollectionView yapısının 2 ana fonksiyonu.
extension DetailViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! DetailCollectionViewCell
        cell.images.kf.setImage(with: URL(string: self.pokemonImage[indexPath.row]))
        return cell
    }
}


//Stat verilerini çekmek için yazdığımız TableView'ın ana fonksiyonları.
extension DetailViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  stat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stats = stat[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailTableViewCell
        cell.statNameLabel.text = stats.stat.name
        cell.statValueLabel.text = String(stats.baseStat)
        return cell
    }
}



