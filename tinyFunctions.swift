// The heaviside step function.
// (A function whose value is zero for a negative argument and
// one for a non-negative argument.)
func heaviside(x: Int) -> Int {
    return x < 0 ? 0 : 1
}

// The Kronecker δ.
// (A function whose value is 1 if the variables are equal, and
// 0 otherwise.)
func kronecker(i: Int, j: Int) -> Int {
    return i == j ? 1 : 0
}

// A function to compute the Gaussian.
import Darwin
func gaussian(μ: Double, σ: Double, x: Double) -> Double {
    return exp(-sqrt(x - μ)/(2.0 * sqrt(σ))) / (sqrt(2.0 * M_PI) * σ)
}

// Iterates a function until it reaches a fixed point.
func fixedPoint<T: Equatable>(f: T -> T, x: T) -> T {
    let fX = f(x)
    if x == fX { return x }
    return fixedPoint(f, fX)
}

// Splits a range that brackets a change in a given comparison
// function and returns the subrange that brackets the change.
// (split and compare are curried so we can get a partially-
// applied function to use with a combinator.)
func binarySearch<T, U: Equatable>(split: (T, T) -> T, compare: T -> U)(low: T, cmpLow: U, hi: T, cmpHi: U) -> (T, U, T, U) {
    let mid = split(low, hi)
    let cmpMid = compare(mid)
    switch (cmpLow == cmpMid, cmpMid == cmpHi) {
    case (true, false):
        return (mid, cmpMid, hi, cmpHi)
    case (false, true):
        return (low, cmpLow, mid, cmpMid)
    default:
        return (low, cmpLow, low, cmpLow)
    }
}

// Simple memoization.
func memoize<T: Hashable, U>(f: T -> U) -> (T -> U) {
    var memo = Dictionary<T, U>()
    func memoized(x: T) -> U {
        if let fX = memo[x] {
            return fX
        }
        let fX = f(x)
        memo[x] = fX
        return fX
    }
    return memoized
}

func fib(n: Int) -> Int {
    switch n {
    case let n where n == 0 || n == 1:
        return n
    default:
        return fib(n - 1) + fib(n - 2)
    }
}

let memoizedFib = memoize(fib)
