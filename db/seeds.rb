# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
processos = [
  {
    numero: "SEFIN-RO-2026-0001",
    contribuinte: "Comercial Madeira Forte Ltda.",
    cpf_cnpj: "12.345.678/0001-90",
    natureza: "Revisão de lançamento",
    setor: "Fiscalização",
    status: "Em análise",
    prioridade: "Alta",
    valor_estimado: 18450.75,
    aberto_em: Date.current - 12.days,
    prazo_em: Date.current + 3.days,
    resumo: "Solicitação de revisão após divergência entre nota fiscal eletrônica e lançamento estadual."
  },
  {
    numero: "SEFIN-RO-2026-0002",
    contribuinte: "Agropecuária Rio Jamari",
    cpf_cnpj: "23.456.789/0001-10",
    natureza: "Parcelamento de débito",
    setor: "Arrecadação",
    status: "Aguardando documentos",
    prioridade: "Média",
    valor_estimado: 32780.00,
    aberto_em: Date.current - 8.days,
    prazo_em: Date.current + 6.days,
    resumo: "Contribuinte solicitou parcelamento e ficou de enviar demonstrativo financeiro atualizado."
  },
  {
    numero: "SEFIN-RO-2026-0003",
    contribuinte: "João Batista de Souza",
    cpf_cnpj: "123.456.789-00",
    natureza: "Pedido de isenção",
    setor: "Atendimento",
    status: "Em diligência",
    prioridade: "Baixa",
    valor_estimado: 0,
    aberto_em: Date.current - 5.days,
    prazo_em: Date.current + 10.days,
    resumo: "Pedido encaminhado para conferência de documentação complementar."
  },
  {
    numero: "SEFIN-RO-2026-0004",
    contribuinte: "Norte Transportes Eireli",
    cpf_cnpj: "34.567.890/0001-20",
    natureza: "Restituição tributária",
    setor: "Dívida Ativa",
    status: "Concluído",
    prioridade: "Média",
    valor_estimado: 7650.40,
    aberto_em: Date.current - 20.days,
    prazo_em: Date.current - 4.days,
    resumo: "Análise finalizada com parecer favorável parcial."
  }
]

processos.each do |dados|
  processo = Processo.find_or_initialize_by(numero: dados[:numero])
  processo.update!(dados)
end
