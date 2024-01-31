//
//  AddResultViewController.swift
//  Right on target
//
//  Created by Admin on 04.02.2023.
//

import UIKit

class AddResultViewController: UIViewController {
    
    private let cancelButton = UIButton()
    private let saveButton = UIButton()
    private lazy var pointsTextField = UITextField()
    private lazy var dateTextField = UITextField()
    private lazy var datePicker = UIDatePicker()
    
    weak var resultDelegate: ResultDelegate?
    
    @objc func saveDateAndPoints() {
        let dateAndPoints = ResultItem(points: pointsTextField.text ?? "none", date: dateTextField.text ?? "none")
        resultDelegate?.addResult(dateAndPoints)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (touches.first) != nil {
            view.endEditing(true)
            doneButtonPressed()
        }
        super.touchesBegan(touches, with: event)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2
        setupCancelButton()
        setupSaveButton()
        setupPointTextField()
        setupDateTextField()
        createDatePicker()
    }
    
    private func createDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = createToolBar()
    }
    
    private func createToolBar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        toolBar.setItems([doneButton], animated: true)
        return toolBar
    }
    
    @objc func doneButtonPressed() {
        let dateString = DateFormatter.localizedString(from: datePicker.date, dateStyle: .short, timeStyle: .short)
        dateTextField.text = "\(dateString)"
    }
    
    private func setupPointTextField() {
        view.addSubview(pointsTextField)
        pointsTextField.placeholder = "Enter points"
        pointsTextField.backgroundColor = .systemGray3
        pointsTextField.borderStyle = .roundedRect
        pointsTextField.clearButtonMode = .always
        pointsTextField.keyboardType = .numberPad
        pointsTextField.keyboardAppearance = .default
        pointsTextField.translatesAutoresizingMaskIntoConstraints = false
        pointsTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pointsTextField.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor, constant: 80).isActive = true
        pointsTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        pointsTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        pointsTextField.delegate = self
    }
    
    private func setupDateTextField() {
        view.addSubview(dateTextField)
        dateTextField.placeholder = "Enter date"
        dateTextField.textContentType = .dateTime
        dateTextField.keyboardType = .default
        dateTextField.backgroundColor = .systemGray3
        dateTextField.borderStyle = .roundedRect
        dateTextField.clearButtonMode = .always
        dateTextField.inputView = datePicker
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        dateTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dateTextField.centerYAnchor.constraint(equalTo: pointsTextField.centerYAnchor, constant: 35).isActive = true
        dateTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        dateTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        dateTextField.delegate = self
        
    }
    
    private func setupCancelButton() {
        view.addSubview(cancelButton)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        cancelButton.backgroundColor = .clear
        cancelButton.setTitleColor(.systemBlue, for: .normal)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
    }
    
    @objc private func cancelButtonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupSaveButton() {
        view.addSubview(saveButton)
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        saveButton.backgroundColor = .clear
        saveButton.setTitleColor(.systemBlue, for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        saveButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        saveButton.addTarget(self, action: #selector(saveDateAndPoints), for: .touchUpInside)
    }
    
}
    
    
extension AddResultViewController: UITextFieldDelegate {
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
    
    
    
    
/*
    private func setupTableOfResult() {
        view.addSubview(tableOfResult)
        tableOfResult.translatesAutoresizingMaskIntoConstraints = false
        tableOfResult.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableOfResult.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableOfResult.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableOfResult.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableOfResult.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        tableOfResult.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -550).isActive = true
        tableOfResult.dataSource = self
        tableOfResult.delegate = self
    }
    
}


extension AddResultViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "MyCell") {
            cell = reuseCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
        }
        configure(cell: cell, for: indexPath)
        return cell
    }

    private func configure(cell: UITableViewCell, for indexPath: IndexPath) {
        var config = cell.defaultContentConfiguration()
        switch indexPath.row {
        case 0:
            config.text = "Результат раунда"
        case 1:
            config.text = "Время"
        default:
            break
        }
        cell.accessoryType = .detailButton
        cell.backgroundColor = .systemGray5
        cell.contentConfiguration = config
    }
}


class myTextFieldTableViewCell: UITableViewCell {
    
    class TextField: UITextField {
        
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 24, dy: 0)
        }
        
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 24, dy: 0)
        }
        
        override var intrinsicContentSize: CGSize {
            return .init(width: 0, height: 44)
        }
    }
    
    var textField: UITextField {
        let tf = TextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Результат"
        return tf
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(textField)
        textField.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
*/
