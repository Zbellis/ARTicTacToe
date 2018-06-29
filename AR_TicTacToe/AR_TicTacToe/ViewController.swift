//
//  ViewController.swift
//  AR_TicTacToe
//
//  Created by Bryce Ellis on 6/26/18.
//  Copyright © 2018 Bryce Ellis. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    
    @IBOutlet var sceneView: ARSCNView!
    
    
    lazy var board: TicTacToeBoard = TicTacToeBoard()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the view's delegate
        sceneView.delegate = self

        // displays rendering performance statistics in an accessory view.
        sceneView.showsStatistics = true
        // .scene: The SceneKit scene to be displayed in the view.
        sceneView.scene = board
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    @IBAction func didTap(_ recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: sceneView)
        
        let options: [SCNHitTestOption: Any] = [SCNHitTestOption.firstFoundOnly: true,]
        
        let sceneHitTestResults: [SCNHitTestResult] = sceneView.hitTest(location, options: options)
        
        guard let node = sceneHitTestResults.first?.node else {
            return
        }
        
        board.tapped(on: node)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
