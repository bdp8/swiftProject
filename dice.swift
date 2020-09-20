/////
enum DiceColor: Int {

    case RED = 0, YELLOW, GREEN, Err
} 

enum DiceResult: Int {
  case Point = 0, SecondThrow, Weapon, Error
}

  var arrayOfDices: [Int] = [0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2]

class Dice {
    var color: DiceColor
    var countPoints: Int
    var countWeapons: Int
    var countSecondThrow: Int

    var arrayOfEvents: [Int] = []
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

class Player
{

  var name : String
  var points : Int
  var firstDice : Dice
  var secondDice : Dice
  var thirdDice : Dice
  var resultAfterRoll: (DiceResult,DiceResult,DiceResult)

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


class Game {
   var players: [Player] = []

   func startGame() {

   }

   func playAgain()
   {

   }

   func rollAgain() {

   }

   func endTurn() {

   }

   func endOfGame() {

   }

   func addPlayer()
   {
     
   }
}

let p = Player(name: "bogi")
p.rollAllDices()
