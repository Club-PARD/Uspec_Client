//
//  API.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/15/24.
//

import UIKit

struct UrlLink {
    static let urlLink = "http://mz-env-1.eba-mmgm92cc.ap-northeast-2.elasticbeanstalk.com"
}


class APICallers {
    static let shared = APICallers()
    
    func makePostRequest(with nickName: String, university: String, age: Int, semester: Int, isGraduated: Bool, score: String, major: String, isThree: Bool, isGradeOpen: Bool, path: String ) {
        guard let url = URL(string: "\(UrlLink.urlLink)/user") else {
            print("🚨 Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body:[String: AnyHashable] = [
            "name": nickName,
            "age": age,
            "school": university,
            "graduate": isGraduated,
            "semester": semester,
            "major": major,
            "grade": score,
            "gradeOpen": isGradeOpen,
            "three": isThree,
            "path": path
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print("🚨 Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("✅ success: \(response)")
            } catch {
                print("🚨 ", error)
            }
        }
        task.resume()
    }

}

