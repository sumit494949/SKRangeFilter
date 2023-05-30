//
//  SKRangeFilter.swift
//

import Foundation
import UIKit

@IBDesignable open class SKRangeFilter: UIControl {
    
    // MARK: - initializers
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        setup()
    }
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    
    // MARK: - open stored properties
    
    open weak var delegate: SKRangeFilterDelegate?
    
    /// The minimum possible value to select in the range
    @IBInspectable open var minValue: CGFloat = 0.0 {
        didSet {
            refresh()
        }
    }
    
    /// The maximum possible value to select in the range
    @IBInspectable open var maxValue: CGFloat = 100.0 {
        didSet {
            refresh()
        }
    }
    
    /// The preselected minumum value
    /// (note: This should be less than the selectedMaxValue)
    var lefthandleValue: CGFloat = 0.0
    //        didSet {
    //            if selectedMinValue < minValue {
    //                selectedMinValue = minValue
    //            }
    //        }
    //    }
    
    /// The preselected maximum value
    /// (note: This should be greater than the selectedMinValue)
    var rightHandleValue: CGFloat = 100.0
    //        didSet {
    //            if selectedMaxValue > maxValue {
    //                selectedMaxValue = maxValue
    //            }
    //        }
    //    }
    
    /// The font of the range slider label. If not set, the default is system font size 12.0.
    open var titleLabelFont: UIFont = UIFont.boldSystemFont(ofSize: 12){   //systemFont(ofSize: 11, weight: .light){
        didSet {
            titleLabel?.font  = titleLabelFont
        }
    }
    //
    /// The font of the range labels. If not set, the default is system font size 10.0.
open var rangeLabelsFont: UIFont = UIFont.boldSystemFont(ofSize: 11){ //systemFont(ofSize: 11, weight: .light) {
        didSet {
            rangeLabel1?.font = rangeLabelsFont
            rangeLabel2?.font = rangeLabelsFont
            rangeLabel3?.font = rangeLabelsFont
            rangeLabel4?.font = rangeLabelsFont
            rangeLabel5?.font = rangeLabelsFont
        }
    }
    
    /// The font of the value text label in baloon view. If not set, the default is system font size 12.0.
    open var baloonLabelFont: UIFont = UIFont.boldSystemFont(ofSize: 11){ //systemFont(ofSize: 11, weight: .light) {
        didSet {
            baloonView?.valueLbl?.font  = baloonLabelFont
        }
    }
    
    
    /// Handle slider with custom color, you can set custom color for your handle
    @IBInspectable open var handleColor: UIColor =  UIColor.init(red: (228.0/255.0), green: (0.0/255.0), blue: (0.0/255.0), alpha: 1.0){
        didSet{
                updateColors()
        }
    }
    
    /// Handle slider with custom border color, you can set custom border color for your handle
    @IBInspectable open var handleBorderColor: UIColor = UIColor.init(red: (228.0/255.0), green: (0.0/255.0), blue: (0.0/255.0), alpha: 1.0){
        didSet{
                updateColors()
            }
    }
    
    /// Set slider line tint color between handles
    @IBInspectable open var colorBetweenHandles: UIColor = UIColor.init(red: (228.0/255.0), green: (0.0/255.0), blue: (0.0/255.0), alpha: 1.0){
        didSet{
            updateColors()
        }
    }
    
    /// The color of the entire slider when the handle is set to the minimum value and the maximum value. Default is nil.
    @IBInspectable open var sliderLineColor: UIColor = UIColor.init(red: (240.0/255.0), green: (240.0/255.0), blue: (240.0/255.0), alpha: 0.5){
        didSet{
            updateColors()
        }
    }
    
    /// Handle slider with custom image, you can set custom image for your handle
    @IBInspectable open var handleImage: UIImage? {
        didSet {
            guard let image = handleImage else {
                return
            }
            
            var handleFrame = CGRect.zero
            handleFrame.size = image.size
            
            leftHandle.frame = handleFrame
            leftHandle.contents = image.cgImage
            
            rightHandle.frame = handleFrame
            rightHandle.contents = image.cgImage
        }
    }
    
    /// Handle diameter (default 16.0)
    @IBInspectable open var handleDiameter: CGFloat = 16.0 {
        didSet {
            leftHandle.cornerRadius = handleDiameter / 2.0
            rightHandle.cornerRadius = handleDiameter / 2.0
            leftHandle.frame = CGRect(x: 0.0, y: 0.0, width: handleDiameter, height: handleDiameter)
            rightHandle.frame = CGRect(x: 0.0, y: 0.0, width: handleDiameter, height: handleDiameter)
        }
    }
    
    
    /// Set the slider line height (default 2.0)
    @IBInspectable open var lineHeight: CGFloat = 2.0 {
        didSet {
            updateLineHeight()
        }
    }
    
    /// Handle border width (default 2.0)
    @IBInspectable open var handleBorderWidth: CGFloat = 2.0 {
        didSet {
            leftHandle.borderWidth = handleBorderWidth
            rightHandle.borderWidth = handleBorderWidth
        }
    }
    
    /// Set textColor of baloonView text
    @IBInspectable open var baloonViewTextColor: UIColor = UIColor.white {
        didSet {
           baloonView?.valueLbl?.textColor = baloonViewTextColor
        }
    }
    
    /// Set padding between baloon View and handle (default 4.0)
    @IBInspectable open var baloonViewPadding: CGFloat = 4.0 {
        didSet {
            updateBaloonView()
        }
    }
    
    /// Set height of baloon view (default 55.0)
    @IBInspectable open var baloonViewHeight: CGFloat = 55.0 {
        didSet {
            updateBaloonView()
        }
    }
    
    /// Set width of baloon view (default 46.0)
    @IBInspectable open var baloonViewWidth: CGFloat = 46.0 {
        didSet {
            updateBaloonView()
        }
    }
    
    /// Set Slider Title Text
    @IBInspectable open var titleLabelText: String = "" {
        didSet {
            titleLabel?.text = titleLabelText
        }
    }
    
    /// Set TitleLabelNumberOf lines
    @IBInspectable open var titleLabelLineNumbers: Int = 1 {
        didSet {
            titleLabel?.numberOfLines = titleLabelLineNumbers
        }
    }
    
    /// Set padding of TitleLabel from slider
    @IBInspectable open var titleLabelPadding: CGFloat = 20.0 {
        didSet {
            addTitleLable()
        }
    }
    
    /// Set width of TitleLabel
    @IBInspectable open var titleLabelWidth: CGFloat = 160.0 {
        didSet {
            addTitleLable()
        }
    }
    
    /// Set height of TitleLabel
    @IBInspectable open var titleLabelHeight: CGFloat = 17.0 {
        didSet {
            addTitleLable()
        }
    }
    
    /// Set textColor of TitleLabel
    @IBInspectable open var titleLabelColor: UIColor = UIColor.init(red: (102.0/255.0), green: (102.0/255.0), blue: (102.0/255.0), alpha: 1.0) {
        didSet {
            titleLabel?.textColor = titleLabelColor
        }
    }
    
    /// Set textColor of rangeLabels
    @IBInspectable open var rangeLabelColor: UIColor = UIColor.black {
        didSet {
            rangeLabel1?.textColor = rangeLabelColor
            rangeLabel2?.textColor = rangeLabelColor
            rangeLabel3?.textColor = rangeLabelColor
            rangeLabel4?.textColor = rangeLabelColor
            rangeLabel5?.textColor = rangeLabelColor
        }
    }
    
    /// Set padding of range labels from slider
    @IBInspectable open var rangeLabelPadding: CGFloat = 12.0 {
        didSet {
            addRangeLabels()
        }
    }
    
    /// Set width of rangeLabels
    @IBInspectable open var rangeLabelWidth: CGFloat = 36.0 {
        didSet {
            addRangeLabels()
        }
    }
    
    /// Set height of rangeLabels
    @IBInspectable open var rangeLabelHeight: CGFloat = 17.0 {
        didSet {
            addRangeLabels()
        }
    }
    
    // MARK: - private stored properties
    
    private enum HandleTracking { case none, left, right }
    private var handleTracking: HandleTracking = .none
    
    private let sliderLine: CALayer = CALayer()
    private let sliderLineBetweenHandles: CALayer = CALayer()
    
    private let leftHandle: CALayer = CALayer()
    private let rightHandle: CALayer = CALayer()
    
    fileprivate var baloonView: BaloonView?
    
    fileprivate var titleLabel:UILabel?
    fileprivate var rangeLabel1:UILabel?
    fileprivate var rangeLabel2:UILabel?
    fileprivate var rangeLabel3:UILabel?
    fileprivate var rangeLabel4:UILabel?
    fileprivate var rangeLabel5:UILabel?
    
    private var rangeLabelvalues = [Int]()
    
    // MARK: - UIView
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        if handleTracking == .none {
            updateLineHeight()
            updateColors()
            updateHandlePositions()
            addTitleLable()
            addRangeLabels()
        }
    }
    
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 134.0)
    }
    
    public func reload(){
        
        lefthandleValue = minValue
        rightHandleValue = maxValue
        refresh()
        
    }
    
    
    // MARK: - UIControl
    
    open override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchLocation: CGPoint = touch.location(in: self)
        let insetExpansion: CGFloat = -30.0
        let isTouchingLeftHandle: Bool = leftHandle.frame.insetBy(dx: insetExpansion, dy: insetExpansion).contains(touchLocation)
        let isTouchingRightHandle: Bool = rightHandle.frame.insetBy(dx: insetExpansion, dy: insetExpansion).contains(touchLocation)
        
        guard isTouchingLeftHandle || isTouchingRightHandle else { return false }
        
        
        // checking which handle is closer to the touch point
        let distanceFromLeftHandle: CGFloat = touchLocation.distance(to: leftHandle.frame.center)
        let distanceFromRightHandle: CGFloat = touchLocation.distance(to: rightHandle.frame.center)
        
        if distanceFromLeftHandle < distanceFromRightHandle {
            handleTracking = .left
        } else if rightHandleValue == maxValue && leftHandle.frame.midX == rightHandle.frame.midX {
            handleTracking = .left
        } else {
            handleTracking = .right
        }
        let handle: CALayer = (handleTracking == .left) ? leftHandle : rightHandle
        animate(handle: handle, selected: true)
        
        delegate?.didStartTouches(in: self)
        
        updateBaloonView()
        
        
        return true
    }
    
    open override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        guard handleTracking != .none else { return false }
        
        let location: CGPoint = touch.location(in: self)
        
        // find out the percentage along the line we are in x coordinate terms (subtracting half the frames width to account for moving the middle of the handle, not the left hand side)
        let percentage: CGFloat = (location.x - sliderLine.frame.minX - handleDiameter / 2.0) / (sliderLine.frame.maxX - sliderLine.frame.minX)
        
        // multiply that percentage by self.maxValue to get the new selected minimum value
        let selectedValue: CGFloat = percentage * (maxValue - minValue) + minValue
        
        switch handleTracking {
        case .left:
            if(selectedValue >= minValue &&  selectedValue <= maxValue){
                lefthandleValue = selectedValue
            }
        case .right:
            if(selectedValue >= minValue &&  selectedValue <= maxValue){
                rightHandleValue = selectedValue
            }
            
        case .none:
            // no need to refresh the view
            break
        }
        refresh()
        
        return true
    }
    
    open override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        let handle: CALayer = (handleTracking == .left) ? leftHandle : rightHandle
        animate(handle: handle, selected: false)
        handleTracking = .none
        
        removeBaloonView()
        
        delegate?.didEndTouches(in: self)
    }
    
    func removeBaloonView() {
        self.baloonView?.isHidden = true
    }
    
    
    // MARK: - private methods
    
    private func setup() {
        
        lefthandleValue = minValue
        rightHandleValue = maxValue
        
        // draw the slider line
        layer.addSublayer(sliderLine)
        
        // draw the track distline
        layer.addSublayer(sliderLineBetweenHandles)
        
        // draw the minimum slider handle
        leftHandle.cornerRadius = handleDiameter / 2.0
        leftHandle.borderWidth = handleBorderWidth
        layer.addSublayer(leftHandle)
        
        // draw the maximum slider handle
        rightHandle.cornerRadius = handleDiameter / 2.0
        rightHandle.borderWidth = handleBorderWidth
        layer.addSublayer(rightHandle)
        
        let handleFrame: CGRect = CGRect(x: 0.0, y: 0.0, width: handleDiameter, height: handleDiameter)
        leftHandle.frame = handleFrame
        rightHandle.frame = handleFrame
        
        // refreshing the handle positions
        refresh()
    }
    
    // adding title label to the view
    private func addTitleLable(){
        
        titleLabel = UILabel(frame:CGRect(x: sliderLine.frame.minX  - handleDiameter/2.0, y: frame.height / 2.0  - titleLabelPadding - titleLabelHeight - handleDiameter / 2.0 , width: titleLabelWidth, height: titleLabelHeight) )
        titleLabel?.text = titleLabelText
        titleLabel?.textColor = titleLabelColor
        titleLabel?.numberOfLines = titleLabelLineNumbers
        titleLabel?.font = titleLabelFont
        addSubview(titleLabel!)
    }
    
    private func addRangeLabels(){
        
        calculateRangeValues()
        
        rangeLabel1 = UILabel(frame: CGRect(x: sliderLine.frame.minX - handleDiameter/2.0, y: sliderLine.frame.midY + handleDiameter/2.0 + rangeLabelPadding, width: rangeLabelWidth, height: rangeLabelHeight))
        addSubview(rangeLabel1!)
        rangeLabel1?.textAlignment = .left
        rangeLabel1?.font = rangeLabelsFont
        rangeLabel1?.text = "\(rangeLabelvalues[0].abbreviated)"
        
        
        rangeLabel5 = UILabel(frame: CGRect(x: sliderLine.frame.maxX + handleDiameter/2.0  - rangeLabelWidth, y: sliderLine.frame.midY + handleDiameter/2.0 + rangeLabelPadding, width: rangeLabelWidth, height: rangeLabelHeight))
        addSubview(rangeLabel5!)
        rangeLabel5?.textAlignment = .right
        rangeLabel5?.font = rangeLabelsFont
        rangeLabel5?.text =  "\(rangeLabelvalues[4].abbreviated)"
        
        
        rangeLabel3 = UILabel(frame: CGRect(x: sliderLine.frame.midX - rangeLabelWidth/2, y: sliderLine.frame.midY + handleDiameter/2.0 + rangeLabelPadding, width: rangeLabelWidth, height: rangeLabelHeight))
        addSubview(rangeLabel3!)
        rangeLabel3?.textAlignment = .center
        rangeLabel3?.font = rangeLabelsFont
        rangeLabel3?.text =  "\(rangeLabelvalues[2].abbreviated)"
        
        
        rangeLabel2 = UILabel(frame: CGRect(x:sliderLine.frame.midX - ((sliderLine.frame.midX - sliderLine.frame.minX)/2) - rangeLabelWidth/2, y: sliderLine.frame.midY + handleDiameter/2.0 + rangeLabelPadding, width: rangeLabelWidth, height: rangeLabelHeight))
        addSubview(rangeLabel2!)
        rangeLabel2?.textAlignment = .center
        rangeLabel2?.font = rangeLabelsFont
        rangeLabel2?.text =  "\(rangeLabelvalues[1].abbreviated)"
        
        
        rangeLabel4 = UILabel(frame: CGRect(x: sliderLine.frame.midX + (sliderLine.frame.maxX - sliderLine.frame.midX)/2 - rangeLabelWidth/2, y: sliderLine.frame.midY + handleDiameter/2.0 + rangeLabelPadding, width: rangeLabelWidth, height: rangeLabelHeight))
        addSubview(rangeLabel4!)
        rangeLabel4?.textAlignment = .center
        rangeLabel4?.font = rangeLabelsFont
        rangeLabel4?.text =  "\(rangeLabelvalues[3].abbreviated)"
        
        
    }
    
    func calculateRangeValues(){
        
        let rangeDiff = maxValue - minValue
        
        let rangeStepValue = rangeDiff/4.0
        
        for i in 0...3{
            
            let value = minValue + (CGFloat(i)*rangeStepValue)
            rangeLabelvalues.append(Int(value))
        }
        rangeLabelvalues.append(Int(maxValue))
    }
    
    private func percentageAlongLine(for value: CGFloat) -> CGFloat {
        // stops divide by zero errors where maxMinDif would be zero. If the min and max are the same the percentage has no point.
        guard minValue < maxValue else { return 0.0 }
        
        // get the difference between the maximum and minimum values (e.g if max was 100, and min was 50, difference is 50)
        let maxMinDif: CGFloat = maxValue - minValue
        
        // now subtract value from the minValue (e.g if value is 75, then 75-50 = 25)
        let valueSubtracted: CGFloat = value - minValue
        
        // now divide valueSubtracted by maxMinDif to get the percentage (e.g 25/50 = 0.5)
        return valueSubtracted / maxMinDif
    }
    
    private func xPositionAlongLine(for value: CGFloat) -> CGFloat {
        // first get the percentage along the line for the value
        let percentage: CGFloat = percentageAlongLine(for: value)
        
        // get the difference between the maximum and minimum coordinate position x values (e.g if max was x = 310, and min was x=10, difference is 300)
        let maxMinDif: CGFloat = sliderLine.frame.maxX - sliderLine.frame.minX
        
        // now multiply the percentage by the minMaxDif to see how far along the line the point should be, and add it onto the minimum x position.
        let offset: CGFloat = percentage * maxMinDif
        
        return sliderLine.frame.minX + offset
    }
    
    // update line height of slider line
    private func updateLineHeight() {
        let barSidePadding: CGFloat = 20.0 + handleDiameter/2.0
        let yMiddle: CGFloat = frame.height / 2.0
        let lineLeftSide: CGPoint = CGPoint(x: barSidePadding, y: yMiddle)
        let lineRightSide: CGPoint = CGPoint(x: frame.width - barSidePadding,
                                             y: yMiddle)
        sliderLine.frame = CGRect(x: lineLeftSide.x,
                                  y: lineLeftSide.y,
                                  width: lineRightSide.x - lineLeftSide.x,
                                  height: lineHeight)
        sliderLine.cornerRadius = lineHeight / 2.0
        sliderLineBetweenHandles.cornerRadius = sliderLine.cornerRadius
    }
    
    // update the baloon view position
    private func updateBaloonView(){
        
        if(handleTracking != .none){
            
            let handle: CALayer = (handleTracking == .left) ? leftHandle : rightHandle
            
            let rect = CGRect.init(x: handle.frame.midX - (baloonViewWidth/2) , y:handle.frame.minY - baloonViewHeight - baloonViewPadding, width: baloonViewWidth, height: baloonViewHeight)
            
            if(self.baloonView == nil){
                self.baloonView = BaloonView(frame: rect)
                if let aView = baloonView {
                    addSubview(aView)
                }
            }
            else{
                self.baloonView?.isHidden = false
                self.baloonView?.frame = rect
            }
            
            self.baloonView?.valueLbl.text =  (handle == leftHandle) ? "\(Int(lefthandleValue).abbreviated)" : "\(Int(rightHandleValue).abbreviated)"
        }
    }
    
    // updting the colors of slider handle and lines
    private func updateColors() {
        
        sliderLineBetweenHandles.backgroundColor = colorBetweenHandles.cgColor
        sliderLine.backgroundColor = sliderLineColor.cgColor
        
        let color: CGColor
        if let _ = handleImage {
            color = UIColor.clear.cgColor
        } else {
            color = handleColor.cgColor
        }
        leftHandle.backgroundColor = color
        leftHandle.borderColor = handleBorderColor.cgColor
        rightHandle.backgroundColor = color
        rightHandle.borderColor = handleBorderColor.cgColor

    }
    
    //updating touch handle positions
    private func updateHandlePositions() {
        leftHandle.position = CGPoint(x: xPositionAlongLine(for: lefthandleValue),
                                      y: sliderLine.frame.midY)
        
        rightHandle.position = CGPoint(x: xPositionAlongLine(for: rightHandleValue != CGFloat(INT_MAX) ? rightHandleValue : maxValue ),
                                       y: sliderLine.frame.midY)
        
        // positioning for the dist slider line
        sliderLineBetweenHandles.frame = CGRect(x: leftHandle.position.x,
                                                y: sliderLine.frame.minY,
                                                width: rightHandle.position.x - leftHandle.position.x,
                                                height: lineHeight)
    }
    
    fileprivate func refresh() {
        
        // update the frames in a transaction so that the tracking doesn't continue until the frame has moved.
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        updateHandlePositions()
        updateBaloonView()
        CATransaction.commit()
        
        // update the delegate
        if let delegate = delegate, handleTracking != .none {
            delegate.filter(self, didChange: min(lefthandleValue, rightHandleValue), maxValue: max(lefthandleValue, rightHandleValue))
        }
    }
    
    // animate the touch handles
    private func animate(handle: CALayer, selected: Bool) {
        
        let color:CGColor
        if selected {
            color = UIColor.clear.cgColor
        } else {
            color = handleColor.cgColor
        }
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.3)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut))
        handle.backgroundColor = color
        
        CATransaction.commit()
    }
}

// MARK: - CGRect

extension CGRect {
    
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}


// MARK: - CGPoint

private extension CGPoint {
    
    func distance(to: CGPoint) -> CGFloat {
        let distX: CGFloat = to.x - x
        let distY: CGFloat = to.y - y
        return sqrt(distX * distX + distY * distY)
    }
}

// MARK: - Int
private extension Int {
    var abbreviated: String {
        let abbrev = "KMBTPE"
        return abbrev
            .enumerated()
            .reversed()
            .reduce(nil as String?) { accum, tuple in
                let factor = Double(self) / pow(10, Double(tuple.0 + 1) * 3)
                let format = (factor - floor(factor) == 0 ? "%.0f%@" : "%.1f%@")
                return accum ?? (factor >= 1 ? String(format: format, factor, String(tuple.1)) : nil)
            } ?? String(self)
    }
}
