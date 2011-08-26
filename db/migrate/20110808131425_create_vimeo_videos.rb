class CreateVimeoVideos < ActiveRecord::Migration

  def self.up
    create_table :vimeo_videos do |t|
      t.string :vid, :unique => true
      t.string :title
      t.text :description
      
      t.timestamps
    end

  end

  def self.down
    drop_table :vimeo_videos
  end

end