require 'github_api'
require 'open-uri'
require 'pathname'

require_relative 'utils'

module SjIgnore
  class Builder
    def initialize(use_api)
      if use_api
        @contents = gh_load_remote
      else
        @contents = gh_load_local
      end
    end

    def download_files(langs)
      # Begin fetching each .gitignore file requested
      ignores = []

      # Fetch each file
      langs.each do |name|
        # Check if the requested language/platform is available in the list of
        # known .gitignore files
        if @contents.include? name.downcase
          ref = @contents[name]

          # Download the file
          open(ref.file_path, 'rb') do |file|
            content = file.read

            # Append the separator header before adding it to the downloaded list
            content = header(ref.name) + content

            ignores << content
          end
        else
          STDERR.puts "Cannot find a .gitignore file for: #{name}"
        end
      end

      # Join all .gitignore files together and print them to console
      return ignores.join "\n"
    end

    def list
      # Print out a list of all available .gitignore files
      @contents.keys.sort.each do |path, ref|
        print path + "\n"
      end
    end

    private

    def gh_load_local
      git_repo = 'https://github.com/github/gitignore.git'
      lib_dir = Pathname.new SjIgnore::Utils.gem_libdir
      gitignore_dir = lib_dir + 'gitignore/'

      if gitignore_dir.directory?
        `cd \"#{gitignore_dir}\"
         git pull`
      else
        `cd \"#{lib_dir}\"
         git clone \"#{git_repo}\"`
      end

      local_files = Dir[gitignore_dir + "*.gitignore"]
      global_files = Dir[gitignore_dir + "Global/*.gitignore"]

      contents = {}

      content_filter = Proc.new do |file|
        if file.include? '.gitignore'
          name = file.split('/').last.split('.').first.downcase
          contents[name] = IgnoreFile.new(file.split('/').last, file)
        end
      end

      local_files.each(&content_filter)
      global_files.each(&content_filter)

      contents
    end

    def gh_load_remote
      # Create an interface with github's repo of gitignore files and pull a list of
      # all of them
      github = Github.new
      contents_top = github.repos.contents.get user: 'github', repo: 'gitignore', path: '/'
      contents_global = github.repos.contents.get user: 'github', repo: 'gitignore', path: '/Global'
      contents = {}

      # Filter out all non-gitignore files and add them to a lookup map
      content_filter = Proc.new do |ref|
        if ref.path.include? '.gitignore'
          # Remove any possible path components and grab only the platform or
          # language part of the file name, which will be used later
          name = ref.path.split('/').last.split('.').first.downcase

          contents[name] = IgnoreFile.new(ref.path.split('/').last, ref.download_url)
        end
      end

      # Combine the two different directories of .gitignore files
      contents_top.each(&content_filter)
      contents_global.each(&content_filter)

      contents
    end

    # This just generates a custom header used to separate the different
    # .gitignore files once they are merged
    def header(lang)
      head =  "#" * 80    + "\n"
      head += "# #{lang}" + "\n"
      head += "#" * 80    + "\n"
      head += "\n"
    end
  end

  class IgnoreFile
    attr_accessor :name
    attr_accessor :file_path

    def initialize(name, file_path)
      self.name = name
      self.file_path = file_path
    end
  end
end
