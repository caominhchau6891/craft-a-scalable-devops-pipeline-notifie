import Foundation

// Define a struct to represent a notification
struct Notification {
    let id: Int
    let message: String
    let severity: Severity
    let timestamp: Date
}

// Define an enum to represent the severity of a notification
enum Severity: String {
    case info
    case warning
    case error
}

// Define a class to represent a DevOps pipeline
class DevOpsPipeline {
    let name: String
    let stages: [Stage]
    
    init(name: String, stages: [Stage]) {
        self.name = name
        self.stages = stages
    }
}

// Define a class to represent a stage in a DevOps pipeline
class Stage {
    let name: String
    let notifications: [Notification]
    
    init(name: String, notifications: [Notification] = []) {
        self.name = name
        self.notifications = notifications
    }
}

// Define a class to handle notifications for a DevOps pipeline
class NotificationHandler {
    let pipeline: DevOpsPipeline
    let notificationService: NotificationService
    
    init(pipeline: DevOpsPipeline, notificationService: NotificationService) {
        self.pipeline = pipeline
        self.notificationService = notificationService
    }
    
    // Method to send notifications for a stage
    func sendNotifications(for stage: Stage) {
        for notification in stage.notifications {
            notificationService.send(notification: notification)
        }
    }
}

// Define a protocol for a notification service
protocol NotificationService {
    func send(notification: Notification)
}

// Define a class to implement the notification service protocol
class EmailNotificationService: NotificationService {
    func send(notification: Notification) {
        print("Sending email notification: \(notification.message) with severity \(notification.severity.rawValue)")
    }
}

// Define a class to implement the notification service protocol
class SlackNotificationService: NotificationService {
    func send(notification: Notification) {
        print("Sending Slack notification: \(notification.message) with severity \(notification.severity.rawValue)")
    }
}

// Create a DevOps pipeline
let pipeline = DevOpsPipeline(name: "My Pipeline", stages: [
    Stage(name: "Build", notifications: [
        Notification(id: 1, message: "Build successful", severity: .info, timestamp: Date()),
        Notification(id: 2, message: "Build failed", severity: .error, timestamp: Date())
    ]),
    Stage(name: "Deploy", notifications: [
        Notification(id: 3, message: "Deploy successful", severity: .info, timestamp: Date())
    ])
])

// Create a notification handler with an email notification service
let notificationHandler = NotificationHandler(pipeline: pipeline, notificationService: EmailNotificationService())

// Send notifications for each stage
for stage in pipeline.stages {
    notificationHandler.sendNotifications(for: stage)
}