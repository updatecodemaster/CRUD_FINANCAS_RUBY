class Processo < ApplicationRecord
  STATUS = [
    "Em análise",
    "Aguardando documentos",
    "Em diligência",
    "Concluído",
    "Arquivado"
  ].freeze

  PRIORIDADES = ["Baixa", "Média", "Alta"].freeze

  NATUREZAS = [
    "Pedido de isenção",
    "Restituição tributária",
    "Parcelamento de débito",
    "Revisão de lançamento",
    "Cadastro fiscal"
  ].freeze

  SETORES = [
    "Atendimento",
    "Arrecadação",
    "Fiscalização",
    "Cadastro",
    "Dívida Ativa"
  ].freeze

  before_validation :preencher_numero, on: :create
  before_validation :preencher_campos_padrao

  validates :numero, :contribuinte, :cpf_cnpj, :natureza, :setor, :status,
    :prioridade, :aberto_em, presence: true
  validates :numero, uniqueness: true
  validates :status, inclusion: { in: STATUS }
  validates :prioridade, inclusion: { in: PRIORIDADES }
  validates :natureza, inclusion: { in: NATUREZAS }
  validates :setor, inclusion: { in: SETORES }
  validates :valor_estimado, numericality: { greater_than_or_equal_to: 0 }
  validate :prazo_nao_pode_anteceder_abertura

  scope :recentes, -> { order(aberto_em: :desc, created_at: :desc) }
  scope :por_status, ->(status) { where(status: status) }
  scope :vencidos, -> { where.not(status: ["Concluído", "Arquivado"]).where("prazo_em < ?", Date.current) }
  scope :busca, lambda { |termo|
    texto = "%#{sanitize_sql_like(termo.to_s.downcase)}%"

    where(
      "LOWER(numero) LIKE :texto OR LOWER(contribuinte) LIKE :texto OR LOWER(cpf_cnpj) LIKE :texto",
      texto: texto
    )
  }

  def vencido?
    prazo_em.present? && prazo_em < Date.current && !status.in?(["Concluído", "Arquivado"])
  end

  def prazo_humano
    return "Sem prazo definido" if prazo_em.blank?
    return "Vence hoje" if prazo_em == Date.current

    diferenca = (prazo_em - Date.current).to_i.abs
    texto_dias = diferenca == 1 ? "1 dia" : "#{diferenca} dias"

    prazo_em.future? ? "Faltam #{texto_dias}" : "Atrasado há #{texto_dias}"
  end

  private

  # Para o protótipo, o número segue uma sequência simples e legível.
  def preencher_numero
    self.numero = "SEFIN-RO-#{Date.current.year}-#{proximo_numero}" if numero.blank?
  end

  def preencher_campos_padrao
    self.status = STATUS.first if status.blank?
    self.prioridade = "Média" if prioridade.blank?
    self.aberto_em = Date.current if aberto_em.blank?
    self.valor_estimado = 0 if valor_estimado.blank?
  end

  def proximo_numero
    (Processo.maximum(:id).to_i + 1).to_s.rjust(4, "0")
  end

  def prazo_nao_pode_anteceder_abertura
    return if aberto_em.blank? || prazo_em.blank?

    errors.add(:prazo_em, "deve ser igual ou posterior à data de abertura") if prazo_em < aberto_em
  end
end
