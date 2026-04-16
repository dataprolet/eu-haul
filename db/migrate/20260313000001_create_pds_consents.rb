class CreatePdsConsents < ActiveRecord::Migration[7.1]
  def change
    create_table :pds_consents do |t|
      t.string :did, null: false
      t.string :migration_token
      t.string :pds_host, null: false
      t.string :tos_url
      t.string :privacy_policy_url
      t.text :ip_address_ciphertext
      t.datetime :accepted_at, null: false

      t.timestamps
    end

    add_index :pds_consents, :did
    add_index :pds_consents, :migration_token
    add_index :pds_consents, :pds_host
  end
end
