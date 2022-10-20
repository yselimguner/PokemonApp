//
//  ViewController.swift
//  PokemonDetailsApp
//
//  Created by Yavuz Güner on 17.10.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var pokemons = [Result]()
    
    var selected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadPokemonsNameList()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    //Pokemon ana api'sinden verileri çekeriz. Dispatchque ile anlık verilerin gelmesini sağlarız.
    func downloadPokemonsNameList() {
        
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon")
        
        let task = URLSession.shared.dataTask(with: url!) { result, response, error in
             if let result = result {
                     let pokemon = try? JSONDecoder().decode(Pokemon.self, from: result)
                     if let pokemonList = pokemon?.results{
                         self.pokemons = pokemonList
                     }
                 DispatchQueue.main.async {
                     self.tableView.reloadData()
                 }
             }
           }
          task.resume()
    }
}


//ana sayfada olan pokemon isimlerinin listelenmesini yaparım. Tableview'de ana iki metodumu yazarım fakat tıkladıktan sonra diğer sayfaya atlamak için DidSelectRowAt metodunu yazarım. Akabinde diğer sayfaya veri taşımak için ise prepare for segue fonksiyonumuzu yazarız ve tıkladığımız satırın verilerini diğer sayfamıza taşırız.
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let poke = pokemons[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        cell.textLabel?.text = (poke.name)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = indexPath.row
        performSegue(withIdentifier: "toDetailVC", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailVC" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.pokemon = pokemons[selected]
        }
    }
}
