namespace :cdn do
  desc "Rewrite CSS files under ./public/ with CDN-friendly URLs"
  task :css_urls => :environment do
    require 'cdn_helpers'
    require 'pathname'
    require 'logger'

    begin
      public_root_path = Pathname.new('public').realpath
      logger = Logger.new(STDOUT)
      logger.level = Logger::INFO
      FileList['public/**/*.css'].each do |css_file_path|
        css_file_path = Pathname.new(css_file_path).realpath
        public_path = Rails.root.join('public')
        CdnHelpers::CssRewriter.rewrite_css_file(css_file_path, public_path, logger)
      end
    rescue Errno::ENOENT
    end
  end
end
