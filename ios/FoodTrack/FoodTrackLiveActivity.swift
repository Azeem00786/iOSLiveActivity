//
//  FoodTrackLiveActivity.swift
//  FoodTrack
//
//  Created by Mohammad Salman on 23/01/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct FoodTrackAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct FoodTrackLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FoodTrackAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension FoodTrackAttributes {
    fileprivate static var preview: FoodTrackAttributes {
        FoodTrackAttributes(name: "World")
    }
}

extension FoodTrackAttributes.ContentState {
    fileprivate static var smiley: FoodTrackAttributes.ContentState {
        FoodTrackAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: FoodTrackAttributes.ContentState {
         FoodTrackAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: FoodTrackAttributes.preview) {
   FoodTrackLiveActivity()
} contentStates: {
    FoodTrackAttributes.ContentState.smiley
    FoodTrackAttributes.ContentState.starEyes
}
