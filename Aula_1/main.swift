import Foundation

let listaNum = [1,2,3,4,5,0,0,0,-1,-2,-3]

var positivos = 0.0
var negativos = 0.0
var zeros = 0.0

for num in listaNum {
    if num > 0 {
        positivos += 1
    } else if num < 0 {
        negativos += 1
    } else {
        zeros += 1
    }
}
print("""
Positivos: \(positivos / Double(listaNum.count))
Negativos: \(negativos / Double(listaNum.count))
Zeros: \(zeros / Double(listaNum.count))
""")

print(String(format: "Positivos: %.2f, Negativos: %.2f, Zeros: %.2f", positivos / Double(listaNum.count), negativos / Double(listaNum.count), zeros / Double(listaNum.count)))