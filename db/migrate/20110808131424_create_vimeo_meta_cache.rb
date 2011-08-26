class CreateVimeoMetaCache < ActiveRecord::Migration

  def self.up
    create_table :vimeo_meta_cache do |t|
      t.string :vid, :unique => true
      t.string :title
      t.text :description
      t.integer :image_id

      t.timestamps
    end

    add_index :vimeo_meta_cache, [:vid]

    load(Rails.root.join('db', 'seeds', 'vimeo_videos.rb'))
  end

  def self.down
    UserPlugin.destroy_all({:name => "vimeo_videos"})

    Page.delete_all({:link_url => "/vimeo_videos"})

    drop_table :vimeo_meta_cache
  end

end