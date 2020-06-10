import Foundation


class SidleSeeker {
    var matrix = [[Int]]()
    private var sidlesIndexes = [[Int]]() // array with indexes of sidles
    
    private enum Edge {
        case higher
        case lower
    }
    
    func createMatrix(rows: Int, columns: Int) {
        var arr = [[Int]](repeating: [Int](repeating: 0, count: columns), count: rows)
        for row in 0..<rows {
            for column in 0..<columns {
                arr[row][column] = Int.random(in: 0...115) // set range of dandom values could be func setRange(min: Int, max: Int) //where min < max"
            }
        }
        self.matrix = arr
    }
    // matrix test examples
    /*
    matrix = [[3,4,5,6,6,7],
              [1,1,1,1,1,1],
              [1,1,1,1,1,1],
              [1,1,1,1,1,1],
              [1,1,1,1,1,1]]
    matrix = [[3,4,5,6,6,7],
              [3,4,5,6,6,7],
              [1,1,1,1,1,1],
              [1,1,1,1,1,1],
              [1,1,1,1,1,1]]
    matrix = [[3,4,5,6,6,7],
              [1,1,1,1,1,1],
              [3,4,5,6,6,7],
              [3,4,5,6,6,7],
              [1,1,1,1,1,1]]
    matrix = [[3,4,5,6,6,7],
              [1,10,1,1,1,1],
              [1,1,1,100,1,1],
              [11,155,1,1,1,1],
              [1,111,1,1,111,1]]
    */

    private func isSidle(column: Int, edge: Edge, value: Int) -> Bool {
        for i in 0..<matrix.count {
            switch edge {
                case .lower :
                    if matrix[i][column] < value { //if highies in row/column higher then any in colum/row
                        return false
                    }
                case .higher:
                    if matrix[i][column] > value { // if lowest in row/column if lower in column/row
                        return false
                    }
            }
        }
        return true
    }

    func seek() {
        var count = 0
        for row in matrix {
            let indexMax = row.firstIndex(of: row.max()!)
            let indexMin = row.firstIndex(of: row.min()!)
            if isSidle(column: indexMin!, edge: .higher, value: row[indexMin!]) {
                sidlesIndexes.append([count, indexMin!])
            }
            if isSidle(column: indexMax!, edge: .lower, value: row[indexMax!]) {
                sidlesIndexes.append([count, indexMax!])
            }
            count += 1
        }
    }
    
    func pretyPrintMatrix() {
        for row in matrix {
            print(row)
        }
        print("\n\n")
    }
    
    func showResults() {
        print(sidlesIndexes)
        for sid in sidlesIndexes {
            print("value in matrix is \(matrix[sid[0]][sid[1]])")
        }
    }
    func seekUntilFind(rows: Int, columns: Int) {
        var count = 1
        while sidlesIndexes.isEmpty {
            sidleSeeker.createMatrix(rows: rows, columns: columns)
            sidleSeeker.seek()
            count += 1
        }
        print("generation attempts = \(count)")
        self.pretyPrintMatrix()
        self.showResults()
        self.clearResults()
    }
    func clearResults() {
        matrix = [[]]
        sidlesIndexes = [[]]
    }
}

let sidleSeeker = SidleSeeker()
sidleSeeker.seekUntilFind(rows:5, columns: 5)

