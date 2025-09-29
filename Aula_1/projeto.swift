//export PATH="/workspaces/swift/swift-5.9.2-RELEASE-ubuntu22.04/usr/bin:$PATH"(comando pra rodar o codigo)
import Foundation

class Pessoa {
    var nome: String
    var email: String

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
}

class Aluno: Pessoa {
    var matricula: String
    var nivel: NivelAluno = .iniciante
    private(set) var plano: Plano

    init(nome: String, email: String, matricula: String, plano: Plano) {
        self.matricula = matricula
        self.plano = plano
        super.init(nome: nome, email: email)
    }

    override func getDescricao() -> String {
        // Reutiliza a implementação da classe pai e adiciona novas informações
        let descricaoPai = super.getDescricao()
        return "\(descricaoPai)\nMatrícula: \(matricula)\nPlano: \(plano.nome)\nNível: \(nivel)"
    }
}

class Instrutor: Pessoa {
    var especialidade: String

    init(nome: String, email: String, especialidade: String) {
        self.especialidade = especialidade
        super.init(nome: nome, email: email)
    }

    override func getDescricao() -> String {
        // Reutiliza a implementação da classe pai e adiciona a especialidade
        return "\(super.getDescricao())\nEspecialidade: \(especialidade)"
    }
}

class Plano {
    var nome: String

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
        let custoTotalAnual = 12.0 * 120.0
        let custoComDesconto = custoTotalAnual * 0.80
        let mensalidade = custoComDesconto / 12.0
        return mensalidade
    }
}

// --- Exemplo de Uso ---
let planoMensal = PlanoMensal()
let planoAnual = PlanoAnual()

let aluno1 = Aluno(nome: "Carlos Silva", email: "carlos@email.com", matricula: "A123", plano: planoMensal)
let aluno2 = Aluno(nome: "Ana Souza", email: "ana@email.com", matricula: "A456", plano: planoAnual)
let instrutor1 = Instrutor(nome: "João Pereira", email: "joao.instrutor@academia.com", especialidade: "Musculação")

print("\n=============================")
print("   INFORMAÇÕES DA ACADEMIA")
print("=============================\n")

print("==== Aluno 1 ====")
print(aluno1.getDescricao())
print(String(format: "Mensalidade: R$ %.2f\n", aluno1.plano.calcularMensalidade()))

print("==== Aluno 2 ====")
aluno2.nivel = .intermediario
print(aluno2.getDescricao())
print(String(format: "Mensalidade: R$ %.2f\n", aluno2.plano.calcularMensalidade()))

print("==== Instrutor ====")
print(instrutor1.getDescricao())