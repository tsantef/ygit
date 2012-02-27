class Repo < ActiveRecord::Base

  validates :name, :format => { :with => /\A[a-zA-Z0-9_]+\Z/, :message => "must contain only letters and numbers" }, :length => { :minimum => 4 }

  before_validation(:on => :create) do
    self.name = name.downcase if attribute_present?("name")
  end

  def git_url
    "#{APP_CONFIG['repo_host']}/#{name}.git"
  end

  def full_repo_path
    "#{APP_CONFIG['repo_path']}/#{name}.git"
  end

  def get_files_raw
    `cd #{full_repo_path} && git ls-tree -l -t master`  
  end

  def get_files
    raw = get_files_raw
    files = []
    raw.each_line do |line|
      /^\d+\s+(\S+?)\s[\S]+?\s+(\S+?)\s+(\S+)$/.match(raw)
      files << 1
    end
  end

  before_create do
    system "[ ! -e #{full_repo_path} ]"
    if $?.to_i == 0 
      system "mkdir -p #{full_repo_path}"
      system "cd #{full_repo_path} && git --bare init"
    end
  end

  before_destroy do
    system "rm -rf #{full_repo_path}"
  end
end
