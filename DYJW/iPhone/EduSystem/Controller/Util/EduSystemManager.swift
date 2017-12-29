//
//  EduSystemManager.swift
//  DYJW
//
//  Created by 风筝 on 2017/12/28.
//  Copyright © 2017年 Doge Studio. All rights reserved.
//

import UIKit
import Alamofire
import Fuzi

fileprivate let JSESSIONID = "JSESSIONID"

class EduSystemManager: NSObject {
    
    static let shared = EduSystemManager()
        
    func login(with user: User, verifycode: String, completion: @escaping (String?) -> Void) {
        let params: [String: String] = [
            "USERNAME": user.username,
            "PASSWORD": user.password,
            "RANDOMCODE": verifycode
        ]
        let url = "http://jwgl.nepu.edu.cn/Logon.do?method=logon"
        let request = Alamofire.request(url,
                                        method: .post,
                                        parameters: params)
        request.responseString { (response) in
            guard response.result.isSuccess else {
                // 登录失败
                print(String(describing: response.error))
                completion("网络连接失败，请稍后重试")
                return
            }
            guard let html = response.value else {
                return
            }
            if html.contains("window.location.href='http://jwgl.nepu.edu.cn/framework/main.jsp'") {
                // 登录成功，进行下一步
                let sessionId = self.getSessionId(from: response)
                user.lastSessionId = sessionId ?? ""
                self.getName(of: user, completion: completion)
            } else {
                // 登录失败，查找失败原因
                do {
                    let doc = try HTMLDocument(string: html)
                    let errorMessage = doc.css("span#errorinfo").first?.stringValue ?? "未知原因"
                    print("登录失败：\(errorMessage)")
                    completion(errorMessage)
                } catch {
                    print("Convert HTML failed: \(error)")
                }
            }
        }
        request.resume()
    }
    
    fileprivate func getName(of user: User, completion: @escaping (String?) -> Void) {
        let url = "http://jwgl.nepu.edu.cn/framework/main.jsp"
        let request = Alamofire.request(url, method: .post)
        request.responseString { (response) in
            guard response.result.isSuccess else {
                // 登录失败
                print(String(describing: response.error))
                completion("网络连接失败，请稍后重试")
                return
            }
            guard let html = response.value else {
                return
            }
            do {
                let doc = try HTMLDocument(string: html)
                if let title = doc.title, let index = title.index(of: "[") {
                    user.name = String(title[..<index])
                }
                self.logonBySSO(user: user, completion: completion)
            } catch {
                print("Convert HTML failed: \(error)")
            }
        }
        request.resume()
    }
    
    fileprivate func logonBySSO(user: User, completion: @escaping (String?) -> Void) {
        let url = "http://jwgl.nepu.edu.cn/Logon.do?method=logonBySSO"
        let request = Alamofire.request(url, method: .post)
        request.responseString { (response) in
            guard response.result.isSuccess else {
                // 登录失败
                print(String(describing: response.error))
                completion("网络连接失败，请稍后重试")
                return
            }
            self.changePageSize(user: user, completion: completion)
        }
        request.resume()
    }
    
    fileprivate func changePageSize(user: User, completion: @escaping (String?) -> Void) {
        let url = "http://jwgl.nepu.edu.cn/yhxigl.do?method=editUserInfo"
        let params = [
            "account" : user.username,
            "realName" : user.name,
            "pwdQuestion1" : "",
            "pwdAnswer1" : "",
            "pwdQuestion2" : "",
            "pwdAnswer2" : "",
            "pageSize" : "200",
            "zjftxt" : "",
            "kyjftxt" : ""
        ]
        let request = Alamofire.request(url, method: .post, parameters: params)
        request.responseString { (response) in
            guard response.result.isSuccess else {
                // 登录失败
                print(String(describing: response.error))
                completion("网络连接失败，请稍后重试")
                return
            }
            completion(nil)
        }
    }
    
    fileprivate func getSessionId(from response: DataResponse<String>) -> String? {
        if let headers = response.response?.allHeaderFields as? [String: String]
            , let url = URL(string: "http://jwgl.nepu.edu.cn/") {
            
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: headers, for: url)
            for cookie in cookies {
                if cookie.name == JSESSIONID {
                    print("\(cookie.name) = \(cookie.value)")
                    return cookie.value
                }
            }
        }
        return nil
    }
    
}
