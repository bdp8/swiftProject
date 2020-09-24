/* типовете зарове */
enum DiceColor: Int {

    case RED = 0, YELLOW, GREEN, Err
} 

/* типовете резулат*/
enum DiceResult: Int {
  case Point = 0, SecondThrow, Weapon, Error
}

/* Това са всички зарове, преди да се изтеглят се разбъркват всеки път*/
var arrayOfDices: [Int] = [0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2]

/* За всеки зар имаме неговият тип, колко от страните му носят точка, повторно хвърляне или бомба*/
class Dice {
    var color: DiceColor
    var countPoints: Int
    var countWeapons: Int
    var countSecondThrow: Int

    var arrayOfEvents: [Int] = []
    
    /* Създаваме зар, като обозначим неговия тип/цвят */
    init(clr: DiceColor )
    {
        self.color = clr
        if self.color == DiceColor.RED {
           self.countPoints = 1
           self.countWeapons = 3
           self.countSecondThrow = 2
        } else if self.color == DiceColor.YELLOW {
            self.countPoints = 2
            self.countWeapons = 2
            self.countSecondThrow = 2 
        } else {
            self.countPoints = 3
            self.countWeapons = 1
            self.countSecondThrow = 2
        }

        makeArray()
        
      }

    /* Правим масива на състоянията */
    func makeArray() {
     
        var i = 0
        for i in 0...self.countPoints-1 {
            self.arrayOfEvents.insert(1, at:i)
        }

        var k = 0
        for k in 0...self.countSecondThrow-1 {
            self.arrayOfEvents.insert(2, at:i)
            i+=1
        }

        var l = 0
        for l in 0...self.countWeapons-1 {
            self.arrayOfEvents.insert(3, at:i)
            i+=1
        }

        self.arrayOfEvents = self.arrayOfEvents.shuffled()
    }

    /* Хвърляме 1 зар и ни се връща резултатът от вхърлянето */
    func rollDice() -> DiceResult {
        
        if self.arrayOfEvents.count <= 0 
        { 
           return DiceResult.Error
        }
        
        let pickedIndex = Int.random(in: 0..<self.arrayOfEvents.count)

        switch self.arrayOfEvents[pickedIndex] {
          case 1 : 
              return DiceResult.Point
          case 2 :
              return DiceResult.SecondThrow
          case 3 :
              return DiceResult.Weapon
          default:
              return DiceResult.Error
        }

    }
}

/* Класът играч има име на играч, брой натрупани точки, 3 изтеглени зара и резултатът от тяхното хвърляне */
class Player
{

  var name : String
  var points : Int
  var firstDice : Dice
  var secondDice : Dice
  var thirdDice : Dice
  var resultAfterRoll: (DiceResult,DiceResult,DiceResult)

  /* Обектите от клас Player се инициализират с име на играч */
  init (name : String) 
  {
    self.name = name
    self.points = 0;
    self.resultAfterRoll = (DiceResult.Error, DiceResult.Error, DiceResult.Error)
    arrayOfDices = arrayOfDices.shuffled()

    var pickedIndex1 = Int.random(in: 0..<arrayOfDices.count)
    var pickedIndex2: Int 
    var pickedIndex3: Int

    repeat {
      pickedIndex2 = Int.random(in: 0..<arrayOfDices.count)
    }
    while pickedIndex2 == pickedIndex1 

    repeat {
      pickedIndex3 = Int.random(in: 0..<arrayOfDices.count)
    }
    while pickedIndex3 == pickedIndex1 || pickedIndex2 == pickedIndex3 

    let num1 = arrayOfDices[pickedIndex1]
    switch num1 {
      case 0: 
      self.firstDice = Dice(clr: .RED)
      case 1: 
      self.firstDice = Dice(clr: .YELLOW)
      case 2: 
      self.firstDice = Dice(clr: .GREEN)
      default:
      self.firstDice = Dice(clr: .Err)
    }
   
    let num2 = arrayOfDices[pickedIndex2]
    switch num2 {
      case 0: 
      self.secondDice = Dice(clr: .RED)
      case 1: 
      self.secondDice = Dice(clr: .YELLOW)
      case 2: 
      self.secondDice = Dice(clr: .GREEN)
      default:
      self.secondDice = Dice(clr: .Err)
    }

    let num3 = arrayOfDices[pickedIndex3]
    switch num3 {
      case 0: 
      self.thirdDice = Dice(clr: .RED)
      case 1: 
      self.thirdDice = Dice(clr: .YELLOW)
      case 2: 
      self.thirdDice = Dice(clr: .GREEN)
      default:
      self.thirdDice = Dice(clr: .Err)
    }

  }


  func rollAllDices()  {
    let first = self.firstDice.rollDice()
    let second = self.secondDice.rollDice()
    let third = self.thirdDice.rollDice()
    resultAfterRoll = (first, second, third) 
  }

  func rollAgainOneDice(num : Int) {
     
      switch num {
        case 1: 
            resultAfterRoll.0 = self.firstDice.rollDice()
        case 2:
            resultAfterRoll.1 = self.secondDice.rollDice()
        case 3:
            resultAfterRoll.2 = self.thirdDice.rollDice()
        default:
            print("bad data")
      }

  }


}

/* Тук имаме масив с всички играчи, брой играчи и булева променлива, която да ни оповести за победителя */
class Game {
   var players: [Player] = []
   var numOfPlayers: Int?
   var hasWinner: Bool = false

   init()
   {
     numOfPlayers = 0
   }
   
   /* тази функция стартира играта, очаква въвеждане на брой играчи и техните имена */ 
   func startGame() {
      print("==================")
      print("Welcome to Zombie Dice - a game made for brave and risky people. This game can be played by 2 to 8 players. Please let us know how many are the players?")

      self.numOfPlayers = Int(readLine()!)
      while self.numOfPlayers! < 2 || self.numOfPlayers! > 8
      {
        print("Type a number between 2 and 8")
        self.numOfPlayers = Int(readLine()!)
      }

      var i = 0
      for i in 0...self.numOfPlayers! - 1 {
        print("Enter a name for player ", i+1)
        let name = readLine()
        self.players.insert(Player(name: name!), at:i)
      }
   }

   /* стартира нова игра със същите настройки и играчи */ 
   func playAgain()
   {
     print("==================")
     print("Starting a new game with the same players...")
     var i = 0
     for i in 0...self.numOfPlayers! - 1 {
        self.players.insert(Player(name: players[i].name), at:i)
     }
     play()
   }

   /* Дава право на играча да хвърли наново заровете си */ 
   func rollAgain(i:Int) {
      players[i].rollAllDices()
      print("Result after second roll:\n")
      printDiceRes(i: i)

   }

   /* Край на ход на играч, добавят му се точките, ако има такива спечелени */ 
   func endTurn(i: Int) {

      if players[i].resultAfterRoll.0 == .Point
      {
        players[i].points += 1
      }

      if players[i].resultAfterRoll.1 == .Point
      {
        players[i].points += 1
      }

      if players[i].resultAfterRoll.2 == .Point
      {
        players[i].points += 1
      }

      if players[i].points >= 13
      {
        endOfGame(i:i)
      }
   }

   /* Има победител, дава право на избор между изцяло нова игра или отново същата */ 
   func endOfGame(i: Int) {
     print("==================")

     hasWinner = true
     print("We have a winner! Congrats to ", players[i].name)
     print("==================")

     print("Type in \"new game\" to start a new game with new settings")
     print("Type in \"play again\" to start new game with the old settings")
     

     var command = readLine();
    
     if command == "play again" {
       hasWinner = false
       playAgain()
     } else if command == "new game" {
       hasWinner = false
       startGame()
       play()
     }
   }

   /* Тук протича реално цялата игра */ 
   func play()
   {

     while !hasWinner {
       for i in 0...self.numOfPlayers! - 1 {
        print("==================")

        printScores()
        print("it's player's ", players[i].name, " turn")

        print("==================")

        printDiceColors(player:players[i])
        players[i].rollAllDices()
        printDiceRes(i: i)

        print("==================")

        if players[i].resultAfterRoll.0 == .Weapon && players[i].resultAfterRoll.1 == .Weapon && players[i].resultAfterRoll.2 == .Weapon {
          print("Bad luck - 3 shotguns, you lose your turn.")
          endTurn(i: i) 
          continue
        }
        print("If you want to end your turn here please type \"end turn\". ")
        print("If you have a dice with second roll option please type \"roll i\", where i is the periodic number of the dice")
        print("If you want roll all your dices again type \"roll again\". ")

        var command = readLine();
        
        
        while command != "end turn" {
          if command == "roll again" {
            rollAgain(i:i)
            printDiceRes(i: i)
            if players[i].resultAfterRoll.0 == .Weapon && players[i].resultAfterRoll.1 == .Weapon && players[i].resultAfterRoll.2 == .Weapon {
              endTurn(i: i) 
              continue
              }
          } else if command == "roll 1" {
            players[i].rollAgainOneDice(num:1)
            printDiceRes(i: i)
            if players[i].resultAfterRoll.0 == .Weapon && players[i].resultAfterRoll.1 == .Weapon && players[i].resultAfterRoll.2 == .Weapon {
                endTurn(i: i) 
                continue
                }
          } else if command == "roll 2" {
            players[i].rollAgainOneDice(num:2)
            printDiceRes(i: i)
            if players[i].resultAfterRoll.0 == .Weapon && players[i].resultAfterRoll.1 == .Weapon && players[i].resultAfterRoll.2 == .Weapon {
              endTurn(i: i) 
              continue
            }

          } else if command == "roll 3" {
            players[i].rollAgainOneDice(num:3)
            printDiceRes(i: i)
            if players[i].resultAfterRoll.0 == .Weapon && players[i].resultAfterRoll.1 == .Weapon && players[i].resultAfterRoll.2 == .Weapon {
                endTurn(i: i) 
                continue
            }
          }

          command = readLine();
        }

        pickNewDices(i:i)
        endTurn(i: i) 

      }
     }

   }
    
   /* избираме нови зарове за всеки нов ход на играч */ 
   func pickNewDices(i:Int)
   {
      arrayOfDices = arrayOfDices.shuffled()

      var pickedIndex1 = Int.random(in: 0..<arrayOfDices.count)
      var pickedIndex2: Int 
      var pickedIndex3: Int

      repeat {
        pickedIndex2 = Int.random(in: 0..<arrayOfDices.count)
      }
      while pickedIndex2 == pickedIndex1 

      repeat {
        pickedIndex3 = Int.random(in: 0..<arrayOfDices.count)
      }
      while pickedIndex3 == pickedIndex1 || pickedIndex2 == pickedIndex3 

      let num1 = arrayOfDices[pickedIndex1]
      switch num1 {
        case 0: 
        players[i].firstDice = Dice(clr: .RED)
        case 1: 
        players[i].firstDice = Dice(clr: .YELLOW)
        case 2: 
        players[i].firstDice = Dice(clr: .GREEN)
        default:
        players[i].firstDice = Dice(clr: .Err)
      }
   
    let num2 = arrayOfDices[pickedIndex2]
    switch num2 {
      case 0: 
      players[i].secondDice = Dice(clr: .RED)
      case 1: 
      players[i].secondDice = Dice(clr: .YELLOW)
      case 2: 
      players[i].secondDice = Dice(clr: .GREEN)
      default:
      players[i].secondDice = Dice(clr: .Err)
    }

    let num3 = arrayOfDices[pickedIndex3]
    switch num3 {
      case 0: 
      players[i].thirdDice = Dice(clr: .RED)
      case 1: 
      players[i].thirdDice = Dice(clr: .YELLOW)
      case 2: 
      players[i].thirdDice = Dice(clr: .GREEN)
      default:
      players[i].thirdDice = Dice(clr: .Err)
    }

   }
    
    
   func printScores() {
      var str:String=""
      for i in 0...self.numOfPlayers! - 1 {
          str += "| "
          str += String(players[i].points)
          str += " "
      }
      str += "|"

      print(str)
   }

   func printDiceColors(player: Player)
   {
      var str:String=""
      str += "| "
      switch player.firstDice.color{
        case .RED: 
            str += "red"
        case .GREEN:
            str += "green"
        case .YELLOW:
            str += "yellow"
        default:
            str += ""
      }
      str += " | "

      switch player.secondDice.color{
        case .RED: 
            str += "red"
        case .GREEN:
            str += "green"
        case .YELLOW:
            str += "yellow"
        default:
            str += ""
      }
      str += " | "

      switch player.thirdDice.color{
        case .RED: 
            str += "red"
        case .GREEN:
            str += "green"
        case .YELLOW:
            str += "yellow"
        default:
            str += ""
      }
      str += " |"

      print(str)
   }

   func printDiceRes(i: Int)
   {
      var str:String=""
      str += "( "
      switch players[i].resultAfterRoll.0{
        case .Point: 
            str += "point, "
        case .Weapon:
            str += "weapon, "
        case .SecondThrow:
            str += "secondRoll, "
        default:
            str += ""
      }

      switch players[i].resultAfterRoll.1{
        case .Point: 
            str += "point, "
        case .Weapon:
            str += "weapon, "
        case .SecondThrow:
            str += "secondRoll, "
        default:
            str += ""
      }

      switch players[i].resultAfterRoll.2{
        case .Point: 
            str += "point"
        case .Weapon:
            str += "weapon"
        case .SecondThrow:
            str += "secondRoll"
        default:
            str += ""
      }

      str += " )"

      print(str)
   }

}

let p = Game()
p.startGame()
p.play()
