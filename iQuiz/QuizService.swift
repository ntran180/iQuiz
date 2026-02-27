//
//  QuizService.swift
//  iQuiz
//
//  Created by Nam Tran on 2/24/26.
//

import Foundation
import Network

class QuizService {

    static let shared = QuizService()
    private init() {}

    private let defaultURL = "http://tednewardsandbox.site44.com/questions.json"

    func fetchQuizzes(completion: @escaping (Result<[Quiz], Error>) -> Void) {

        let urlString = UserDefaults.standard.string(forKey: "quizURL") ?? defaultURL

        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }

        if !isNetworkAvailable() {
            if let localQuizzes = loadQuizzesLocally(){
                completion(.success(localQuizzes))
            } else {
                completion(.failure(NSError(domain: "No Internet Connection", code: 0)))
            }
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0)))
                return
            }

            do {
                let quizzes = try JSONDecoder().decode([Quiz].self, from: data)
                
                self.saveQuizzesLocally(data: data)
                completion(.success(quizzes))
                
            } catch {
                completion(.failure(error))
            }

        }.resume()
    }
    private func saveQuizzesLocally(data: Data) {
        let url = getLocalFileURL()
        try? data.write(to: url)
    }

    private func loadQuizzesLocally() -> [Quiz]? {
        let url = getLocalFileURL()

        guard let data = try? Data(contentsOf: url) else {
            return nil
        }

        return try? JSONDecoder().decode([Quiz].self, from: data)
    }

    private func getLocalFileURL() -> URL {
        let documents = FileManager.default.urls(for: .documentDirectory,
                                                 in: .userDomainMask)[0]
        return documents.appendingPathComponent("quizzes.json")
    }


    private func isNetworkAvailable() -> Bool {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitor")
        var available = false

        monitor.pathUpdateHandler = { path in
            available = path.status == .satisfied
        }

        monitor.start(queue: queue)
        sleep(1)
        monitor.cancel()
        return available
    }
}
