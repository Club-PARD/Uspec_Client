//
//  API.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/15/24.
//

import UIKit

let urlLink = "http://3.35.236.83"

func makePostRequest(with imgUrl: String, name: String, age: Int, part: String) {
    // 서버 링크가 유요한지 확인
    guard let url = URL(string: "\(urlLink)/user") else {
        print("🚨 Invalid URL")
        return
    }
    // request 생성하기
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    // json 형식으로 데이터 전송할 것임
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    // POST로 요청할 경우 : json 형식으로 데이터 넘기기
    let body:[String: AnyHashable] = [
        "name": name,
        "age": age,
        "part": part,
        "imgURL": imgUrl
    ]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

    // data task 생성하기
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        // 응답 처리하기
        guard let data = data, error == nil else {
            print("🚨 Error: \(error?.localizedDescription ?? "Unknown error")")
            return
        }
        do {
            // 데이터를 성공적으로 받은 경우, 해당 데이터를 JSON으로 파싱하기
            let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            // 정상적으로 response를 받은 경우, notification center를 사용하여 알림 보내기
            print("✅ success: \(response)")
//            DispatchQueue.main.async {
//                NotificationCenter.default.post(name: .addNotification, object: nil)
//                print("✅ notification 완료 in makeUpdateRequest")
//            }
        } catch {
            print("🚨 ", error)
        }
    }
    // 시작하기. 꼭 적어줘야 함 !
    task.resume()
}
