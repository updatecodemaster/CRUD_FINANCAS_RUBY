require_relative "../test_helper" unless defined?(ActiveSupport::TestCase)

class ProcessosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @processo = processos(:one)
  end

  test "should get index" do
    get processos_url
    assert_response :success
  end

  test "should get new" do
    get new_processo_url
    assert_response :success
  end

  test "should create processo" do
    assert_difference("Processo.count") do
      post processos_url, params: {
        processo: {
          aberto_em: @processo.aberto_em,
          contribuinte: "Mercado Central de Vilhena",
          cpf_cnpj: "33.333.333/0001-33",
          natureza: @processo.natureza,
          numero: "SEFIN-RO-2026-0199",
          prazo_em: @processo.prazo_em,
          prioridade: @processo.prioridade,
          resumo: @processo.resumo,
          setor: @processo.setor,
          status: @processo.status,
          valor_estimado: @processo.valor_estimado
        }
      }
    end

    assert_redirected_to processo_url(Processo.last)
  end

  test "should show processo" do
    get processo_url(@processo)
    assert_response :success
  end

  test "should get edit" do
    get edit_processo_url(@processo)
    assert_response :success
  end

  test "should update processo" do
    patch processo_url(@processo), params: { processo: { aberto_em: @processo.aberto_em, contribuinte: @processo.contribuinte, cpf_cnpj: @processo.cpf_cnpj, natureza: @processo.natureza, numero: @processo.numero, prazo_em: @processo.prazo_em, prioridade: @processo.prioridade, resumo: @processo.resumo, setor: @processo.setor, status: @processo.status, valor_estimado: @processo.valor_estimado } }
    assert_redirected_to processo_url(@processo)
  end

  test "should destroy processo" do
    assert_difference("Processo.count", -1) do
      delete processo_url(@processo)
    end

    assert_redirected_to processos_url
  end
end
