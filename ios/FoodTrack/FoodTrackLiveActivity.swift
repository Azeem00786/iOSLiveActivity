//
//  FoodTrackLiveActivity.swift
//  FoodTrack
//
//  Created by Mohammad Salman on 23/01/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct FoodDeliveryAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var status: String
        var eta: String
        var driverName: String
        var orderNumber: String
    }

    var restaurantName: String
    var restaurantLogo: String
}

struct FoodTrackLiveActivityView: View {
    let context: ActivityViewContext<FoodDeliveryAttributes>
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: URL(string: context.attributes.restaurantLogo)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(context.attributes.restaurantName)
                        .font(.headline)
                    Text("Order #\(context.state.orderNumber)")
                        .font(.subheadline)
                }
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Status: \(context.state.status)")
                Text("Driver: \(context.state.driverName)")
                Text("ETA: \(context.state.eta)")
            }
            .font(.subheadline)
        }
        .padding()
        .activityBackgroundTint(Color.white)
        .activitySystemActionForegroundColor(Color.black)
    }
}

struct FoodTrackLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FoodDeliveryAttributes.self) { context in
            FoodTrackLiveActivityView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    AsyncImage(url: URL(string: context.attributes.restaurantLogo)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.status)
                }
                DynamicIslandExpandedRegion(.center) {
                    Text("Order #\(context.state.orderNumber)")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack(alignment: .leading) {
                        Text("Driver: \(context.state.driverName)")
                        Text("ETA: \(context.state.eta)")
                    }
                }
            } compactLeading: {
                Text("🍔")
            } compactTrailing: {
                Text(context.state.eta)
            } minimal: {
                Text("🍔")
            }
            .widgetURL(URL(string: "foodpanda://order/\(context.state.orderNumber)"))
            .keylineTint(Color.orange)
        }
    }
}

extension FoodDeliveryAttributes {
    fileprivate static var preview: FoodDeliveryAttributes {
        FoodDeliveryAttributes(
            restaurantName: "Burger King",
            restaurantLogo: "https://logo.com/burgerking.png"
        )
    }
}

extension FoodDeliveryAttributes.ContentState {
    fileprivate static var preparing: FoodDeliveryAttributes.ContentState {
        FoodDeliveryAttributes.ContentState(
            status: "Preparing",
            eta: "15 mins",
            driverName: "John Doe",
            orderNumber: "12345"
        )
    }
     
    fileprivate static var onTheWay: FoodDeliveryAttributes.ContentState {
        FoodDeliveryAttributes.ContentState(
            status: "On the way",
            eta: "8 mins",
            driverName: "John Doe",
            orderNumber: "12345"
        )
    }
}

#Preview("Notification", as: .content, using: FoodDeliveryAttributes.preview) {
   FoodTrackLiveActivity()
} contentStates: {
    FoodDeliveryAttributes.ContentState.preparing
    FoodDeliveryAttributes.ContentState.onTheWay
}
