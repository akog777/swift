//export PATH="/workspaces/swift/swift-5.9.2-RELEASE-ubuntu22.04/usr/bin:$PATH"
import Foundation

// ============================
// DIA 1 - Estruturas Básicas
// ============================
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

enum NivelAluno: String {
    case iniciante = "Iniciante"
    case intermediario = "Intermediário"
    case avancado = "Avançado"
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
        let descricaoPai = super.getDescricao()
        return """
        \(descricaoPai)
        Matrícula: \(matricula)
        Plano: \(plano.nome)
        Nível: \(nivel.rawValue)
        """
    }
}

class Instrutor: Pessoa {
    var especialidade: String

    init(nome: String, email: String, especialidade: String) {
        self.especialidade = especialidade
        super.init(nome: nome, email: email)
    }

    override func getDescricao() -> String {
        return """
        \(super.getDescricao())
        Especialidade: \(especialidade)
        """
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

// ============================
// DIA 2 - Componentes, Contratos e Aulas
// ============================
protocol Manutencao {
    var nomeItem: String { get }
    var dataUltimaManutencao: String { get set }
    func realizarManutencao() -> Bool
}

class Aparelho: Manutencao {
    let nomeItem: String
    var dataUltimaManutencao: String = "Nenhuma"

    init(nomeItem: String) {
        self.nomeItem = nomeItem
    }

    func realizarManutencao() -> Bool {
        print("Realizando manutenção no aparelho: \(nomeItem)...")
        self.dataUltimaManutencao = "30/08/2025"
        print("Manutenção concluída em \(dataUltimaManutencao)")
        return true
    }
}

class Aula {
    let nome: String
    let instrutor: Instrutor

    init(nome: String, instrutor: Instrutor) {
        self.nome = nome
        self.instrutor = instrutor
    }

    func getDescricao() -> String {
        return "Aula: \(nome)\nInstrutor: \(instrutor.nome)"
    }
}

class AulaPersonal: Aula {
    let aluno: Aluno

    init(nome: String, instrutor: Instrutor, aluno: Aluno) {
        self.aluno = aluno
        super.init(nome: nome, instrutor: instrutor)
    }

    override func getDescricao() -> String {
        return """
        \(super.getDescricao())
        Aluno: \(aluno.nome)
        """
    }
}

class AulaColetiva: Aula {
    private(set) var alunosInscritos: [String: Aluno] = [:]
    let capacidadeMaxima: Int = 25

    func inscrever(aluno: Aluno) -> Bool {
        if alunosInscritos.count >= capacidadeMaxima {
            print("Turma cheia! Não foi possível inscrever \(aluno.nome).")
            return false
        }
        if alunosInscritos[aluno.matricula] != nil {
            print("O aluno \(aluno.nome) já está inscrito.")
            return false
        }
        alunosInscritos[aluno.matricula] = aluno
        print("\(aluno.nome) inscrito com sucesso na aula \(nome).")
        return true
    }

    override func getDescricao() -> String {
        return """
        \(super.getDescricao())
        Vagas ocupadas: \(alunosInscritos.count)/\(capacidadeMaxima)
        """
    }
}

// ============================
// TESTES
// ============================
let planoMensal = PlanoMensal()
let planoAnual = PlanoAnual()

let aluno1 = Aluno(nome: "Eduarda", email: "duda@email.com", matricula: "A1", plano: planoMensal)
aluno1.nivel = .iniciante

let aluno2 = Aluno(nome: "Pedro", email: "pedro@email.com", matricula: "B2", plano: planoAnual)
aluno2.nivel = .intermediario

let instrutor1 = Instrutor(nome: "João", email: "joao@academia.com", especialidade: "Personal Trainer")
let instrutor2 = Instrutor(nome: "Maria", email: "maria@academia.com", especialidade: "Personal Trainer")

print("""
===============================
    INFORMAÇÕES DA ACADEMIA
===============================
[ALUNO 1]
\(aluno1.getDescricao())
Mensalidade: R$ \(String(format: "%.2f", aluno1.plano.calcularMensalidade()))
-------------------------------
[ALUNO 2]
\(aluno2.getDescricao())
Mensalidade: R$ \(String(format: "%.2f", aluno2.plano.calcularMensalidade()))
-------------------------------
[INSTRUTOR]
\(instrutor1.getDescricao())
""")

// Teste de Aparelho
let esteira = Aparelho(nomeItem: "Esteira")
print("""
===============================
    INFORMAÇÕES DO APARELHO
===============================
Nome: \(esteira.nomeItem)
Última manutenção: \(esteira.dataUltimaManutencao)
""")
_ = esteira.realizarManutencao()

// Teste Aula Personal
let aulaPersonal = AulaPersonal(nome: "Musculação", instrutor: instrutor1, aluno: aluno1)
print("""
------------------------------- 
AULA PERSONAL
\(aulaPersonal.getDescricao())
_ = aulaPersonal.inscrever(aluno: aluno1)
""")

// Teste Aula Coletiva
let aulaColetiva = AulaColetiva(nome: "Yoga", instrutor: instrutor2)
_ = aulaColetiva.inscrever(aluno: aluno1)
_ = aulaColetiva.inscrever(aluno: aluno2)
print("""
-------------------------------
AULA COLETIVA
\(aulaColetiva.getDescricao())
""")
