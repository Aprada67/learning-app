//
//  ContentModel.swift
//  LearningApp
//
//  Created by Alberto Jesús Prada Parmera on 21/11/2023.
//

import Foundation

class ContentModel: ObservableObject {
    
    // List of modules
    // Las vistas que observan esta propiedad se actualizarán automáticamente cuando cambie.
    @Published var modules = [Module]()
    
    // Current module
    // Mantiene un track del estado de las cosas, ej: Lo que esta viendo el usuario o que pregunta esta respondiendo.
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    // Current Lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    // Current Question
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
    // Current lesson explaination
    @Published var codeText = NSAttributedString()
    // No es published porque no va a cambiar
    var styleData: Data?
    
    // Current selected content and test
    @Published var currentContentSelected: Int?
    @Published var currentTestSelected: Int?
    
    init() {
        
        getLocalData()
        
    }
    
    // MARK: - Data methods
    
    func getLocalData() {
        
        // Get a url to the json file
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        // Read the file into a data object
        do {
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            // Try to decode the json file into an array of modules
            let jsonDecoder = JSONDecoder()
            
            /* When you pass a type like a method call or initializer method,
             you specify self to pass that as a parameter paas to type */
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            // Assign parsed modules to modules property
            self.modules = modules
            
        }
        catch {
            print("Couldn't parse local data")
        }
        
        // Parse the style data
        
        let styleData = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            // Read the file into a data object
            let styleData = try Data(contentsOf: styleData!)
            
            self.styleData = styleData
        }
        catch {
            // Log error
            print("Couldn't parse the style data")
        }
        
    }
    
    // MARK: - Module navigation methods
    
    func beginMoudule (_ moduleId: Int) {
        
        // Find the index for this module id
        for index in 0..<modules.count {
            
            if modules[index].id == index {
                
                // Fond the matching module
                currentModuleIndex = index
                break
                
            }
            
        }
        
        // Set the current module
        currentModule = modules[currentModuleIndex]
        
    }
    
    func beginLesson(_ lessonIndex: Int) {
        
        // Check that the lesson index is within range of module lessons
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        }
        else {
            currentLessonIndex = 0
        }
        
        // Set the current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        codeText = addStyling(currentLesson!.explanation)
        
    }
    
    func nextLesson() {
        
        // Advance the lesson index
        currentLessonIndex += 1
        
        // Check that it is within range
        if currentLessonIndex <  currentModule!.content.lessons.count {
            
            // Set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
        }
        else {
            // Reset the lesson state
            currentLesson = nil
            currentLessonIndex = 0
        }
        
    }
    
    func hasNextLesson() -> Bool {
        
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
        
    }
    
    func beginTest(_ moduleID: Int) {
        
        // Set the current module
        beginMoudule(moduleID)
        
        // Set the current question index
        currentQuestionIndex = 0
        
        // If there are questions, set the current question to the first one
        if currentModule?.test.questions.count ?? 0 > 0 {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            
            // Set the question content
            codeText = addStyling(currentQuestion!.content)
        }
    }
    
    // MARK: - Code Styling
    
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
        
        // Add the styling data
        if styleData != nil {
            data.append(styleData!)
        }
        
        // Add the html data
        data.append(Data(htmlString.utf8))
        
        // Convert to attributed string
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            
            resultString = attributedString
        }
        
        return resultString
        
    }
    
}
