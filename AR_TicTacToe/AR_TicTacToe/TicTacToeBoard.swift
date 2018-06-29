//
//  TicTacToeBoard.swift
//  AR_TicTacToe
//
//  Created by Bryce Ellis on 6/26/18.
//  Copyright © 2018 Bryce Ellis. All rights reserved.
//

import Foundation
import SceneKit

class TicTacToeBoard: SCNScene {
    override init() {
        super.init()
        _ = squares
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func newSquareNode() -> SCNNode {
        // Creates 9cm x 9cm x 9cm Tic Tac Toe Board
        let box = SCNBox(width: 0.09, height: 0.09, length: 0.01, chamferRadius: 0)
        // Difuse: Sets color of our Tic Tac Toe Board
        box.firstMaterial?.diffuse.contents = UIColor.gray
        
        let square = SCNNode(geometry: box)
        return square
        
    }
    
    lazy var squares: [[SCNNode]] = {
        var squaresArray: [[SCNNode]] = [[],[],[]]
        
        for row in 0...2 {
            for column in 0...2 {
                let square = newSquareNode()
                
                let x: Float = Float(row) * 0.1
                let y: Float = Float(column) * 0.1
                let z: Float = 0
                
                let position = SCNVector3(x,y,z)
                square.position = position
                
                squaresArray[row].append(square)
                rootNode.addChildNode(square)
            }
        }
        return squaresArray
    }()
    
    
    func newSymbolNode(on square: SCNNode, withSymbol symbol: String, andColor color: UIColor) -> SCNNode {
        
        let text = SCNText(string: symbol, extrusionDepth: 0.03)
        text.font = UIFont(name: "Arial", size: 0.07)
        text.firstMaterial?.diffuse.contents = color
        
        let (minVector, maxVector) = text.boundingBox
        let xOffset = (maxVector.x - minVector.x)/2 + minVector.x
        let yOffset = (maxVector.y - minVector.y)/2 + minVector.y
        let zOffset: Float = 0
        
        let symbol = SCNNode(geometry: text)
        symbol.pivot = SCNMatrix4MakeTranslation(xOffset, yOffset, zOffset)
        
        symbol.position = square.position
        
        return symbol
        
    }
    
    lazy var currentSymbol:String = "X"
    func tapped(on node: SCNNode) {
        let symbol = currentSymbol
        
        let symbolColor: UIColor
        
        if symbol == "X" {
            symbolColor = UIColor.orange
        } else {
            symbolColor = UIColor.blue
        }
        
        let symbolNode = newSymbolNode(on: node, withSymbol: symbol, andColor: symbolColor)
        rootNode.addChildNode(symbolNode)
        
        if currentSymbol == "X" {
            currentSymbol = "O"
        } else {
            currentSymbol = "X"
        }
    }
} // CLASS
