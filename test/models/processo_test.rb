require_relative "../test_helper" unless defined?(ActiveSupport::TestCase)

class ProcessoTest < ActiveSupport::TestCase
  test "fixture principal é válida" do
    assert processos(:one).valid?
  end

  test "prazo não pode ser anterior à abertura" do
    processo = processos(:one).dup
    processo.numero = "SEFIN-RO-2026-0200"
    processo.aberto_em = Date.new(2026, 7, 10)
    processo.prazo_em = Date.new(2026, 7, 9)

    assert_not processo.valid?
    assert_includes processo.errors[:prazo_em], "deve ser igual ou posterior à data de abertura"
  end
end
