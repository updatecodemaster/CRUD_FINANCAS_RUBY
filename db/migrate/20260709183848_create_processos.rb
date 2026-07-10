class CreateProcessos < ActiveRecord::Migration[8.1]
  def change
    create_table :processos do |t|
      t.string :numero, null: false
      t.string :contribuinte, null: false
      t.string :cpf_cnpj, null: false
      t.string :natureza, null: false
      t.string :setor, null: false
      t.string :status, null: false
      t.string :prioridade, null: false
      t.decimal :valor_estimado, precision: 12, scale: 2, default: 0, null: false
      t.date :aberto_em, null: false
      t.date :prazo_em
      t.text :resumo

      t.timestamps
    end

    add_index :processos, :numero, unique: true
    add_index :processos, :status
    add_index :processos, :cpf_cnpj
  end
end
