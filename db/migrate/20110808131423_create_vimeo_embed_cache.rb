class CreateVimeoEmbedCache < ActiveRecord::Migration

  def self.up
    create_table :vimeo_embed_cache do |t|
      t.string :vid
      t.string :code
      t.text :configuration
      t.timestamps
    end
    
    add_index :vimeo_embed_cache, [:vid]
  end

  def self.down
    drop_table :vimeo_embed_cache
  end

end