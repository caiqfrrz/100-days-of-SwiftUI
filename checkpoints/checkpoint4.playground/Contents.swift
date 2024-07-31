import Cocoa

enum numberError : Error
{
    case outOfBounds, noRoot;
}

func squareRt(_ number: Int) throws -> Int
{
    for i in 1...100
    {
        if i * i == number
        {
            return i
        }
    }
    if number < 1 || number > 10_000
    {
        throw numberError.outOfBounds
    }
    else
    {
        throw numberError.noRoot
    }

}

let number = 10100

do
{
    let result = try squareRt(number)
} catch numberError.outOfBounds{
    print("Error, number is out of bounds")
} catch numberError.noRoot{
    print("Error, no root for this number")
} catch {
    print("Error, something occured")
}

