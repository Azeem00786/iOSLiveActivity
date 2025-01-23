//
//  FoodTrack.swift
//  FoodTrack
//
//  Created by Mohammad Salman on 23/01/25.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct FoodTrackEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)

            Text("Emoji:")
            Text(entry.emoji)
        }
    }
}

struct FoodTrack: Widget {
    let kind: String = "FoodTrack"

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FoodDeliveryAttributes.self) { context in
            // Live Activity view
            FoodTrackLiveActivityView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded views
                DynamicIslandExpandedRegion(.leading) {
                    Text("🍔")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("🍟")
                }
                DynamicIslandExpandedRegion(.center) {
                    Text("Food Delivery")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("ETA: \(context.state.eta)")
                }
            } compactLeading: {
                Text("🍔")
            } compactTrailing: {
                Text("🍟")
            } minimal: {
                Text("🍔")
            }
        }
        .configurationDisplayName("Food Delivery")
        .description("Track your food delivery status")
    }
}

#Preview(as: .systemSmall) {
    FoodTrack()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
