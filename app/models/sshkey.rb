class Sshkey < ActiveRecord::Base
  validate :validate_key

  def validate_key
    sshkey_reg = /ssh-rsa\s+(\S+)\s(\S*)$/
    m = key.match(sshkey_reg)
    if !m
      errors.add(:key, 'Invalid')
      return
    end

    if name.empty?
      self.name=m[2]
    end
  end

  after_create :write_authorized_keys
  after_update :write_authorized_keys
  after_destroy :write_authorized_keys

  def write_authorized_keys 
    File.open("#{APP_CONFIG['authorized_keys_path']}/authorized_keys", 'w') do |file| 
      file.write(Sshkey.authorized_keys) 
    end
  end

  def self.authorized_keys
    "".tap do |result|
      Sshkey.all.each do |sskkey|
        result.concat "# --- #{sskkey.name}\n"
        result.concat "#{sskkey.key}\n"
      end
    end
  end
end
