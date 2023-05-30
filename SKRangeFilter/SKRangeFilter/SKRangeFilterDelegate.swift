//
//  SKRangeFilterDelegate.swift
//

import Foundation
import  UIKit


public protocol SKRangeFilterDelegate: AnyObject{
    
    /// Called when the SKRangeFilter values are changed
    ///
    /// - Parameters:
    ///   - filter: SKRangeFilter
    ///   - minValue: minimum value
    ///   - maxValue: maximum value
    func filter(_ filter: SKRangeFilter, didChange minValue: CGFloat, maxValue: CGFloat)
    
    /// Called when the user has started interacting with the ATSlider
    ///
    /// - Parameter filter: SKRangeFilter
    func didStartTouches(in filter: SKRangeFilter)
    
    /// Called when the user has finished interacting with the ATSlider
    ///
    /// - Parameter filter: SKRangeFilter
    func didEndTouches(in filter: SKRangeFilter)
    
}


// MARK: - Default implementation

public extension SKRangeFilterDelegate {
    
    func filter(_ filter: SKRangeFilter, didChange minValue: CGFloat, maxValue: CGFloat) {}
    func didStartTouches(in filter: SKRangeFilter) {}
    func didEndTouches(in filter: SKRangeFilter) {}
    
}
