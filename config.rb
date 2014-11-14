require 'kramdown'
require 'extensions/sitemap.rb'
require 'zurb-foundation'
require 'gravatar-ultimate'

activate :sprockets

# Unfortunately ZURB puts its assets in unconventional paths, so we need to
# manually add these paths for sprockets to find them. However, the following
# only works within the middleman server but there doesn't seem to be any
# way to get sprockets to export the vendored assets within the foundation
# gem to the build directory because of the non-standard naming of the directories.
# Keeping this here for reference though.
#Gem.loaded_specs.values.map(&:full_gem_path).each do |root_path|
#  ["js", "scss"].map {|p| File.join(root_path, p) }.select {|p| File.directory?(p) }.each {|p| sprockets.append_path(p)}
#end

###
## Site-wide settings
####

set :full_name, "Tod Beardsley"
set :city, "Austin, Texas, USA"
set :resume, nil # Set to filename of resume PDF in source directory.
set :google_analytics_tracking_id, "UA-111111111-11"

###
## Social network link settings
###

# To hide one of these profile links, just set it to nil.

# This is the id for your profile URL: https://plus.google.com/https://plus.google.com/110506932842622114536/
set :google_plus_user_id, '110486794846061278031'
# This is your shortname for your profile URL: http://facebook.com/ada.lovelace
set :facebook_profile_name, nil
set :twitter_username, "todb"
# This is your shortname for your profile URL: http://linkedin.com/in/adalovelace
set :linkedin_profile_name, "todbeardsley"
set :dribbble_username, nil
set :github_username, "todb-r7"
set :gravatar_email_address, "todb@packetfu.com"

Time.zone = "America/Chicago"


###
# Deployment settings
###

activate :deploy do |deploy|
  deploy.method = :git
  deploy.branch = "master"
end

###
# Compass
###

# Susy grids in Compass
# First: gem install susy
# require 'susy'

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# With no layout
page "robots.txt", :layout => false
page "humans.txt", :layout => false

# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
activate :automatic_image_sizes

helpers do
  # Generate the markup for a responsive social network link.
  #
  # network_name    - The String name of the social network, e.g. "Facebook".
  # network_setting - The String variable set in this config file for the network,
  #                   e.g. facebook_profile_name.
  # url             - The String URL for the link.
  #
  # Returns the String markup.
  def social_network_link(network_name, network_setting, url)
    if network_setting
      <<-MARKUP
        <li>
          <a href='#{url}'>
            <span class='hide-for-small'><i class='icon-#{network_name.downcase.gsub(' ', '-')}'></i>
            </span><span class='show-for-small'>#{network_name}</span>
          </a>
        </li>
      MARKUP
    end
  end
end

# Generate sitemap after build
activate :sitemap_generator 

# Enable syntax highlighting
set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true
activate :syntax

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

# Build-specific configuration
configure :build do

  activate :minify_css        
  activate :minify_javascript

  # Enable cache buster
  # activate :cache_buster

  # Use relative URLs
  # activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end
