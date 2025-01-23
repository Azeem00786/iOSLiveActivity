import Foundation
import ActivityKit
import React

@objc(LiveActivityBridge)
class LiveActivityBridge: NSObject {
  
  @objc
  func startActivity(_ restaurantName: String, orderNumber: String, eta: String, callback: @escaping RCTResponseSenderBlock) {
    if ActivityAuthorizationInfo().areActivitiesEnabled {
      let attributes = FoodTrackAttributes(restaurantName: restaurantName, orderNumber: orderNumber)
      let state = FoodTrackAttributes.ContentState(eta: eta, status: "preparing")
      
      do {
        let activity = try Activity.request(attributes: attributes, contentState: state)
        callback([NSNull(), activity.id])
      } catch {
        callback([error.localizedDescription, NSNull()])
      }
    } else {
      callback(["Live Activities not enabled", NSNull()])
    }
  }
  
  @objc
  func updateActivity(_ id: String, eta: String, status: String, callback: @escaping RCTResponseSenderBlock) {
    Task {
      for activity in Activity<FoodTrackAttributes>.activities where activity.id == id {
        let updatedState = FoodTrackAttributes.ContentState(eta: eta, status: status)
        await activity.update(using: updatedState)
        callback([NSNull(), "Updated"])
        return
      }
      callback(["Activity not found", NSNull()])
    }
  }
  
  @objc
  func endActivity(_ id: String, callback: @escaping RCTResponseSenderBlock) {
    Task {
      for activity in Activity<FoodTrackAttributes>.activities where activity.id == id {
        await activity.end(dismissalPolicy: .immediate)
        callback([NSNull(), "Ended"])
        return
      }
      callback(["Activity not found", NSNull()])
    }
  }
  
  @objc
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
