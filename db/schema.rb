# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_07_09_183848) do
  create_table "processos", force: :cascade do |t|
    t.date "aberto_em", null: false
    t.string "contribuinte", null: false
    t.string "cpf_cnpj", null: false
    t.datetime "created_at", null: false
    t.string "natureza", null: false
    t.string "numero", null: false
    t.date "prazo_em"
    t.string "prioridade", null: false
    t.text "resumo"
    t.string "setor", null: false
    t.string "status", null: false
    t.datetime "updated_at", null: false
    t.decimal "valor_estimado", precision: 12, scale: 2, default: "0.0", null: false
    t.index ["cpf_cnpj"], name: "index_processos_on_cpf_cnpj"
    t.index ["numero"], name: "index_processos_on_numero", unique: true
    t.index ["status"], name: "index_processos_on_status"
  end
end
