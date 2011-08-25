class PagesController < ApplicationController
    before_filter :find_all_blog_posts, :except => [:archive]
    before_filter :find_blog_post, :only => [:show, :comment, :update_nav]
    before_filter :find_tags

  respond_to :html, :js, :rss
  # This action is usually accessed with the root path, normally '/'
  def home

    (@blog_posts = BlogPost.live.includes(:comments, :categories).all) if request.format.rss? 
      respond_with (@blog_posts) do |format|
        format.html
        format.rss
      end

    error_404 unless (@page = Page.where(:link_url => '/').first).present?
  end

  # This action can be accessed normally, or as nested pages.
  # Assuming a page named "mission" that is a child of "about",
  # you can access the pages with the following URLs:
  #
  #   GET /pages/about
  #   GET /about
  #
  #   GET /pages/mission
  #   GET /about/mission
  #
  def show
    @page = Page.find("#{params[:path]}/#{params[:id]}".split('/').last)

    if @page.try(:live?) || (refinery_user? && current_user.authorized_plugins.include?("refinery_pages"))
      # if the admin wants this to be a "placeholder" page which goes to its first child, go to that instead.
      if @page.skip_to_first_child && (first_live_child = @page.children.order('lft ASC').live.first).present?
        redirect_to first_live_child.url and return
      elsif @page.link_url.present?
        redirect_to @page.link_url and return
      end
    else
      error_404
    end
  end

    def find_blog_post
      unless (@blog_post = BlogPost.find(params[:id])).try(:live?)
        if refinery_user? and current_user.authorized_plugins.include?("refinerycms_blog")
          @blog_post = BlogPost.find(params[:id])
        else
          error_404
        end
      end
    end

    def find_all_blog_posts
      @blog_posts = BlogPost.live.includes(:comments, :categories).paginate({
        :page => params[:page],
        :per_page => RefinerySetting.find_or_set(:blog_posts_per_page, 10)
      })
    end

    def find_tags
      @tags = BlogPost.tag_counts_on(:tags)
    end




end
