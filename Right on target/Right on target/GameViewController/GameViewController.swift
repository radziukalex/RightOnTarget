//
//  GameViewController.swift
//  Right on target
//
//  Created by Admin on 05.01.2023.
//

import UIKit

class GameViewController: UIViewController {
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.cyan.cgColor,
            UIColor.purple.cgColor,
            UIColor.red.cgColor
        ]
        gradient.locations = [0, 0.4, 0.9]
        return gradient
    }()
    
    lazy var buttonCheck = UIButton(frame: CGRect(x: 40, y: 40, width: 100, height: 100))
    lazy var mySlider = UISlider(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    lazy var myLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    lazy var buttonResult = UIButton(frame: CGRect(x: 40, y: 40, width: 100, height: 100))
    let model: GameModel
    
    init(model: GameModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - ЛОГИКА ИГРЫ
    @objc func checkNumber() {
        // получаем значение на слайдере
        let numSlider = Int(self.mySlider.value)
        // сравниваем значение с загаданным и подсчитываем очки
        let result = model.checkGameRound(selectedNumber: numSlider)
        if result.0 {
            // выводим информационное окно с результатами игры
            let alert = UIAlertController(
                title: "Игра окончена",
                message: "Вы заработали \(result.1) очков",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        // передаем значение случайного числа в label
        self.myLabel.text = result.2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        // передаем значение случайного числа в label
        self.myLabel.text = String(self.model.number)
        
        setupMyGradient()
        setupMySlider()
        setupButtonCheck()
        setupMyLabel()
        setupButtonResult()
    }
   
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradient.frame = view.bounds
    }
    
    private func setupMyGradient() {
        view.layer.addSublayer(gradient)
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
    }
    
    private func setupMySlider() {
        self.view.addSubview(mySlider)
        self.mySlider.translatesAutoresizingMaskIntoConstraints = false
        self.mySlider.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.mySlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.mySlider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        self.mySlider.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        self.mySlider.minimumTrackTintColor = .blue
        self.mySlider.maximumTrackTintColor = .purple
        self.mySlider.value = 25
        self.mySlider.maximumValue = 50
        self.mySlider.minimumValue = 0
        self.mySlider.minimumValueImage = UIImage(systemName: "0.square")
        self.mySlider.maximumValueImage = UIImage(systemName: "50.square")
        self.mySlider.tintColor = .black
    }
    
    private func setupMyLabel() {
        self.view.addSubview(myLabel)
        myLabel.backgroundColor = .clear
        myLabel.textAlignment = .center
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myLabel.centerYAnchor.constraint(equalTo: buttonCheck.centerYAnchor, constant: 50).isActive = true
        myLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        myLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupButtonCheck() {
        self.view.addSubview(buttonCheck)
        buttonCheck.setTitle("Check", for: .normal)
        buttonCheck.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        buttonCheck.setTitleColor(.black, for: .normal)
        buttonCheck.backgroundColor = .clear
        buttonCheck.translatesAutoresizingMaskIntoConstraints = false
        buttonCheck.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonCheck.centerYAnchor.constraint(equalTo: mySlider.centerYAnchor, constant: 60).isActive = true
        buttonCheck.heightAnchor.constraint(equalToConstant: 44).isActive = true
        buttonCheck.widthAnchor.constraint(equalToConstant: 100).isActive = true
       
        buttonCheck.addTarget(self, action: #selector(checkNumber), for: .touchDown)
    }
    
    private func setupButtonResult() {
        self.view.addSubview(buttonResult)
        buttonResult.setTitle("My results", for: .normal)
        buttonResult.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        buttonResult.setTitleColor(.black, for: .normal)
        buttonResult.backgroundColor = .clear
        buttonResult.translatesAutoresizingMaskIntoConstraints = false
        buttonResult.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        buttonResult.heightAnchor.constraint(equalToConstant: 44).isActive = true
        buttonResult.widthAnchor.constraint(equalToConstant: 130).isActive = true
        buttonResult.bottomAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 40).isActive = true
        buttonResult.addTarget(self, action: #selector(tapToResult), for: .touchDown)
        
    }
    
    @objc private func tapToResult() {
        let rootVC = ResultViewController(model: model)
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
}


