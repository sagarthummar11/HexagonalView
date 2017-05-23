//
//  HexagonalView.swift
//
//  Code generated using QuartzCode 1.55.0 on 30/04/17.
//  www.quartzcodeapp.com
//

import UIKit

@IBDesignable
class HexagonalView: UIView, CAAnimationDelegate {
	
	var updateLayerValueForCompletedAnimation : Bool = true
	var completionBlocks : Dictionary<CAAnimation, (Bool) -> Void> = [:]
	var layers : Dictionary<String, AnyObject> = [:]

    @IBInspectable var viewFrame: CGRect = CGRect(x: 0, y: 0, width: 10, height: 10) {
        didSet {
            self.setupLayerFrames()
        }
    }

    @IBInspectable var backBorderWidth: CGFloat = 3.0 {
        didSet {
            self.resetLayerProperties(forLayerIdentifiers: ["backgroundView"])
        }
    }

    @IBInspectable var fillBorderWidth: CGFloat = 3.0 {
        didSet {
            self.resetLayerProperties(forLayerIdentifiers: ["foregroundView"])
        }
    }

    @IBInspectable var fillBorderColor: UIColor = UIColor.red {
        didSet {
            self.resetLayerProperties(forLayerIdentifiers: ["foregroundView"])
        }
    }

    @IBInspectable var backBorderColor: UIColor = UIColor.gray {
        didSet {
            self.resetLayerProperties(forLayerIdentifiers: ["backgroundView"])
        }
    }

    @IBInspectable var viewBackgroundColor: UIColor = UIColor.white {
        didSet {
            self.resetLayerProperties(forLayerIdentifiers: ["backgroundView","foregroundView"])
        }
    }

    @IBInspectable var storkStart: CGFloat = 0.5 {
        didSet {
            self.resetLayerProperties(forLayerIdentifiers: ["foregroundView"])
        }
    }

    @IBInspectable var storkEnd: CGFloat = 1 {
        didSet {
            self.resetLayerProperties(forLayerIdentifiers: ["foregroundView"])
        }
    }

	//MARK: - Life Cycle
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupProperties()
		setupLayers()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		setupProperties()
		setupLayers()
	}
	
	override var frame: CGRect{
		didSet{
			setupLayerFrames()
		}
	}
	
	override var bounds: CGRect{
		didSet{
			setupLayerFrames()
		}
	}
	
	func setupProperties(){
		
	}
	
	func setupLayers(){
		let Group = CALayer()
		self.layer.addSublayer(Group)
		layers["Group"] = Group
		let backgroundView = CAShapeLayer()
		Group.addSublayer(backgroundView)
		layers["backgroundView"] = backgroundView
		let foregroundView = CAShapeLayer()
		Group.addSublayer(foregroundView)
		layers["foregroundView"] = foregroundView
		
		resetLayerProperties(forLayerIdentifiers: nil)
		setupLayerFrames()
	}
	
	func resetLayerProperties(forLayerIdentifiers layerIds: [String]!){
		CATransaction.begin()
		CATransaction.setDisableActions(true)
		
		if layerIds == nil || layerIds.contains("backgroundView"){
			let backgroundView = layers["backgroundView"] as! CAShapeLayer
			backgroundView.fillColor   = UIColor(red:0.922, green: 0.922, blue:0.922, alpha:1).cgColor
            backgroundView.fillColor   = UIColor.clear.cgColor
			backgroundView.strokeColor = self.backBorderColor.cgColor
			backgroundView.lineWidth   = self.backBorderWidth
            backgroundView.strokeStart = 0.0
            backgroundView.strokeEnd   = 1.0
		}
		if layerIds == nil || layerIds.contains("foregroundView"){
			let foregroundView = layers["foregroundView"] as! CAShapeLayer
			foregroundView.fillColor   = self.viewBackgroundColor.cgColor
			foregroundView.strokeColor = self.fillBorderColor.cgColor
			foregroundView.lineWidth   = self.fillBorderWidth
            foregroundView.strokeStart = self.storkStart
            foregroundView.strokeEnd   = self.storkEnd
		}
		
		CATransaction.commit()
	}
	
	func setupLayerFrames(){
		CATransaction.begin()
		CATransaction.setDisableActions(true)
		
		if let Group : CALayer = layers["Group"] as? CALayer{
            Group.frame = CGRect(x: viewFrame.minX, y: viewFrame.minY, width: viewFrame.width, height: viewFrame.height)
		}
		
		if let backgroundView : CAShapeLayer = layers["backgroundView"] as? CAShapeLayer{
			backgroundView.frame = CGRect(x: 0, y: 0, width:  backgroundView.superlayer!.bounds.width, height:  backgroundView.superlayer!.bounds.height)
			backgroundView.path  = backgroundViewPath(bounds: (layers["backgroundView"] as! CAShapeLayer).bounds).cgPath
		}
		
		if let foregroundView : CAShapeLayer = layers["foregroundView"] as? CAShapeLayer{
			foregroundView.frame = CGRect(x: 0, y: 0, width:  foregroundView.superlayer!.bounds.width, height:  foregroundView.superlayer!.bounds.height)
			foregroundView.path  = foregroundViewPath(bounds: (layers["foregroundView"] as! CAShapeLayer).bounds).cgPath
		}
		
		CATransaction.commit()
	}
	
	
	
	//MARK: - Animation Cleanup
	
	func animationDidStop(_ anim: CAAnimation, finished flag: Bool){
		if let completionBlock = completionBlocks[anim]{
			completionBlocks.removeValue(forKey: anim)
			if (flag && updateLayerValueForCompletedAnimation) || anim.value(forKey: "needEndAnim") as! Bool{
				updateLayerValues(forAnimationId: anim.value(forKey: "animId") as! String)
				removeAnimations(forAnimationId: anim.value(forKey: "animId") as! String)
			}
			completionBlock(flag)
		}
	}
	
	func updateLayerValues(forAnimationId identifier: String){
		
	}
	
	func removeAnimations(forAnimationId identifier: String){
		
	}
	
	func removeAllAnimations(){
		for layer in layers.values{
			(layer as! CALayer).removeAllAnimations()
		}
	}
	
	//MARK: - Bezier Path
	
	func backgroundViewPath(bounds: CGRect) -> UIBezierPath{
		let backgroundViewPath = UIBezierPath()
		let minX = CGFloat(bounds.minX), minY = bounds.minY, w = bounds.width, h = bounds.height;
		
		backgroundViewPath.move(to: CGPoint(x:minX + 0.5 * w, y: minY))
		backgroundViewPath.addLine(to: CGPoint(x:minX, y: minY + 0.25 * h))
		backgroundViewPath.addLine(to: CGPoint(x:minX, y: minY + 0.75 * h))
		backgroundViewPath.addLine(to: CGPoint(x:minX + 0.5 * w, y: minY + h))
		backgroundViewPath.addLine(to: CGPoint(x:minX + w, y: minY + 0.75 * h))
		backgroundViewPath.addLine(to: CGPoint(x:minX + w, y: minY + 0.25 * h))
		backgroundViewPath.close()
		backgroundViewPath.move(to: CGPoint(x:minX + 0.5 * w, y: minY))
		
		return backgroundViewPath
	}
	
	func foregroundViewPath(bounds: CGRect) -> UIBezierPath{
		let foregroundViewPath = UIBezierPath()
		let minX = CGFloat(bounds.minX), minY = bounds.minY, w = bounds.width, h = bounds.height;
		
		foregroundViewPath.move(to: CGPoint(x:minX + 0.5 * w, y: minY))
		foregroundViewPath.addLine(to: CGPoint(x:minX, y: minY + 0.25 * h))
		foregroundViewPath.addLine(to: CGPoint(x:minX, y: minY + 0.75 * h))
		foregroundViewPath.addLine(to: CGPoint(x:minX + 0.5 * w, y: minY + h))
		foregroundViewPath.addLine(to: CGPoint(x:minX + w, y: minY + 0.75 * h))
		foregroundViewPath.addLine(to: CGPoint(x:minX + w, y: minY + 0.25 * h))
		foregroundViewPath.close()
		foregroundViewPath.move(to: CGPoint(x:minX + 0.5 * w, y: minY))
		
		return foregroundViewPath
	}
	
	
}
