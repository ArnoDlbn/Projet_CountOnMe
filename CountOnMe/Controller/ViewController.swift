//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        let calculator = Calculator(operations: elements)
        do {
            textView.text = try calculator.addNumber(label: sender.title(for: .normal)!)
        } catch CalculatorError.cantAdd0 {
            let alertVC = UIAlertController(title: "Attention !", message: "On ne peut pas diviser par 0 !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        } catch {
        }
    }
    @IBAction func cancelledButton(_ sender: UIButton) {
        let calculator = Calculator(operations: elements)
        do {
            textView.text = try calculator.removeLast()
        } catch CalculatorError.cantRemoveLast {
            let alertVC = UIAlertController(title: "Attention !", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        } catch {
        }
    }
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        let calculator = Calculator(operations: elements)
        do {
            let operand = try calculator.addOperator(label: sender.title(for: .normal)!)
            textView.text.append(operand)
        } catch CalculatorError.cantAddOperator {
            let alertVC = UIAlertController(title: "Attention !", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        } catch {
        }
    }
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        let calculator = Calculator(operations: elements)
        do {
            let operand = try calculator.addOperator(label: sender.titleLabel!.text!)
            textView.text.append(operand)
        } catch CalculatorError.cantAddOperator {
            let alertVC = UIAlertController(title: "Attention !", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        } catch {
        }
    }
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        let calculator = Calculator(operations: elements)
        do {
            let operand = try calculator.addOperator(label: sender.titleLabel!.text!)
            textView.text.append(operand)
        } catch CalculatorError.cantAddOperator {
            let alertVC = UIAlertController(title: "Attention !", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        } catch {
        }
    }
    @IBAction func tappedDivisionButton(sender: UIButton) {
        let calculator = Calculator(operations: elements)
        do {
            let operand = try calculator.addOperator(label: sender.titleLabel!.text!)
            textView.text.append(operand)
        } catch CalculatorError.cantAddOperator {
            let alertVC = UIAlertController(title: "Attention !", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        } catch {
        }
    }
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        let calculator = Calculator(operations: elements)
        do {
            let operationsToReduce = try calculator.calculate()
            textView.text.append(" = \(operationsToReduce.first!)")
        } catch CalculatorError.expressionIsNotCorrect {
            let alertVC = UIAlertController(title: "Attention !", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        } catch CalculatorError.expressionDontHaveEnoughElement {
            let alertVC = UIAlertController(title: "Attention !", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        } catch CalculatorError.unknownOperator {
            let alertVC = UIAlertController(title: "Attention !", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        } catch {
        }
    }
}
