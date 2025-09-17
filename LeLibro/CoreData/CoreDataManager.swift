//
//  CoreDataManager.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 14.09.25.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let context = AppDelegate().persistentContainer.viewContext
    
    func fetchBooks() -> [BookEntity] {
        do {
            return try context.fetch(BookEntity.fetchRequest()) as! [BookEntity]
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Core Data save error: \(error.localizedDescription)")
        }
    }
    
    func addSampleBooks(context: NSManagedObjectContext) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let booksData: [[String: Any]] = [
            // --- Fantasy ---
            ["title": "Harry Potter and the Sorcerer's Stone",
             "author": "J.K. Rowling",
             "publishedDate": "26-06-1997",
             "genre": "Fantasy",
             "summary": """
            Eleven-year-old Harry Potter discovers that he is a wizard on his birthday and receives an invitation to Hogwarts School of Witchcraft and Wizardry. \
            At Hogwarts, he makes friends, learns magic, and uncovers the mystery surrounding his parents' death. \
            As he faces challenges from dark forces and uncovers secrets of the wizarding world, Harry begins his journey as a hero destined to confront the dark wizard Voldemort.
            """,
             "coverImage": "harry_potter1",
             "rating": 4.8,
             "price": 9.99],
            
            ["title": "Harry Potter and the Chamber of Secrets",
             "author": "J.K. Rowling",
             "publishedDate": "02-07-1998",
             "genre": "Fantasy",
             "summary": """
            Harry returns for his second year at Hogwarts and discovers that a dark force is petrifying students. \
            With the help of his friends Ron and Hermione, he uncovers secrets about the Chamber of Secrets. \
            Facing danger and mystery, Harry grows braver and wiser as a young wizard.
            """,
             "coverImage": "harry_potter2",
             "rating": 4.7,
             "price": 10.99],
            
            ["title": "The Hobbit",
             "author": "J.R.R. Tolkien",
             "publishedDate": "21-09-1937",
             "genre": "Fantasy",
             "summary": """
            Bilbo Baggins, a quiet hobbit, is swept into an epic quest by the wizard Gandalf and a company of dwarves. \
            They seek to reclaim the dwarves' homeland from the dragon Smaug. \
            Bilbo encounters trolls, goblins, and discovers courage and cleverness he never knew he had.
            """,
             "coverImage": "hobbit",
             "rating": 4.7,
             "price": 12.99],
            
            ["title": "The Fellowship of the Ring",
             "author": "J.R.R. Tolkien",
             "publishedDate": "29-07-1954",
             "genre": "Fantasy",
             "summary": """
            Frodo Baggins inherits the One Ring, a powerful artifact that could enslave Middle-earth. \
            He begins a perilous journey to destroy it, forming a fellowship of diverse heroes. \
            They face treacherous lands, dark creatures, and the looming threat of Sauron.
            """,
             "coverImage": "lotr1",
             "rating": 4.9,
             "price": 15.99],
            
            ["title": "The Two Towers",
             "author": "J.R.R. Tolkien",
             "publishedDate": "11-11-1954",
             "genre": "Fantasy",
             "summary": """
            The fellowship is broken, but the quest continues. \
            Frodo and Sam journey to Mordor, guided by the enigmatic Gollum. \
            Meanwhile, Aragorn, Legolas, and Gimli fight to save Middle-earth from Sauron's armies.
            """,
             "coverImage": "lotr2",
             "rating": 4.9,
             "price": 15.99],
            
            ["title": "The Return of the King",
             "author": "J.R.R. Tolkien",
             "publishedDate": "20-10-1955",
             "genre": "Fantasy",
             "summary": """
            The final confrontation with Sauron unfolds as Frodo approaches Mount Doom. \
            Allies unite to fight in epic battles, and the fate of Middle-earth hangs in the balance. \
            Sacrifice, courage, and friendship shape the conclusion of this legendary saga.
            """,
             "coverImage": "lotr3",
             "rating": 5.0,
             "price": 16.99],
            
            // --- Dystopian ---
            ["title": "1984",
             "author": "George Orwell",
             "publishedDate": "08-06-1949",
             "genre": "Dystopian",
             "summary": """
            In a totalitarian society ruled by Big Brother, Winston Smith struggles for freedom and truth. \
            Surveillance, propaganda, and oppression dominate daily life. \
            Winston risks everything to rebel against the system, uncovering the harsh reality of a controlled world.
            """,
             "coverImage": "1984",
             "rating": 4.6,
             "price": 8.99],
            
            ["title": "Animal Farm",
             "author": "George Orwell",
             "publishedDate": "17-08-1945",
             "genre": "Dystopian",
             "summary": """
            The animals of Manor Farm revolt against their human farmer, seeking equality and justice. \
            However, power corrupts, and the pigs begin to resemble the oppressive humans they overthrew. \
            A sharp allegory on society, politics, and the nature of power.
            """,
             "coverImage": "animal_farm",
             "rating": 4.5,
             "price": 7.99],
            
            ["title": "Brave New World",
             "author": "Aldous Huxley",
             "publishedDate": "01-01-1932",
             "genre": "Dystopian",
             "summary": """
            A technologically advanced society controls citizens through conditioning and pleasure. \
            Individuality and emotion are suppressed in favor of social stability. \
            One man begins to question the system, seeking truth and authentic experience.
            """,
             "coverImage": "brave_new_world",
             "rating": 4.3,
             "price": 9.49],
            
            // Classic
            ["title": "War and Peace",
             "author": "Leo Tolstoy",
             "publishedDate": "01-01-1869",
             "genre": "Classic",
             "summary": """
            Set against the backdrop of Napoleonic wars, the novel follows the lives of Russian aristocracy. \
            Love, ambition, and fate intertwine as characters navigate personal and national crises. \
            Tolstoy explores philosophy, morality, and the human condition with unparalleled depth.
            """,
             "coverImage": "war_and_peace",
             "rating": 4.5,
             "price": 12.99],
            
            ["title": "Anna Karenina",
             "author": "Leo Tolstoy",
             "publishedDate": "01-01-1877",
             "genre": "Classic",
             "summary": """
            The tragic love story of Anna Karenina unfolds amid Russian high society. \
            Passion, betrayal, and social pressures shape her fate. \
            Tolstoy contrasts Anna's life with parallel narratives of family, morality, and societal expectation.
            """,
             "coverImage": "anna_karenina",
             "rating": 4.6,
             "price": 11.99],
            
            ["title": "Great Expectations",
             "author": "Charles Dickens",
             "publishedDate": "01-08-1861",
             "genre": "Classic",
             "summary": """
            Pip, an orphan, dreams of rising above his humble beginnings. \
            Through encounters with the eccentric Miss Havisham and the mysterious Magwitch, Pip learns life lessons. \
            Dickens weaves themes of ambition, love, and social class into a compelling narrative.
            """,
             "coverImage": "great_expectations",
             "rating": 4.4,
             "price": 9.99],
            
            ["title": "The Great Gatsby",
             "author": "F. Scott Fitzgerald",
             "publishedDate": "10-04-1925",
             "genre": "Classic",
             "summary": """
            Jay Gatsby, a mysterious millionaire, throws lavish parties in hopes of reuniting with his lost love, Daisy Buchanan. \
            Set during the roaring twenties, the novel explores themes of wealth, obsession, and the American Dream. \
            Gatsby's journey reveals the emptiness behind glamour and the consequences of longing for the unattainable.
            """,
             "coverImage": "gatsby",
             "rating": 4.4,
             "price": 6.99],
            
            ["title": "To Kill a Mockingbird",
             "author": "Harper Lee",
             "publishedDate": "11-07-1960",
             "genre": "Classic",
             "summary": """
            Scout Finch recounts her childhood in a racially divided Southern town. \
            Her father, Atticus, defends a black man accused of rape, teaching courage and morality. \
            The story explores justice, empathy, and the innocence of youth amidst prejudice.
            """,
             "coverImage": "mockingbird",
             "rating": 4.9,
             "price": 9.49],
            
            ["title": "Moby-Dick",
             "author": "Herman Melville",
             "publishedDate": "18-10-1851",
             "genre": "Classic",
             "summary": """
            Captain Ahab obsessively hunts the white whale, Moby Dick, seeking revenge for past injuries. \
            The crew faces perilous seas, moral dilemmas, and existential questions. \
            A tale of obsession, fate, and the struggle against nature's immensity.
            """,
             "coverImage": "mobydick",
             "rating": 4.1,
             "price": 7.99],
            
            ["title": "Pride and Prejudice",
             "author": "Jane Austen",
             "publishedDate": "28-01-1813",
             "genre": "Classic",
             "summary": """
            Elizabeth Bennet navigates society, manners, and romantic entanglements. \
            Her wit and intelligence challenge societal norms while she falls in love with the proud Mr. Darcy. \
            A timeless exploration of love, class, and personal growth.
            """,
             "coverImage": "pride_prejudice",
             "rating": 4.6,
             "price": 8.49],
            
            // Romance
            ["title": "Sense and Sensibility",
             "author": "Jane Austen",
             "publishedDate": "30-10-1811",
             "genre": "Romance",
             "summary": """
            The Dashwood sisters, Elinor and Marianne, experience love, heartbreak, and societal pressures after their father's death. \
            Their contrasting personalities navigate friendship, romance, and family obligations. \
            A delicate balance of emotion, reason, and societal expectations is explored.
            """,
             "coverImage": "sense_sensibility",
             "rating": 4.5,
             "price": 7.99],
            
            ["title": "The Notebook",
             "author": "Nicholas Sparks",
             "publishedDate": "01-10-1996",
             "genre": "Romance",
             "summary": """
            Noah Calhoun and Allie Nelson share a passionate summer romance. \
            Separated by circumstance, they are reunited decades later, proving the endurance of true love. \
            A heartfelt story of memory, devotion, and second chances.
            """,
             "coverImage": "notebook",
             "rating": 4.7,
             "price": 9.49],
            
            ["title": "Me Before You",
             "author": "Jojo Moyes",
             "publishedDate": "05-01-2012",
             "genre": "Romance",
             "summary": """
            Louisa Clark becomes a caregiver for the wealthy but paralyzed Will Traynor. \
            Their unlikely relationship challenges both of them to embrace life, love, and difficult choices. \
            A poignant story about courage, compassion, and heartbreak.
            """,
             "coverImage": "me_before_you",
             "rating": 4.6,
             "price": 10.99],
            
            ["title": "The Time Traveler's Wife",
             "author": "Audrey Niffenegger",
             "publishedDate": "05-03-2003",
             "genre": "Romance",
             "summary": """
            Henry has a rare genetic disorder that causes him to time travel unpredictably. \
            His wife Clare copes with his sudden disappearances while building a life of love and patience. \
            A complex and emotional exploration of destiny, love, and the passage of time.
            """,
             "coverImage": "time_travelers_wife",
             "rating": 4.5,
             "price": 10.49],
            
            ["title": "Emma",
             "author": "Jane Austen",
             "publishedDate": "23-12-1815",
             "genre": "Romance",
             "summary": """
            Emma Woodhouse is a confident young woman who enjoys matchmaking for her friends. \
            Her attempts at arranging love lead to humorous mistakes and personal growth. \
            Through self-awareness and understanding, Emma discovers true love and friendship.
            """,
             "coverImage": "emma",
             "rating": 4.4,
             "price": 7.49],
            
            ["title": "Outlander",
             "author": "Diana Gabaldon",
             "publishedDate": "06-08-1991",
             "genre": "Romance",
             "summary": """
            Nurse Claire Randall is transported from 1945 to 18th-century Scotland. \
            Caught between two worlds, she faces political intrigue, war, and forbidden love. \
            Her journey blends romance, adventure, and historical drama.
            """,
             "coverImage": "outlander",
             "rating": 4.7,
             "price": 10.99],
            
            //Thriller
            ["title": "Gone Girl",
             "author": "Gillian Flynn",
             "publishedDate": "24-05-2012",
             "genre": "Thriller",
             "summary": """
            Nick and Amy's seemingly perfect marriage shatters when Amy disappears. \
            Twists, lies, and secrets unfold as the investigation progresses. \
            A psychological thriller exploring deception, media influence, and human darkness.
            """,
             "coverImage": "gone_girl",
             "rating": 4.3,
             "price": 11.49],
            
            ["title": "The Girl with the Dragon Tattoo",
             "author": "Stieg Larsson",
             "publishedDate": "01-08-2005",
             "genre": "Thriller",
             "summary": """
            Journalist Mikael Blomkvist teams with hacker Lisbeth Salander to investigate a decades-old disappearance. \
            They uncover corruption, murder, and family secrets. \
            A gripping mystery with complex characters and dark intrigue.
            """,
             "coverImage": "dragon_tattoo",
             "rating": 4.5,
             "price": 12.99],
            
            ["title": "Shutter Island",
             "author": "Dennis Lehane",
             "publishedDate": "01-02-2003",
             "genre": "Thriller",
             "summary": """
            US Marshal Teddy Daniels investigates a missing patient case on Shutter Island. \
            As the investigation unfolds, psychological tension escalates and hidden truths emerge. \
            A suspenseful story with shocking twists and an unreliable perspective.
            """,
             "coverImage": "shutter_island",
             "rating": 4.2,
             "price": 10.99],
            
            ["title": "The Da Vinci Code",
             "author": "Dan Brown",
             "publishedDate": "18-03-2003",
             "genre": "Thriller",
             "summary": """
            Symbologist Robert Langdon uncovers a series of mysterious codes hidden in famous artworks. \
            As he races across Europe, he uncovers a secret society and a shocking conspiracy. \
            A fast-paced thriller blending history, religion, and suspense.
            """,
             "coverImage": "da_vinci_code",
             "rating": 4.2,
             "price": 11.99],
            
            ["title": "Angels & Demons",
             "author": "Dan Brown",
             "publishedDate": "01-05-2000",
             "genre": "Thriller",
             "summary": """
            Langdon investigates the mysterious murder of a physicist and uncovers a deadly conspiracy involving the Illuminati. \
            The story unfolds through secret passages and hidden clues in the Vatican. \
            A suspenseful tale of danger, intrigue, and intellectual challenge.
            """,
             "coverImage": "angels_demons",
             "rating": 4.1,
             "price": 10.99],
            
            ["title": "Inferno",
             "author": "Dan Brown",
             "publishedDate": "14-05-2013",
             "genre": "Thriller",
             "summary": """
            Langdon awakens in an Italian hospital with no memory of recent events. \
            He discovers a trail of clues related to Dante’s Inferno and a global bio-threat. \
            A pulse-pounding journey across Florence, Venice, and Istanbul to prevent catastrophe.
            """,
             "coverImage": "inferno",
             "rating": 4.0,
             "price": 12.49],
            
            //Historical
            ["title": "The Pillars of the Earth",
             "author": "Ken Follett",
             "publishedDate": "01-09-1989",
             "genre": "Historical Fiction",
             "summary": """
            Set in 12th-century England, the story follows the construction of a cathedral in Kingsbridge. \
            Characters navigate love, betrayal, and ambition amidst political turmoil. \
            A sprawling epic of human resilience, power, and faith.
            """,
             "coverImage": "pillars_earth",
             "rating": 4.7,
             "price": 13.99],
            
            ["title": "World Without End",
             "author": "Ken Follett",
             "publishedDate": "01-10-2007",
             "genre": "Historical Fiction",
             "summary": """
            The descendants of Kingsbridge face war, plague, and personal intrigue two centuries later. \
            The novel explores love, betrayal, and survival against a turbulent historical backdrop. \
            An immersive continuation of Follett's epic saga.
            """,
             "coverImage": "world_without_end",
             "rating": 4.6,
             "price": 14.49],
            
            ["title": "The Book Thief",
             "author": "Markus Zusak",
             "publishedDate": "14-03-2005",
             "genre": "Historical Fiction",
             "summary": """
            Liesel Meminger, a young girl in Nazi Germany, discovers the power of words and books. \
            She steals books to survive and to resist oppression, forging bonds with family and friends. \
            A touching story of humanity, courage, and the impact of literature.
            """,
             "coverImage": "book_thief",
             "rating": 4.8,
             "price": 11.99]
        ]
        
        for data in booksData {
            let book = BookEntity(context: context)
            book.title = data["title"] as? String
            book.author = data["author"] as? String
            if let dateString = data["publishedDate"] as? String {
                book.publishedDate = dateFormatter.date(from: dateString)
            }
            book.genre = data["genre"] as? String
            book.summary = data["summary"] as? String
            book.coverImage = data["coverImage"] as? String
            book.rating = data["rating"] as? Double ?? 0.0
            book.price = data["price"] as? Double ?? 0.0
            book.favorite = false
            book.inCart = false
        }
        
        do {
            try context.save()
            print("Sample books added successfully!")
        } catch {
            print("Failed to save sample books: \(error)")
        }
    }
}
