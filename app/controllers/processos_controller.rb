class ProcessosController < ApplicationController
  before_action :set_processo, only: %i[ show edit update destroy ]

  def index
    @termo = params[:q].to_s.strip
    @status_atual = params[:status].presence
    @status_atual = nil unless Processo::STATUS.include?(@status_atual)

    @processos = Processo.recentes
    @processos = @processos.busca(@termo) if @termo.present?
    @processos = @processos.por_status(@status_atual) if @status_atual.present?

    # Os contadores ficam separados da busca para mostrar o tamanho real da fila.
    @total_processos = Processo.count
    @em_analise = Processo.por_status("Em análise").count
    @vencidos = Processo.vencidos.count
    @valor_total = Processo.sum(:valor_estimado)
  end

  def show
  end

  def new
    @processo = Processo.new
  end

  def edit
  end

  def create
    @processo = Processo.new(processo_params)

    if @processo.save
      redirect_to @processo, notice: "Processo cadastrado com sucesso."
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @processo.update(processo_params)
      redirect_to @processo, notice: "Processo atualizado com sucesso.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @processo.destroy!
    redirect_to processos_path, notice: "Processo removido com sucesso.", status: :see_other
  end

  private

    def set_processo
      @processo = Processo.find(params.expect(:id))
    end

    def processo_params
      params.expect(processo: [ :numero, :contribuinte, :cpf_cnpj, :natureza, :setor, :status, :prioridade, :valor_estimado, :aberto_em, :prazo_em, :resumo ])
    end
end
