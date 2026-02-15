//
//  User.swift
//  SharedAssets
//
//  Created by app-kaihatsusha on 13/02/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//


struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int
}

struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height, weight: Double
    
    enum CodingKeys: CodingKey {
        case id
        case firstName
        case lastName
        case age
        case email
        case phone
        case username
        case password
        case image
        case height
        case weight
    }
    
    let work = "Worker at some job"
    let education = "Graduate Degree"
    let aboutMe = "This is a sentance about me that will look good on my profile."
    
    
    var images: [String] {
        [
            "https://picsum.photos/500/500",
            "https://picsum.photos/600/600",
            "https://picsum.photos/700/700"
        ]
    }
    
    var noInterests: [UserInterest] = []
    
    var basics: [UserInterest] {
        [ UserInterest(iconNme: "ruler", emoji: nil, text: "\(height)"),
          UserInterest(iconNme: "graduationcap", emoji: nil, text: "\(education)"),
          UserInterest(iconNme: "wineglass", emoji: nil, text: "Socially Motivated"),
          UserInterest(iconNme: "moon.stars.fill", emoji: nil, text: "Virgo"),
          UserInterest(iconNme: "soccerball", emoji: nil, text: "Football"),
          ]
    }
    
    var interests: [UserInterest] {
        [ UserInterest(iconNme: nil, emoji: "👟", text: "Running"),
          UserInterest(iconNme: nil, emoji: "🏋️", text: "Gym Workouts"),
          UserInterest(iconNme: nil, emoji: "🎧", text: "Music"),
          UserInterest(iconNme: nil, emoji: "🥘", text: "Cooking"),
          UserInterest(iconNme: nil, emoji: "🚗", text: "Driving"),
          ]
    }
    
    static var mock: User {
        User(
            id: 444,
            firstName: "App",
            lastName: "Kaihatsusha",
            age: 50,
            email: "you@here.com",
            phone: "",
            username: "",
            password: "",
            image: Constants.randomImage,
            height: 180,
            weight: 200
        )
    }
}
