module ProcessosHelper
  def status_badge_class(status)
    case status
    when "Concluído"
      "badge badge-success"
    when "Arquivado"
      "badge badge-muted"
    when "Aguardando documentos"
      "badge badge-warning"
    when "Em diligência"
      "badge badge-info"
    else
      "badge badge-primary"
    end
  end

  def prioridade_badge_class(prioridade)
    case prioridade
    when "Alta"
      "badge badge-danger"
    when "Baixa"
      "badge badge-muted"
    else
      "badge badge-warning"
    end
  end

  def data_curta(data)
    data.present? ? data.strftime("%d/%m/%Y") : "-"
  end
end
