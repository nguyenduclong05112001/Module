//
//  APIManager.swift
//  LS
//
//  Created by macmini on 04/08/2023.
//

import Foundation
import UIKit



public class APIManager {
    private init (){}
    public static let standard = APIManager()
    
    private var dataTask: URLSessionDataTask?
    
    let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(30)
        configuration.timeoutIntervalForResource = TimeInterval(60)
        let session = URLSession(configuration: configuration)
        return session
    }()

    func createParameters(_ parameters: [String: AnyObject]?) -> [String: AnyObject] {
        var newParamters: [String: AnyObject] = [:]
        if let parameters = parameters {
            let keys = parameters.keys
            for key in keys {
                newParamters.updateValue(parameters[key]!, forKey: key)
            }
        }
        return newParamters
    }
    
    public func commonRequest<T: Decodable>(
        urlString: String,
        method: APIMethod,
        header: [String: Any]? = nil,
        payload: [String: Any]? = nil,
        completion: @escaping (Result<APICommonResponse<T>, APIError>) -> Void
    ) {
        guard Reachability.shared.isConnectedToNetwork() else {
            completion(.failure(.serverError(code: "", message: "Network is unstable. Please make sure your network is connected and try again.")))
            return
        }

        var urlStringWithQuery = urlString
        if method == .get, let payload = payload {
            let queryItems = payload.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
            urlStringWithQuery += "?\(queryItems)"
        }

        guard let url = URL(string: urlStringWithQuery) else {
            Logger.shared.Logs(event: .error, message: "Invalid URL: \(urlStringWithQuery)")
            completion(.failure(.unexpected(code: 0, message: "Invalid URL")))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if method != .get, let payload = payload {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted)
            } catch {
                Logger.shared.Logs(event: .error, message: "JSON Serialization Error: \(error.localizedDescription)")
                completion(.failure(.insiderError(error: error)))
                return
            }
        }

        var requestHeader = Header.getSimpleHeader()
        header?.forEach { key, value in
            requestHeader[key] = value
        }

        requestHeader.forEach { key, value in
            if let value = value as? String {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }

        Logger.shared.Logs(event: .debug, message: request.curlString)

        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                let errorType: APIError = (error as? URLError)?.code == .timedOut
                    ? .serverError(code: "REQUEST_TIME_OUT", message: "Please check your internet connection and try again!")
                    : .insiderError(error: error)

                completion(.failure(errorType))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                completion(.failure(.unexpected(code: 0, message: "No response data")))
                return
            }

            do {
                let jsonResponse = try JSONDecoder().decode(APICommonResponse<EmptyData>.self, from: data)

                guard let responseCode = jsonResponse.code else {
                    completion(.failure(.unexpected(code: httpResponse.statusCode, message: "Missing response code")))
                    return
                }

                if responseCode != "200" {
                    completion(.failure(.serverError(code: responseCode, message: jsonResponse.messages)))
                    return
                }

                let successResponse = try JSONDecoder().decode(APICommonResponse<T>.self, from: data)
                Logger.shared.Logs(event: .debug, message: """
                    RESPONSE CODE: \(successResponse.code ?? "nil")
                    STATUS CODE: \(httpResponse.statusCode)
                    DATA RESPONSE: \(String(describing: successResponse.data))
                """)
                completion(.success(successResponse))

            } catch {
                Logger.shared.Logs(event: .debug, message: "Decoding Error: \(error.localizedDescription)")
                completion(.failure(.insiderError(error: error)))
            }
        }

        dataTask.resume()
    }

    
}


