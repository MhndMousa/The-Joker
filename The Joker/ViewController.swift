//
//  ViewController.swift
//  The Joker
//
//  Created by Muhannad Alnemer on 12/29/19.
//  Copyright © 2019 Muhannad Alnemer. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    // MARK: Properties
    
    var jokeLabel : UILabel = {
        let a = UILabel()
        a.text = "Click that button for a random joke \n | \n v"
        a.font = UIFont.boldSystemFont(ofSize: 40)
        a.textAlignment = .center
        a.textColor = .gray
        a.numberOfLines = 0
        return a
    }()
    
    var randomJokeButton : UIButton = {
        let but = UIButton()
        but.setTitle("Random Joke", for: .normal)
        but.titleLabel?.textColor = .white
        but.addTarget(self, action: #selector(callJokeAPI), for: .touchUpInside)
        but.backgroundColor = UIColor(white: 0.2, alpha: 1)
        but.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
        but.layer.cornerRadius = 20
        but.layer.shadowColor = UIColor.black.cgColor
        but.layer.shadowOffset = but.frame.size
        but.layer.shadowRadius = 5
        but.layer.shadowOpacity = 0.2
        return but
    }()
    
    
    // MARK: View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(white: 0.94, alpha: 1)
        view.addSubview(randomJokeButton)
        view.addSubview(jokeLabel)
        
        // Constraint set up
        jokeLabel.translatesAutoresizingMaskIntoConstraints = false
        jokeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        jokeLabel.bottomAnchor.constraint(equalTo: randomJokeButton.topAnchor).isActive = true
        jokeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20).isActive = true
        jokeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20).isActive = true
        
        randomJokeButton.translatesAutoresizingMaskIntoConstraints = false
        randomJokeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        randomJokeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        randomJokeButton.widthAnchor.constraint(equalToConstant: view.frame.width - 100).isActive = true
        randomJokeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
//
//        jokeLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: randomJokeButton.topAnchor, trailing: view.trailingAnchor,padding: .init(top: 10, left: 20, bottom: 10, right: 20))
//        randomJokeButton.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil,padding: .init(top: 0, left: 0, bottom: 10, right: 0), size: CGSize(width: view.frame.width - 100, height: 40))
//        randomJokeButton.centerXToSuperview()
        
    }
    
    // MARK: Handlers

    
    @objc func callJokeAPI(){
        jokeLabel.showSpinner()
        
        // Construct a GET request to the the joke API generator
        let url = URL(string: "https://icanhazdadjoke.com/")!
        var req = URLRequest(url: url)
        req.allHTTPHeaderFields = ["Accept":"application/json"]
        req.httpMethod = "GET"
        
        // Start a session with that request
        let task = URLSession.shared.dataTask(with: req) {(data, response, error) in
            guard let data = data else { return }
            do{
                
                // Decode the data coming back from the API into Joke model and update the the label
                let joke = try JSONDecoder().decode(Joke.self, from: data)
                DispatchQueue.main.async {
                    UIView.transition(with: self.jokeLabel,
                                      duration: 0.25,
                                      options: .transitionCrossDissolve,
                                      animations: { [weak self] in
                                        self?.jokeLabel.removeSpinner()
                                        self?.jokeLabel.text = joke.joke
                        }, completion: nil)
                }
            }catch{
                self.jokeLabel.removeSpinner()
                // Show an error alert on catch
                let ac = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .actionSheet)
                ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(ac, animated: true, completion: nil)
            }
        }
        task.resume()
    }
}


