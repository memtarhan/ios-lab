//
//  RangeSlider.swift
//  PriceSlider
//
//  Created by Mehmet Tarhan on 07/07/2023.
//

import UIKit

import QuartzCore

protocol RangeSliderDelegate: AnyObject {
    func rangeSlider(didUpdateLower value: CGFloat)
    func rangeSlider(didUpdateUpper value: CGFloat)
}

class RangeSliderView: UIView {
    private lazy var lowerValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var higherValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    var selectedLowerValue: Int = 0 {
        didSet {
            lowerValueLabel.text = "\(selectedLowerValue)"
        }
    }

    var selectedUpperValue: Int = 0 {
        didSet {
            higherValueLabel.text = "\(selectedUpperValue)"
        }
    }

    init(frame: CGRect,
         lowestBound: Int,
         defaultLowerValue: Int,
         highestBound: Int,
         defaultHigherValue: Int) {
        super.init(frame: frame)

        let halfHeight = frame.height / 2
        let slider = RangeSlider(frame: CGRect(x: 0, y: halfHeight - 4, width: frame.width, height: halfHeight),
                                 lowestBound: CGFloat(lowestBound),
                                 defaultLowerValue: CGFloat(defaultLowerValue),
                                 highestBound: CGFloat(highestBound),
                                 defaultHigherValue: CGFloat(defaultHigherValue))
        slider.delegate = self
        addSubview(slider)

        addSubview(lowerValueLabel)
        addSubview(higherValueLabel)

        NSLayoutConstraint.activate([
            lowerValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            lowerValueLabel.topAnchor.constraint(equalTo: topAnchor),
            higherValueLabel.topAnchor.constraint(equalTo: topAnchor),
            higherValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])

        lowerValueLabel.text = "\(Int(defaultLowerValue))"
        higherValueLabel.text = "\(Int(defaultHigherValue))"
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension RangeSliderView: RangeSliderDelegate {
    func rangeSlider(didUpdateLower value: CGFloat) {
        selectedLowerValue = Int(value)
    }

    func rangeSlider(didUpdateUpper value: CGFloat) {
        selectedUpperValue = Int(value)
    }
}

class RangeSlider: UIControl {
    private(set) var lowestBound: CGFloat
    private(set) var highestBound: CGFloat

    weak var delegate: RangeSliderDelegate?

    var lowerValue: CGFloat
    var upperValue: CGFloat

    private let trackLayer = RangeSliderTrackLayer() // = CALayer() defined in RangeSliderTrackLayer.swift
    private let lowerThumbLayer = RangeSliderThumbLayer() // CALayer()
    private let upperThumbLayer = RangeSliderThumbLayer() // CALayer()
    private var previousLocation = CGPoint()

    private(set) var trackTintColor: UIColor
    private(set) var trackHighlightTintColor: UIColor
    private(set) var thumbTintColor: UIColor

    var curvaceousness: CGFloat = 1.0

    var thumbWidth: CGFloat {
        return CGFloat(bounds.height)
    }

    init(frame: CGRect,
         lowestBound: CGFloat,
         defaultLowerValue: CGFloat,
         highestBound: CGFloat,
         defaultHigherValue: CGFloat,
         trackTintColor: UIColor = UIColor.secondaryLabel,
         trackHighlightTintColor: UIColor = UIColor.secondarySystemBackground,
         thumbTintColor: UIColor = UIColor.red) {
        self.lowestBound = lowestBound
        self.highestBound = highestBound

        lowerValue = lowestBound
        upperValue = highestBound

        self.trackTintColor = trackTintColor
        self.trackHighlightTintColor = trackHighlightTintColor
        self.thumbTintColor = thumbTintColor

        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false

        trackLayer.rangeSlider = self
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)

        lowerThumbLayer.rangeSlider = self
        lowerThumbLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(lowerThumbLayer)

        upperThumbLayer.rangeSlider = self
        upperThumbLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(upperThumbLayer)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func updateLayerFrames() {
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
        trackLayer.setNeedsDisplay()

        let lowerThumbCenter = CGFloat(positionForValue(value: lowerValue))

        lowerThumbLayer.frame = CGRect(x: lowerThumbCenter - thumbWidth / 2.0, y: 0.0,
                                       width: thumbWidth, height: thumbWidth)
        lowerThumbLayer.setNeedsDisplay()

        let upperThumbCenter = CGFloat(positionForValue(value: upperValue))
        upperThumbLayer.frame = CGRect(x: upperThumbCenter - thumbWidth / 2.0, y: 0.0,
                                       width: thumbWidth, height: thumbWidth)
        upperThumbLayer.setNeedsDisplay()
    }

    func positionForValue(value: Double) -> Double {
        return Double(bounds.width - thumbWidth) * (value - lowestBound) /
            (highestBound - lowestBound) + Double(thumbWidth / 2.0)
    }

    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)

        // Hit test the thumb layers
        if lowerThumbLayer.frame.contains(previousLocation) {
            lowerThumbLayer.highlighted = true
        } else if upperThumbLayer.frame.contains(previousLocation) {
            upperThumbLayer.highlighted = true
        }

        return lowerThumbLayer.highlighted || upperThumbLayer.highlighted
    }

    func boundValue(value: Double, toLowerValue lowerValue: Double, upperValue: Double) -> Double {
        return min(max(value, lowerValue), upperValue)
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)

        // 1. Determine by how much the user has dragged
        let deltaLocation = Double(location.x - previousLocation.x)
        let deltaValue = (highestBound - lowestBound) * deltaLocation / Double(bounds.width - thumbWidth)

        previousLocation = location

        // 2. Update the values
        if lowerThumbLayer.highlighted {
            lowerValue += deltaValue
            lowerValue = boundValue(value: lowerValue, toLowerValue: lowestBound, upperValue: upperValue)
            delegate?.rangeSlider(didUpdateLower: lowerValue)
        } else if upperThumbLayer.highlighted {
            upperValue += deltaValue
            upperValue = boundValue(value: upperValue, toLowerValue: lowerValue, upperValue: highestBound)
            delegate?.rangeSlider(didUpdateUpper: upperValue)
        }

        // 3. Update the UI
        CATransaction.begin()
        CATransaction.setDisableActions(true)

        updateLayerFrames()

        CATransaction.commit()

        sendActions(for: .valueChanged)

        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerThumbLayer.highlighted = false
        upperThumbLayer.highlighted = false
    }
}

class RangeSliderThumbLayer: CALayer {
    var highlighted = false
    weak var rangeSlider: RangeSlider?

    override func draw(in ctx: CGContext) {
        if let slider = rangeSlider {
            let thumbFrame = bounds.insetBy(dx: 2.0, dy: 2.0)
            let cornerRadius = thumbFrame.height * slider.curvaceousness / 2.0
            let thumbPath = UIBezierPath(roundedRect: thumbFrame, cornerRadius: cornerRadius)

            // Fill - with a subtle shadow
            let shadowColor = UIColor.gray
//            ctx.setShadow(offset: CGSize(width: 0.0, height: 1.0), blur: 1.0, color: shadowColor.cgColor)
            ctx.setFillColor(slider.thumbTintColor.cgColor)
            ctx.addPath(thumbPath.cgPath)
            ctx.fillPath()

            // Outline
            ctx.setStrokeColor(shadowColor.cgColor)
            ctx.setLineWidth(0.5)
            ctx.addPath(thumbPath.cgPath)
            ctx.strokePath()

            if highlighted {
                ctx.setFillColor(UIColor(white: 0.0, alpha: 0.1).cgColor)
                ctx.addPath(thumbPath.cgPath)
                ctx.fillPath()
            }
        }
    }
}

class RangeSliderTrackLayer: CALayer {
    weak var rangeSlider: RangeSlider?

    override func draw(in ctx: CGContext) {
        if let slider = rangeSlider {
            // Clip
            let cornerRadius = bounds.height * slider.curvaceousness / 2.0
            let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            ctx.addPath(path.cgPath)

            // Fill the track
            ctx.setFillColor(slider.trackTintColor.cgColor)
            ctx.addPath(path.cgPath)
            ctx.fillPath()

            // Fill the highlighted range
            ctx.setFillColor(slider.trackHighlightTintColor.cgColor)
            let lowerValuePosition = CGFloat(slider.positionForValue(value: slider.lowerValue))
            let upperValuePosition = CGFloat(slider.positionForValue(value: slider.upperValue))
            let rect = CGRect(x: lowerValuePosition, y: 0.0, width: upperValuePosition - lowerValuePosition, height: bounds.height)
            ctx.fill(rect)
        }
    }
}
