User.find(:all).each do |user|
  if user.plugins.find_by_name('vimeo_videos').nil?
    user.plugins.create(:name => 'vimeo_videos',
                        :position => (user.plugins.maximum(:position) || -1) +1)
  end
end