import Foundation

class Pessoa {
    let nome: String
    let email: String

    init(nome: String, email: String) {
        self.nome = nome
        self.email = email
    }

    func getDescricao() -> String {
        return "Nome: \(nome)\nEmail: \(email)"
    }
}

enum NivelAluno {
    case iniciante
    case intermediario
    case avancado

    var descricao: String {
        switch self {
        case .iniciante: 
            return "Iniciante"
        case .intermediario: 
            return "Intermediário"
        case .avancado: 
            return "Avançado"
        }
    }
}

class Aluno: Pessoa {
    let matricula: String
    var nivel: NivelAluno = .iniciante
    private(set) var plano: Plano

    init(nome: String, email: String, matricula: String, plano: Plano) {
        self.matricula = matricula
        self.plano = plano
        super.init(nome: nome, email: email)
    }
    override func getDescricao() -> String {
        let base = super.getDescricao()
        return "\(base)\nMatrícula: \(matricula)\nPlano: \(plano.nome)\nNível: \(nivel.descricao)"
    }
    func mensalidadeAtual() -> Double {
        return plano.calcularMensalidade()
    }
    func atualizarPlano(_ novoPlano: Plano) {
        self.plano = novoPlano
    }
}

class Instrutor: Pessoa {
    let especialidade: String

    init(nome: String, email: String, especialidade: String) {
        self.especialidade = especialidade
        super.init(nome: nome, email: email)
    }

    override func getDescricao() -> String {
        let base = super.getDescricao()
        return "\(base)\nEspecialidade: \(especialidade)"
    }
}



class Plano {
    let nome: String

    init(nome: String) {
        self.nome = nome
    }
    
    func calcularMensalidade() -> Double {
        return 0.0
    }
}

class PlanoMensal: Plano {
    init() {
        super.init(nome: "Plano Mensal")
    }

    override func calcularMensalidade() -> Double {
        return 120.0
    }
}

class PlanoAnual: Plano {
    init() {
        super.init(nome: "Plano Anual (Promocional)")
    }

    override func calcularMensalidade() -> Double {
        let valorMensalBase = 120.0
        let custoTotal12Meses = valorMensalBase * 12.0 // 1440
        let desconto = 0.20 // 20%
        let custoComDesconto = custoTotal12Meses * (1.0 - desconto) // 1152
        let valorMensalEquivalente = custoComDesconto / 12.0 // 96
        return valorMensalEquivalente
    }
}

let planoMensal = PlanoMensal()
let planoAnual = PlanoAnual()

let aluno1 = Aluno(nome: "João Silva", email: "joao@example.com", matricula: "A123", plano: planoMensal)
aluno1.nivel = .intermediario

let aluno2 = Aluno(nome: "Maria Souza", email: "maria@example.com", matricula: "B456", plano: planoAnual)
aluno2.nivel = .avancado

let instrutor = Instrutor(nome: "Carlos Pereira", email: "carlos@academia.com", especialidade: "Musculação")

print("--- Aluno 1 ---")
print(aluno1.getDescricao())
print(String(format: "Mensalidade: R$ %.2f\n", aluno1.mensalidadeAtual()))

print("--- Aluno 2 ---")
print(aluno2.getDescricao())
print(String(format: "Mensalidade: R$ %.2f\n", aluno2.mensalidadeAtual()))

print("--- Instrutor ---")
print(instrutor.getDescricao())