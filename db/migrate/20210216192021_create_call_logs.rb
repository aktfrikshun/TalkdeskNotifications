class CreateCallLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :call_logs do |t|
      t.string :call_id
      t.datetime :timestamp
      t.bigint :duration
      t.bigint :waiting_time
      t.string :agent_id
      t.string :agent_name
      t.string :agent_email
      t.string :caller_number
      t.string :cc_number
      t.string :direction
      t.string :customer_status

      t.timestamps
    end
  end
end
